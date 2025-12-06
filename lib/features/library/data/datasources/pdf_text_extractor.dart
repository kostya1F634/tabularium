import 'dart:io';
import 'package:pdfrx/pdfrx.dart';

/// Service for extracting text from PDF files
class PdfTextExtractor {
  /// Extract text from first N pages of a PDF file
  /// Returns the extracted text
  Future<String> extractText(String filePath, {int maxPages = 3}) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('File not found: $filePath');
      }

      // Open PDF document
      final doc = await PdfDocument.openFile(filePath);

      final buffer = StringBuffer();
      final totalPages = doc.pages.length;
      final pagesToExtract = maxPages < totalPages ? maxPages : totalPages;

      for (int i = 0; i < pagesToExtract; i++) {
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
