import 'dart:io';
import 'dart:ui' as ui;
import 'package:pdfrx/pdfrx.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Abstraction for generating thumbnails from PDF files
abstract class ThumbnailGeneratorDataSource {
  /// Generate thumbnail for a PDF file and return the path to the thumbnail
  /// Returns null if thumbnail generation fails
  Future<String?> generateThumbnail({
    required String pdfPath,
    required String thumbnailsDirectory,
  });

  /// Check if thumbnail already exists for a PDF file
  Future<bool> thumbnailExists({
    required String pdfPath,
    required String thumbnailsDirectory,
  });

  /// Get thumbnail path for a PDF file (whether it exists or not)
  String getThumbnailPath({
    required String pdfPath,
    required String thumbnailsDirectory,
  });
}

/// Implementation of thumbnail generator using pdfrx
/// Renders first page of PDF to PNG image and saves to .thumbnails directory
class ThumbnailGeneratorDataSourceImpl implements ThumbnailGeneratorDataSource {
  static const double scale = 1.0; // Reduced to prevent memory issues

  @override
  Future<String?> generateThumbnail({
    required String pdfPath,
    required String thumbnailsDirectory,
  }) async {
    PdfDocument? doc;

    try {
      print('[ThumbnailGenerator] Starting thumbnail generation for: $pdfPath');

      final thumbnailPath = getThumbnailPath(
        pdfPath: pdfPath,
        thumbnailsDirectory: thumbnailsDirectory,
      );

      print('[ThumbnailGenerator] Target thumbnail path: $thumbnailPath');

      // Skip if thumbnail already exists
      if (await File(thumbnailPath).exists()) {
        print('[ThumbnailGenerator] Thumbnail already exists, skipping');
        return thumbnailPath;
      }

      // Create thumbnails directory if it doesn't exist
      final thumbnailDir = Directory(thumbnailsDirectory);
      if (!await thumbnailDir.exists()) {
        print(
          '[ThumbnailGenerator] Creating thumbnails directory: $thumbnailsDirectory',
        );
        await thumbnailDir.create(recursive: true);
      }

      // Check if PDF file exists
      final pdfFile = File(pdfPath);
      if (!await pdfFile.exists()) {
        print('[ThumbnailGenerator] PDF file does not exist: $pdfPath');
        return null;
      }

      print('[ThumbnailGenerator] Opening PDF document...');
      // Open PDF document
      doc = await PdfDocument.openFile(pdfPath);

      // Get first page (index 0)
      if (doc.pages.isEmpty) {
        print('[ThumbnailGenerator] PDF has no pages');
        return null;
      }

      print(
        '[ThumbnailGenerator] PDF loaded, pages count: ${doc.pages.length}',
      );
      final page = doc.pages[0];
      print(
        '[ThumbnailGenerator] First page size: ${page.width}x${page.height}',
      );

      // Render page to image
      print('[ThumbnailGenerator] Rendering page to image...');
      final pdfImage = await page.render(
        fullWidth: page.width * scale,
        fullHeight: page.height * scale,
      );

      if (pdfImage == null) {
        print('[ThumbnailGenerator] Failed to render page - pdfImage is null');
        return null;
      }

      print(
        '[ThumbnailGenerator] Page rendered: ${pdfImage.width}x${pdfImage.height}',
      );

      try {
        // Convert to ui.Image
        print('[ThumbnailGenerator] Converting to ui.Image...');
        final uiImage = await pdfImage.createImage();

        // Convert to PNG bytes
        print('[ThumbnailGenerator] Converting to PNG bytes...');
        final byteData = await uiImage.toByteData(
          format: ui.ImageByteFormat.png,
        );
        if (byteData == null) {
          print(
            '[ThumbnailGenerator] Failed to convert to PNG - byteData is null',
          );
          pdfImage.dispose();
          return null;
        }

        print(
          '[ThumbnailGenerator] PNG data size: ${byteData.lengthInBytes} bytes',
        );

        // Save to file
        print('[ThumbnailGenerator] Saving to file: $thumbnailPath');
        final file = File(thumbnailPath);
        await file.writeAsBytes(byteData.buffer.asUint8List());

        print('[ThumbnailGenerator] ✓ Thumbnail saved successfully');

        // Release resources
        pdfImage.dispose();
        doc.dispose();

        return thumbnailPath;
      } catch (e) {
        print('[ThumbnailGenerator] Error in image processing: $e');
        pdfImage.dispose();
        rethrow;
      }
    } catch (e, stackTrace) {
      // Log error but don't throw - some PDFs might be corrupted or encrypted
      print('[ThumbnailGenerator] ✗ Error generating thumbnail for $pdfPath:');
      print('[ThumbnailGenerator] Error: $e');
      print('[ThumbnailGenerator] Stack trace: $stackTrace');
      doc?.dispose();
      return null;
    }
  }

  @override
  Future<bool> thumbnailExists({
    required String pdfPath,
    required String thumbnailsDirectory,
  }) async {
    final thumbnailPath = getThumbnailPath(
      pdfPath: pdfPath,
      thumbnailsDirectory: thumbnailsDirectory,
    );
    return await File(thumbnailPath).exists();
  }

  @override
  String getThumbnailPath({
    required String pdfPath,
    required String thumbnailsDirectory,
  }) {
    // Generate a unique filename based on the PDF path hash
    final pdfFileNameWithoutExt = path.basenameWithoutExtension(pdfPath);

    // Use hash of full path to avoid collisions for files with same name
    final pathHash = md5
        .convert(utf8.encode(pdfPath))
        .toString()
        .substring(0, 8);
    final thumbnailFileName = '${pdfFileNameWithoutExt}_$pathHash.png';

    return path.join(thumbnailsDirectory, thumbnailFileName);
  }
}
