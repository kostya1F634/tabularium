import '../../../../core/services/ollama_client.dart';
import '../../../../core/services/ai_settings_service.dart';
import '../../data/datasources/pdf_text_extractor.dart';
import '../entities/book.dart';

/// Result of AI book analysis
class BookAnalysisResult {
  final String? title;
  final String? author;
  final List<String> tags;
  final String? reasoning; // LLM's explanation for tag choices

  BookAnalysisResult({
    this.title,
    this.author,
    this.tags = const [],
    this.reasoning,
  });

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
      reasoning: json['reasoning']?.toString(),
    );
  }
}

/// Use case for analyzing a single book with AI
class AIAnalyzeBook {
  final AISettingsService aiSettings;
  final PdfTextExtractor textExtractor;

  AIAnalyzeBook({required this.aiSettings, required this.textExtractor});

  /// Analyze a book and extract metadata
  Future<BookAnalysisResult> call(Book book) async {
    try {
      // Create OllamaClient with current settings
      final ollamaClient = OllamaClient(
        baseUrl: aiSettings.ollamaUrl,
        model: aiSettings.ollamaModel,
      );

      // Extract text from pages 2 to maxPages+1 (skip first page - usually cover)
      final fullText = await textExtractor.extractText(
        book.filePath,
        startPage: 2,
        maxPages: aiSettings.maxPages,
      );

      // Limit text to first 2000 characters to reduce token count
      final text = fullText.length > 2000
          ? fullText.substring(0, 2000) + '...'
          : fullText;

      // Get language instruction
      final languageNames = {'en': 'English', 'ru': 'Russian'};
      final outputLanguage =
          languageNames[aiSettings.outputLanguage] ?? 'English';

      // If no text extracted, analyze based on filename only
      final prompt = text.isNotEmpty
          ? '''You are a librarian analyzing a book. Based on the book's filename and the text from its first pages, extract the following information:

Filename: ${book.fileName}

Text from first pages (excerpt):
$text

Please analyze this book and return ONLY a JSON object with the following structure (no additional text, no markdown):
{
  "title": "The actual title of the book (keep in ORIGINAL language from the book)",
  "author": "The author's name (keep in ORIGINAL language from the book)",
  "tags": ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7", "tag8"],
  "reasoning": "2-3 sentences explaining: (1) what subject/genre this book belongs to, (2) why these specific tags were chosen and how they represent the book's main themes"
}

LANGUAGE INSTRUCTION:
- Tags and reasoning MUST be in $outputLanguage language
- Title and author MUST stay in the ORIGINAL language from the book (do not translate)

CRITICAL RULES FOR TAGS - Tags describe THIS SPECIFIC BOOK'S CONTENT:
- Prefer ONE WORD, use TWO WORDS only for established terms
- Create 8-12 UNIQUE tags that describe THIS BOOK SPECIFICALLY
- Tags must reflect ACTUAL content from the text, not generic categories
- **ORDER TAGS BY IMPORTANCE**: Most important/relevant topics FIRST
- Include 2-3 BROAD subject areas (genre/field) at the START
- Include 6-9 SPECIFIC topics that make THIS book unique
- Use lowercase only

IDENTIFY THE BOOK'S SUBJECT FIRST, then tag accordingly:
- Programming book? → language name, specific topics, paradigms
- Physics book? → subfield, concepts, applications
- History book? → period, region, events, figures
- Philosophy book? → philosopher, school, concepts, era
- Fiction book? → genre, themes, setting, style
- Business book? → field, strategies, concepts
- Art book? → movement, artist, medium, period

GOOD tags (specific to content):
- Programming: "rust", "concurrency", "ownership", "systems"
- Physics: "quantum", "relativity", "thermodynamics", "optics"
- History: "wwii", "rome", "medieval", "revolution", "napoleon"
- Philosophy: "kant", "ethics", "metaphysics", "enlightenment"
- Fiction: "scifi", "dystopia", "romance", "mystery", "thriller"
- Business: "marketing", "leadership", "startups", "finance"

BAD tags (generic/metadata):
- "pdf", "book", "file", "v2022", "z-lib.org", filename parts
- Author name as tag, duplicate words
- Generic words without context: "good", "important", "advanced"

Extract actual title and author from book content, not filename
Return JSON'''
          : '''You are a librarian analyzing a book. Based on the book's filename, try to extract information:

Filename: ${book.fileName}

Analyze and return JSON.

LANGUAGE INSTRUCTION:
- Tags and reasoning MUST be in $outputLanguage language
- Title and author MUST stay in the ORIGINAL language from the book (do not translate)

CRITICAL RULES FOR TAGS - Describe THIS BOOK SPECIFICALLY:
- Prefer ONE WORD, TWO WORDS for established terms
- Create 5-8 UNIQUE tags from filename analysis
- **ORDER BY IMPORTANCE**: Most relevant topics FIRST
- Tags must be SPECIFIC to this book's subject
- Use lowercase only
- Start with genre/field, then specific topics
- GOOD: subject-specific terms (see examples above)
- BAD: "pdf", "book", metadata, generic words''';

      // JSON schema for book analysis
      final format = {
        'type': 'object',
        'properties': {
          'title': {'type': 'string'},
          'author': {'type': 'string'},
          'tags': {
            'type': 'array',
            'items': {'type': 'string'},
          },
          'reasoning': {'type': 'string'},
        },
        'required': ['title', 'author', 'tags', 'reasoning'],
      };

      // Get response from AI
      final response = await ollamaClient.generate(
        prompt: prompt,
        temperature: 0.3,
        format: format,
      );
      print('DEBUG: LLM Response for book "${book.fileName}": $response');

      // Parse JSON response
      final json = ollamaClient.parseJsonResponse(response);
      print('DEBUG: Parsed book analysis: $json');

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
