import '../entities/book.dart';
import '../entities/library_config.dart';

/// Progress callback for library initialization
/// [current] - current number of processed books
/// [total] - total number of books to process
typedef LibraryInitializationProgress = void Function(int current, int total);

/// Repository for managing library data and configuration
abstract class LibraryRepository {
  /// Initialize library for a directory
  /// Scans for PDFs, generates thumbnails, creates/loads config
  /// [onProgress] - optional callback to report progress
  Future<LibraryConfig> initializeLibrary(
    String directoryPath, {
    LibraryInitializationProgress? onProgress,
  });

  /// Load existing library config
  Future<LibraryConfig?> loadLibrary(String directoryPath);

  /// Save library config
  Future<void> saveLibrary(LibraryConfig config);

  /// Scan directory for new PDF files and add them to the library
  Future<List<Book>> scanForNewBooks(LibraryConfig config);

  /// Generate thumbnail for a book
  Future<String?> generateThumbnail({
    required String pdfPath,
    required String directoryPath,
  });

  /// Open book with system default viewer
  Future<void> openBook(String filePath);

  /// Open all books in directory
  Future<void> openAllBooks(List<Book> books);
}
