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
    return BookAnalysisResult(
      title: json['title'] as String?,
      author: json['author'] as String?,
      tags: json['tags'] != null ? List<String>.from(json['tags'] as List) : [],
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
    // Extract text from first few pages
    final text = await textExtractor.extractText(book.filePath, maxPages: 3);

    if (text.isEmpty) {
      throw Exception('Could not extract text from PDF');
    }

    // Create prompt for AI
    final prompt =
        '''You are a librarian analyzing a book. Based on the book's filename and the text from its first pages, extract the following information:

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
- Return ONLY the JSON, nothing else''';

    // Get response from AI
    final response = await ollamaClient.generate(prompt: prompt);

    // Parse JSON response
    final json = ollamaClient.parseJsonResponse(response);

    return BookAnalysisResult.fromJson(json);
  }
}
