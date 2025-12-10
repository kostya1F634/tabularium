import 'dart:convert';
import '../../../../core/services/ollama_client.dart';
import '../../../../core/services/ai_settings_service.dart';
import '../entities/book.dart';
import '../entities/shelf.dart';

/// Result of library sorting
class LibrarySortResult {
  final List<ShelfAssignment> assignments;
  final List<String> newShelves;
  final Map<String, List<String>> shelfTags; // shelfName -> tags mapping

  LibrarySortResult({
    required this.assignments,
    required this.newShelves,
    this.shelfTags = const {},
  });
}

/// Assignment of a book to a shelf
class ShelfAssignment {
  final String filePath;
  final String shelfName;

  ShelfAssignment({required this.filePath, required this.shelfName});

  factory ShelfAssignment.fromJson(Map<String, dynamic> json) {
    return ShelfAssignment(
      filePath: json['filePath'] as String,
      shelfName: json['shelf'] as String,
    );
  }
}

/// Shelf definition with characteristic tags
class ShelfDefinition {
  final String name;
  final List<String> tags;

  ShelfDefinition({required this.name, required this.tags});

  factory ShelfDefinition.fromJson(Map<String, dynamic> json) {
    final tagsList = json['tags'] as List;
    return ShelfDefinition(
      name: json['name'] as String,
      tags: tagsList.map((e) => e.toString()).toList(),
    );
  }
}

/// Use case for sorting entire library with AI (two-stage approach)
class AISortLibrary {
  final AISettingsService aiSettings;

  AISortLibrary({required this.aiSettings});

  /// Sort all books into shelves using AI (single-request approach)
  /// generalization: 0.0 = create many specific shelves, 1.0 = create few broad shelves
  Future<LibrarySortResult> call({
    required List<Book> books,
    required List<Shelf> existingShelves,
    required double generalization,
  }) async {
    // Create OllamaClient with current settings
    final ollamaClient = OllamaClient(
      baseUrl: aiSettings.ollamaUrl,
      model: aiSettings.ollamaModel,
    );

    // Collect all unique tags from all books
    final allTags = <String>{};
    for (final book in books) {
      allTags.addAll(book.tags);
    }

    // Prepare existing shelves
    final userShelves = existingShelves
        .where((s) => !s.isDefault)
        .map((s) => s.name)
        .toList();

    // Create generalization guidance
    String generalizationGuidance;
    String tagsPerShelfGuidance;

    if (generalization < 0.3) {
      generalizationGuidance =
          'Create MANY specific shelves (8-15 shelves). Focus on narrow topics.';
      tagsPerShelfGuidance = '2-4 SPECIFIC tags per shelf (narrow focus)';
    } else if (generalization < 0.7) {
      generalizationGuidance =
          'Create MODERATE number of shelves (5-8 shelves). Balance specificity and breadth.';
      tagsPerShelfGuidance = '4-7 tags per shelf (balanced coverage)';
    } else {
      generalizationGuidance =
          'Create FEW broad shelves (3-5 shelves). Group many related topics together.';
      tagsPerShelfGuidance =
          '7-12 BROAD tags per shelf (wide coverage, but still thematically related - e.g. "Programming" shelf should only have programming-related tags, not philosophy or fiction)';
    }

    // Prepare books data for sorting (filePath, title, tags, reasoning)
    final booksData = books.map((book) {
      final bookData = {
        'filePath': book.filePath,
        'title': (book.title ?? book.fileName).length > 80
            ? '${(book.title ?? book.fileName).substring(0, 77)}...'
            : (book.title ?? book.fileName),
        'tags': book.tags, // Include all tags, ordered by importance
      };
      // Include AI reasoning if available (helps understand book's subject)
      if (book.aiReasoning != null && book.aiReasoning!.isNotEmpty) {
        bookData['reasoning'] = book.aiReasoning!;
      }
      return bookData;
    }).toList();

    // SINGLE REQUEST: Create shelves AND assign books in one LLM call
    final result = await _sortLibraryInSingleRequest(
      ollamaClient: ollamaClient,
      booksData: booksData,
      allTags: allTags,
      existingShelves: userShelves,
      generalizationGuidance: generalizationGuidance,
      tagsPerShelfGuidance: tagsPerShelfGuidance,
    );

    print('DEBUG: Created ${result.newShelves.length} new shelves');
    print('DEBUG: Assigned ${result.assignments.length} books');

    return result;
  }

