import '../../../../core/services/ollama_client.dart';
import '../../data/datasources/pdf_text_extractor.dart';
import '../entities/book.dart';

/// Result of AI book analysis
class BookAnalysisResult {
  final String? title;
  final String? author;
  final List<String> tags;

  BookAnalysisResult({this.title, this.author, this.tags = const []});

  factory BookAnalysisResult.fromJson(Map<String, dynamic> json) {
    List<String> parseTags(dynamic tagsData) {
      if (tagsData == null) return [];
      if (tagsData is List) {
        return tagsData
            .map((tag) => tag is String ? tag : tag.toString())
            .toList();
      }
      if (tagsData is String) return [tagsData];
      return [];
    }

    return BookAnalysisResult(
      title: json['title']?.toString(),
      author: json['author']?.toString(),
      tags: parseTags(json['tags']),
    );
  }
}

/// Use case for analyzing a single book with AI
class AIAnalyzeBook {
  final OllamaClient ollamaClient;
  final PdfTextExtractor textExtractor;

  AIAnalyzeBook({required this.ollamaClient, required this.textExtractor});

  /// Analyze a book and extract metadata
  Future<BookAnalysisResult> call(Book book) async {
    try {
      // Extract text from first few pages
      final text = await textExtractor.extractText(book.filePath, maxPages: 3);

      // If no text extracted, analyze based on filename only
      final prompt = text.isNotEmpty
          ? '''You are a librarian analyzing a book. Based on the book's filename and the text from its first pages, extract the following information:

Filename: ${book.fileName}

Text from first pages:
$text

Please analyze this book and return ONLY a JSON object with the following structure (no additional text, no markdown):
{
  "title": "The actual title of the book",
  "author": "The author's name",
  "tags": ["tag1", "tag2", "tag3"]
}

Guidelines:
- Extract the real title from the content, not just the filename
- Identify the author if mentioned
- Create 3-5 descriptive tags that characterize this book (genre, topic, subject matter)
- Tags should be concise, single words or short phrases
- Return ONLY the JSON, nothing else'''
          : '''You are a librarian analyzing a book. Based on the book's filename, try to extract information:

Filename: ${book.fileName}

Please analyze this filename and return ONLY a JSON object with the following structure (no additional text, no markdown):
{
  "title": "The title you can extract from filename",
  "author": "The author if you can identify from filename",
  "tags": ["tag1", "tag2", "tag3"]
}

Guidelines:
- Extract what you can from the filename
- Create 3-5 descriptive tags based on what you can infer
- Tags should be concise, single words or short phrases
- Return ONLY the JSON, nothing else''';

      // Get response from AI
      final response = await ollamaClient.generate(prompt: prompt);

      // Parse JSON response
      final json = ollamaClient.parseJsonResponse(response);

      return BookAnalysisResult.fromJson(json);
    } catch (e) {
      // If analysis fails completely, return minimal result
      return BookAnalysisResult(
        title: book.fileName.replaceAll('.pdf', ''),
        author: null,
        tags: [],
      );
    }
  }
}
