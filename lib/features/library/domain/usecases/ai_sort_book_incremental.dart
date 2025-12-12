import '../../../../core/services/ollama_client.dart';
import '../../../../core/services/ai_settings_service.dart';
import '../entities/book.dart';
import '../entities/shelf.dart';

/// Result of sorting a single book
class BookShelfAssignment {
  final String filePath;
  final String shelfName;
  final List<String> shelfTags; // Suggested tags for this shelf

  BookShelfAssignment({
    required this.filePath,
    required this.shelfName,
    this.shelfTags = const [],
  });
}

/// Use case for sorting a single book incrementally
class AISortBookIncremental {
  final AISettingsService aiSettings;

  AISortBookIncremental({required this.aiSettings});

  /// Sort a single book into an appropriate shelf
  Future<BookShelfAssignment> call({
    required Book book,
    required List<Shelf> existingShelves,
    required double generalization,
  }) async {
    // Create OllamaClient with current settings
    final ollamaClient = OllamaClient(
      baseUrl: aiSettings.ollamaUrl,
      model: aiSettings.ollamaModel,
    );

    // Get language instruction
    final languageNames = {'en': 'English', 'ru': 'Russian'};
    final outputLanguage =
        languageNames[aiSettings.outputLanguage] ?? 'English';

    // Prepare existing shelves (exclude default shelves)
    final userShelves = existingShelves
        .where((s) => !s.isDefault)
        .map((s) => s.name)
        .toList();

    // Create generalization guidance
    String shelfGuidance;
    if (generalization < 0.3) {
      shelfGuidance =
          'Prefer creating NEW specific shelves for narrow topics. Only reuse existing shelves if they\'re a perfect match.';
    } else if (generalization < 0.7) {
      shelfGuidance =
          'Balance between reusing existing shelves and creating new ones when needed.';
    } else {
      shelfGuidance =
          'Strongly prefer REUSING existing shelves. Only create new shelf if book doesn\'t fit any existing category.';
    }

    // Build prompt
    final prompt =
        '''You are a librarian organizing a book into a subject-based shelf.

🌐 LANGUAGE REQUIREMENT 🌐
Respond in $outputLanguage!
- Shelf name MUST be in $outputLanguage
- Tags MUST be in $outputLanguage
- Book title stays in ORIGINAL language

Book to organize:
Title: ${book.title ?? book.fileName}
Author: ${book.author ?? 'Unknown'}
Tags: ${book.tags.join(', ')}

${userShelves.isNotEmpty ? 'Existing shelves: ${userShelves.join(', ')}' : 'No existing shelves yet.'}

$shelfGuidance

⚠️ CRITICAL: Shelf name MUST be SUBJECT/TOPIC-based, NOT book title! ⚠️

GOOD shelf names (subject-based):
✓ "Programming" (for programming books)
✓ "History" (for history books)
✓ "Physics" (for physics books)
✓ "Russian Literature" (for Russian lit books)
✓ "Photography" (for photography books)
✓ "Computer Science" (for CS books)

BAD shelf names (book-specific):
✗ "The Art of Programming" (too specific - should be "Programming")
✗ "World War II History" (too specific - should be "History" or "Military History")
✗ "Introduction to Physics" (too specific - should be "Physics")
✗ Book title itself (NEVER use book title as shelf name!)

Think: "What SUBJECT does this book belong to?" not "What is this book called?"

Return ONLY valid JSON (no markdown):
{
  "shelf": "Subject/topic name in $outputLanguage",
  "tags": ["tag1", "tag2", "tag3"]
}

RULES:
- Shelf name: 1-3 words, describes SUBJECT AREA (not individual book!)
- Shelf should fit MULTIPLE books on same subject, not just this one book
- Tags: 3-7 tags that characterize this shelf's subject
- Use lowercase for tags
- If reusing existing shelf, use EXACT name from list above
- Tags should be in $outputLanguage language''';

    // JSON schema
    final format = {
      'type': 'object',
      'properties': {
        'shelf': {'type': 'string'},
        'tags': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      },
      'required': ['shelf', 'tags'],
    };

    // Ollama options
    final ollamaOptions = <String, dynamic>{
      'num_ctx': aiSettings.numCtx,
      'num_predict': 200, // Short response, just shelf name + tags
      'repeat_penalty': aiSettings.repeatPenalty,
      'repeat_last_n': 128,
      'top_k': aiSettings.topK,
      'top_p': aiSettings.topP,
    };

    // Add optional parameters
    if (aiSettings.presencePenalty > 0.0) {
      ollamaOptions['presence_penalty'] = aiSettings.presencePenalty;
    }
    if (aiSettings.frequencyPenalty > 0.0) {
      ollamaOptions['frequency_penalty'] = aiSettings.frequencyPenalty;
    }
    if (aiSettings.minP > 0.0) {
      ollamaOptions['min_p'] = aiSettings.minP;
    }
    if (aiSettings.seed != -1) {
      ollamaOptions['seed'] = aiSettings.seed;
    }

    // Get response from AI
    final response = await ollamaClient.generate(
      prompt: prompt,
      temperature: 0.3,
      format: format,
      options: ollamaOptions,
    );

    print(
      'DEBUG: Incremental sort for "${book.fileName}": shelf assignment response',
    );

    // Parse JSON response
    final json = ollamaClient.parseJsonResponse(response);
    final shelfName = json['shelf'] as String;
    final tags = (json['tags'] as List).map((e) => e.toString()).toList();

    return BookShelfAssignment(
      filePath: book.filePath,
      shelfName: shelfName,
      shelfTags: tags,
    );
  }
}
