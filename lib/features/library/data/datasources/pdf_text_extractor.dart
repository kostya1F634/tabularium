import 'dart:io';
import 'package:pdfrx/pdfrx.dart';

/// Service for extracting text from PDF files
class PdfTextExtractor {
  /// Extract text from PDF file
  /// [startPage] - 1-based page number to start from (default: 1)
  /// [maxPages] - maximum number of pages to extract (default: 3)
  /// Returns the extracted text
  Future<String> extractText(
    String filePath, {
    int startPage = 1,
    int maxPages = 3,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('File not found: $filePath');
      }

      // Open PDF document
      final doc = await PdfDocument.openFile(filePath);

      final buffer = StringBuffer();
      final totalPages = doc.pages.length;

      // Convert 1-based startPage to 0-based index
      final startIndex = (startPage - 1).clamp(0, totalPages - 1);
      final endIndex = (startIndex + maxPages).clamp(0, totalPages);

      for (int i = startIndex; i < endIndex; i++) {
        final page = doc.pages[i];
        final text = await page.loadText();

        final textString = text.fullText;
        if (textString.isNotEmpty) {
          buffer.writeln('--- Page ${i + 1} ---');
          buffer.writeln(textString);
          buffer.writeln();
        }
      }

      doc.dispose();

      return buffer.toString();
    } catch (e) {
      print('Error extracting text from PDF: $e');
      return '';
    }
  }
}
