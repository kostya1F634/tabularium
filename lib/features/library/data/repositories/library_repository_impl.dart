import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../../domain/entities/book.dart';
import '../../domain/entities/library_config.dart';
import '../../domain/repositories/library_repository.dart';
import '../datasources/pdf_scanner_datasource.dart';
import '../datasources/thumbnail_generator_datasource.dart';
import '../datasources/config_datasource.dart';

/// Implementation of library repository
class LibraryRepositoryImpl implements LibraryRepository {
  static const String thumbnailsDir = '.thumbnails';

  final PdfScannerDataSource _pdfScanner;
  final ThumbnailGeneratorDataSource _thumbnailGenerator;
  final ConfigDataSource _configDataSource;

  LibraryRepositoryImpl({
    required PdfScannerDataSource pdfScanner,
    required ThumbnailGeneratorDataSource thumbnailGenerator,
    required ConfigDataSource configDataSource,
  })  : _pdfScanner = pdfScanner,
        _thumbnailGenerator = thumbnailGenerator,
        _configDataSource = configDataSource;

  @override
  Future<LibraryConfig> initializeLibrary(
    String directoryPath, {
    LibraryInitializationProgress? onProgress,
  }) async {
    print('[LibraryRepository] Initializing library for: $directoryPath');

    // Try to load existing config first
    final existingConfig = await loadLibrary(directoryPath);
    if (existingConfig != null) {
      print('[LibraryRepository] Found existing config with ${existingConfig.books.length} books');

      // Check if any books are missing thumbnails
      final booksNeedingThumbnails = existingConfig.books
          .where((book) => book.thumbnailPath == null)
          .toList();

      if (booksNeedingThumbnails.isNotEmpty) {
        print('[LibraryRepository] Found ${booksNeedingThumbnails.length} books without thumbnails');
        print('[LibraryRepository] Generating missing thumbnails...');

        final thumbnailsDirectory = path.join(directoryPath, thumbnailsDir);
        final updatedBooks = <Book>[];
        var savedCount = 0;

        for (var i = 0; i < existingConfig.books.length; i++) {
          final book = existingConfig.books[i];

          // Report progress
          onProgress?.call(i + 1, existingConfig.books.length);

          if (book.thumbnailPath == null) {
            print('[LibraryRepository] [${i + 1}/${existingConfig.books.length}] Generating thumbnail for: ${book.fileName}');

            try {
              final thumbnailPath = await _thumbnailGenerator.generateThumbnail(
                pdfPath: book.filePath,
                thumbnailsDirectory: thumbnailsDirectory,
              );

              if (thumbnailPath != null) {
                print('[LibraryRepository] ✓ Thumbnail generated');
                updatedBooks.add(book.copyWith(thumbnailPath: thumbnailPath));
              } else {
                print('[LibraryRepository] ✗ Failed to generate thumbnail');
                updatedBooks.add(book);
              }

              // Save config every 3 books to prevent data loss on crash
              if ((i + 1) % 3 == 0) {
                savedCount++;
                print('[LibraryRepository] Saving intermediate progress (${updatedBooks.length} books processed)...');
                final intermediateConfig = existingConfig.copyWith(
                  books: updatedBooks,
                  lastScanDate: DateTime.now(),
                );
                await saveLibrary(intermediateConfig);
                print('[LibraryRepository] ✓ Progress saved');

                // Small delay to allow memory cleanup
                await Future.delayed(const Duration(milliseconds: 500));
              }
            } catch (e, stackTrace) {
              print('[LibraryRepository] ✗ Exception while generating thumbnail: $e');
              print('[LibraryRepository] Stack trace: $stackTrace');
              updatedBooks.add(book);
            }
          } else {
            updatedBooks.add(book);
          }
        }

        final updatedConfig = existingConfig.copyWith(
          books: updatedBooks,
          lastScanDate: DateTime.now(),
        );

        print('[LibraryRepository] Saving final config...');
        await saveLibrary(updatedConfig);
        print('[LibraryRepository] ✓ All thumbnails processed (saved ${savedCount} times during process)');

        return updatedConfig;
      }

      // Scan for new books that might have been added
      final newBooks = await scanForNewBooks(existingConfig);
      if (newBooks.isNotEmpty) {
        print('[LibraryRepository] Found ${newBooks.length} new books');
        final updatedConfig = existingConfig.copyWith(
          books: [...existingConfig.books, ...newBooks],
          lastScanDate: DateTime.now(),
        );
        await saveLibrary(updatedConfig);
        return updatedConfig;
      }
      print('[LibraryRepository] No new books found');
      return existingConfig;
    }

    print('[LibraryRepository] No existing config, creating new one');

    // Create new config
    final config = LibraryConfig.empty(directoryPath);

    // Scan for PDF files
    print('[LibraryRepository] Scanning for PDF files...');
    final pdfPaths = await _pdfScanner.scanDirectory(directoryPath);
    print('[LibraryRepository] Found ${pdfPaths.length} PDF files');

    // Create books from PDFs
    final books = <Book>[];
    final thumbnailsDirectory = path.join(directoryPath, thumbnailsDir);

    print('[LibraryRepository] Processing ${pdfPaths.length} PDF files...');

    for (var i = 0; i < pdfPaths.length; i++) {
      final pdfPath = pdfPaths[i];

      // Report progress
      onProgress?.call(i + 1, pdfPaths.length);

      print('[LibraryRepository] Processing book ${i + 1}/${pdfPaths.length}: ${path.basename(pdfPath)}');

      final fileName = path.basename(pdfPath);
      final fileStats = await File(pdfPath).stat();

      // Generate unique ID from file path
      final id = _generateBookId(pdfPath);
      print('[LibraryRepository] Generated book ID: $id');

      // Generate thumbnail
      print('[LibraryRepository] Generating thumbnail...');
      final thumbnailPath = await _thumbnailGenerator.generateThumbnail(
        pdfPath: pdfPath,
        thumbnailsDirectory: thumbnailsDirectory,
      );

      if (thumbnailPath != null) {
        print('[LibraryRepository] ✓ Thumbnail generated: $thumbnailPath');
      } else {
        print('[LibraryRepository] ✗ Failed to generate thumbnail');
      }

      final book = Book(
        id: id,
        fileName: fileName,
        filePath: pdfPath,
        addedDate: DateTime.now(),
        lastOpenedDate: DateTime.now(),
        fileSize: fileStats.size,
        thumbnailPath: thumbnailPath,
      );

      books.add(book);
    }

    print('[LibraryRepository] Created ${books.length} book entries');

    final newConfig = config.copyWith(
      books: books,
      lastScanDate: DateTime.now(),
    );

    print('[LibraryRepository] Saving library config...');
    await saveLibrary(newConfig);
    print('[LibraryRepository] ✓ Library initialized successfully');

    return newConfig;
  }