  /// Single-request approach: Create shelves and assign books in one LLM call
  /// This ensures every created shelf will have books assigned to it
  Future<LibrarySortResult> _sortLibraryInSingleRequest({
    required OllamaClient ollamaClient,
    required List<Map<String, dynamic>> booksData,
    required Set<String> allTags,
    required List<String> existingShelves,
    required String generalizationGuidance,
    required String tagsPerShelfGuidance,
  }) async {
    // Get language instruction
    final languageNames = {'en': 'English', 'ru': 'Russian'};
    final outputLanguage =
        languageNames[aiSettings.outputLanguage] ?? 'English';

    final prompt =
        '''You are a librarian organizing ${booksData.length} books into subject-based shelves.

EXISTING SHELVES (reuse if appropriate):
${existingShelves.isEmpty ? '(none)' : existingShelves.join(', ')}

ALL AVAILABLE TAGS FROM BOOKS:
${allTags.join(', ')}

BOOKS TO ORGANIZE (with filePath, title, tags ordered by importance, and reasoning where available):
${jsonEncode(booksData)}

NOTE: Some books include "reasoning" which explains the book's subject and why its tags were chosen. Use this context to better understand each book's main theme and make more accurate shelf assignments.

LANGUAGE INSTRUCTION:
- Shelf names and tags MUST be in $outputLanguage language
- Book titles should stay in their ORIGINAL language (they are already in original language in the input)

STRATEGY:
$generalizationGuidance
$tagsPerShelfGuidance

CRITICAL TASK:
You must do TWO things in ONE response:
1. Create appropriate subject-based shelves
2. Assign EVERY book to exactly ONE shelf

INPUT ANALYSIS:
- You have LARGE CONTEXT with all book information (titles, tags, reasoning)
- Tags are already ORDERED BY IMPORTANCE (first tags are most relevant)
- "reasoning" field (when present) explains book's subject and tag rationale
- Use this rich context to make informed decisions

IMPORTANT CONSTRAINTS:
- EVERY book must be assigned to a shelf
- EVERY shelf you create MUST have at least one book assigned to it
- Do NOT create shelves that will remain empty
- Books can only be assigned to shelves you create or existing shelves

SHELF CREATION RULES:
- Shelf names represent SUBJECTS/TOPICS/GENRES, not formats
- Preferably ONE word for broad subjects, maximum TWO words for specific fields
- Use title case (e.g., "Programming", "Web Development", "Physics")
- Follow the tags-per-shelf guidance above
- More specific shelves = fewer tags; broader shelves = more tags (but stay thematic)
- Even with many tags, maintain thematic coherence

BOOK ASSIGNMENT RULES:
- Match each book's FIRST 2-3 TAGS (most important) with shelf names/themes
- Books with similar primary tags should go to the same shelf
- Use the book's tag order as priority (first tags are most relevant)
- If a book doesn't fit existing/created shelves well, create a new appropriate shelf for it

Return JSON with shelves (with their characteristic tags), and complete assignments:
{
  "shelves": [
    {"name": "Programming", "tags": ["programming", "code", "software"]},
    {"name": "Physics", "tags": ["physics", "science", "mathematics"]},
    {"name": "History", "tags": ["history", "historical", "past"]}
  ],
  "assignments": [
    {"filePath": "/path/to/book1.pdf", "shelf": "Programming"},
    {"filePath": "/path/to/book2.pdf", "shelf": "Physics"},
    ...
  ]
}

Remember: EVERY book in the input MUST appear in assignments, and EVERY shelf MUST have books.''';

    final format = {
      'type': 'object',
      'properties': {
        'shelves': {
          'type': 'array',
          'items': {
            'type': 'object',
            'properties': {
              'name': {'type': 'string'},
              'tags': {
                'type': 'array',
                'items': {'type': 'string'},
              },
            },
            'required': ['name', 'tags'],
          },
        },
        'assignments': {
          'type': 'array',
          'items': {
            'type': 'object',
            'properties': {
              'filePath': {'type': 'string'},
              'shelf': {'type': 'string'},
            },
            'required': ['filePath', 'shelf'],
          },
        },
      },
      'required': ['shelves', 'assignments'],
    };

    final response = await ollamaClient.generate(
      prompt: prompt,
      temperature: 0.3,
      format: format,
    );

    print('DEBUG: LLM single-request response received');

    final json = ollamaClient.parseJsonResponse(response);
    print(
      'DEBUG: Parsed sorting result: shelves=${json['shelves']?.length}, assignments=${json['assignments']?.length}',
    );

    if (json is! Map ||
        !json.containsKey('shelves') ||
        !json.containsKey('assignments')) {
      throw Exception('Invalid response: missing shelves or assignments');
    }

    // Parse shelves with tags
    final shelfDefinitions = (json['shelves'] as List)
        .map((s) => ShelfDefinition.fromJson(s as Map<String, dynamic>))
        .toList();

    // Extract shelf names and tags
    final shelfList = shelfDefinitions.map((s) => s.name).toList();
    final shelfTagsMap = <String, List<String>>{};
    for (final shelf in shelfDefinitions) {
      shelfTagsMap[shelf.name] = shelf.tags;
    }

    // Parse assignments
    final assignmentsList = (json['assignments'] as List)
        .map((a) => ShelfAssignment.fromJson(a as Map<String, dynamic>))
        .toList();

    // Identify truly new shelves (not in existing)
    final existingShelfNames = existingShelves.toSet();
    final newShelfNames = shelfList
        .where((name) => !existingShelfNames.contains(name))
        .toList();

    return LibrarySortResult(
      assignments: assignmentsList,
      newShelves: newShelfNames,
      shelfTags: shelfTagsMap,
    );
  }
}
