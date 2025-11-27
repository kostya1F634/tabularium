import 'dart:io';
import 'package:path/path.dart' as path;

/// Abstraction for scanning directories for PDF files
abstract class PdfScannerDataSource {
  /// Scan directory and return list of PDF file paths
  Future<List<String>> scanDirectory(String directoryPath);
}

/// Implementation of PDF scanner
class PdfScannerDataSourceImpl implements PdfScannerDataSource {
  @override
  Future<List<String>> scanDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);

    if (!await directory.exists()) {
      throw Exception('Directory does not exist: $directoryPath');
    }

    final pdfFiles = <String>[];

    try {
      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          final extension = path.extension(entity.path).toLowerCase();
          if (extension == '.pdf') {
            pdfFiles.add(entity.path);
          }
        }
      }
    } catch (e) {
      throw Exception('Error scanning directory: $e');
    }

    return pdfFiles;
  }
}
