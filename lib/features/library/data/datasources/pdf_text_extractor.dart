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
      final pagesToExtract = maxPages < doc.pageCount
          ? maxPages
          : doc.pageCount;

      for (int i = 0; i < pagesToExtract; i++) {
        final page = await doc.getPage(i + 1);
        final text = await page.loadText();

        if (text != null) {
          buffer.writeln('--- Page ${i + 1} ---');
          buffer.writeln(text);
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