  @override
  Future<LibraryConfig?> loadLibrary(String directoryPath) async {
    return await _configDataSource.loadConfig(directoryPath);
  }

  @override
  Future<void> saveLibrary(LibraryConfig config) async {
    await _configDataSource.saveConfig(config);
  }

  @override
  Future<List<Book>> scanForNewBooks(LibraryConfig config) async {
    // Get all PDF files in directory
    final pdfPaths = await _pdfScanner.scanDirectory(config.directoryPath);

    // Get existing book file paths
    final existingPaths = config.books.map((b) => b.filePath).toSet();

    // Find new PDFs
    final newPdfPaths = pdfPaths.where((p) => !existingPaths.contains(p)).toList();

    if (newPdfPaths.isEmpty) {
      return [];
    }

    // Create books from new PDFs
    final newBooks = <Book>[];
    final thumbnailsDirectory = path.join(config.directoryPath, thumbnailsDir);

    for (final pdfPath in newPdfPaths) {
      final fileName = path.basename(pdfPath);
      final fileStats = await File(pdfPath).stat();

      final id = _generateBookId(pdfPath);

      final thumbnailPath = await _thumbnailGenerator.generateThumbnail(
        pdfPath: pdfPath,
        thumbnailsDirectory: thumbnailsDirectory,
      );

      final book = Book(
        id: id,
        fileName: fileName,
        filePath: pdfPath,
        addedDate: DateTime.now(),
        lastOpenedDate: DateTime.now(),
        fileSize: fileStats.size,
        thumbnailPath: thumbnailPath,
      );

      newBooks.add(book);
    }

    return newBooks;
  }

  @override
  Future<String?> generateThumbnail({
    required String pdfPath,
    required String directoryPath,
  }) async {
    final thumbnailsDirectory = path.join(directoryPath, thumbnailsDir);
    return await _thumbnailGenerator.generateThumbnail(
      pdfPath: pdfPath,
      thumbnailsDirectory: thumbnailsDirectory,
    );
  }

  @override
  Future<void> openBook(String filePath) async {
    try {
      await OpenFilex.open(filePath);
    } catch (e) {
      throw Exception('Error opening book: $e');
    }
  }

  @override
  Future<void> openAllBooks(List<Book> books) async {
    for (final book in books) {
      await openBook(book.filePath);
      // Small delay between opening files to avoid overwhelming the system
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Generate unique book ID from file path
  String _generateBookId(String filePath) {
    return md5.convert(utf8.encode(filePath)).toString();
  }
}
