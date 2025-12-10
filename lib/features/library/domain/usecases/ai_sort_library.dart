import 'dart:convert';
import '../../../../core/services/ollama_client.dart';
import '../entities/book.dart';
import '../entities/shelf.dart';

/// Result of library sorting
class LibrarySortResult {
  final List<ShelfAssignment> assignments;
  final List<String> newShelves;

  LibrarySortResult({required this.assignments, required this.newShelves});
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
  final OllamaClient ollamaClient;

  AISortLibrary({required this.ollamaClient});

  /// Sort all books into shelves using AI (two-stage approach)
  /// generalization: 0.0 = create many specific shelves, 1.0 = create few broad shelves
  Future<LibrarySortResult> call({
    required List<Book> books,
    required List<Shelf> existingShelves,
    required double generalization,
  }) async {
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
    if (generalization < 0.3) {
      generalizationGuidance =
          'Create MANY specific shelves (8-15 shelves). Focus on narrow topics.';
    } else if (generalization < 0.7) {
      generalizationGuidance =
          'Create MODERATE number of shelves (5-8 shelves). Balance specificity and breadth.';
    } else {
      generalizationGuidance =
          'Create FEW broad shelves (3-5 shelves). Group many related topics together.';
    }

    // Prepare books data with tags (for shelf creation)
    final booksData = books.map((book) {
      return {
        'title': (book.title ?? book.fileName).length > 80
            ? '${(book.title ?? book.fileName).substring(0, 77)}...'
            : (book.title ?? book.fileName),
        'tags': book.tags.take(5).toList(),
      };
    }).toList();

    // STAGE 1: Create shelves with their characteristic tags
    final shelfDefinitions = await _createShelves(
      booksData: booksData,
      allTags: allTags,
      existingShelves: userShelves,
      generalizationGuidance: generalizationGuidance,
    );

    print('DEBUG: Created ${shelfDefinitions.length} shelf definitions');
    for (final shelf in shelfDefinitions) {
      print('DEBUG: Shelf "${shelf.name}" with tags: ${shelf.tags.join(", ")}');
    }

    // STAGE 2: Assign each book to a shelf
    final assignments = <ShelfAssignment>[];
    for (var i = 0; i < books.length; i++) {
      final book = books[i];
      final assignment = await _assignBookToShelf(
        book: book,
        shelfDefinitions: shelfDefinitions,
        previousAssignments: assignments,
      );
      assignments.add(assignment);

      if ((i + 1) % 10 == 0 || i == books.length - 1) {
        print('DEBUG: Assigned ${i + 1}/${books.length} books');
      }
    }

    // Identify truly new shelves (not in existing)
    final existingShelfNames = userShelves.toSet();
    final newShelfNames = shelfDefinitions
        .map((s) => s.name)
        .where((name) => !existingShelfNames.contains(name))
        .toList();

    return LibrarySortResult(
      assignments: assignments,
      newShelves: newShelfNames,
    );
  }

  /// Stage 1: Create shelf definitions with characteristic tags
  Future<List<ShelfDefinition>> _createShelves({
    required List<Map<String, dynamic>> booksData,
    required Set<String> allTags,
    required List<String> existingShelves,
    required String generalizationGuidance,
  }) async {
    final prompt =
        '''You are a librarian organizing ${booksData.length} books into subject-based shelves.

EXISTING SHELVES (reuse if appropriate):
${existingShelves.isEmpty ? '(none)' : existingShelves.join(', ')}

ALL AVAILABLE TAGS FROM BOOKS:
${allTags.join(', ')}

BOOKS OVERVIEW (title and their tags):
${jsonEncode(booksData)}

STRATEGY:
$generalizationGuidance

TASK:
Analyze all book tags and create appropriate subject-based shelves.
For each shelf, define:
1. Shelf name (SUBJECTS/TOPICS/GENRES, not formats)
2. Characteristic tags for that shelf (3-7 tags from the available tags list)

CRITICAL RULES FOR SHELF TAGS:
- Each shelf must have UNIQUE tags - NO tag should appear in multiple shelves
- Tags should be ORDERED BY IMPORTANCE for that shelf (strongest/most defining first)
- Use tags from the AVAILABLE TAGS list only
- Choose tags that best characterize books belonging to that shelf
- More specific shelves need more specific tags

SHELF NAME RULES:
- Preferably ONE word for broad subjects
- Maximum TWO words for specific fields
- Use title case
- Examples: "Programming", "Web Development", "Physics", "History", "Philosophy", "Fiction"

Return JSON array of shelf definitions:
{
  "shelves": [
    {"name": "Programming", "tags": ["rust", "python", "concurrency", "algorithms"]},
    {"name": "Physics", "tags": ["quantum", "relativity", "mechanics"]},
    {"name": "History", "tags": ["wwii", "medieval", "rome"]}
  ]
}''';

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
      },
      'required': ['shelves'],
    };

    final response = await ollamaClient.generate(
      prompt: prompt,
      temperature: 0.3,
      format: format,
    );
    print('DEBUG: LLM Response for shelf creation: $response');

    final json = ollamaClient.parseJsonResponse(response);
    print('DEBUG: Parsed shelf creation: $json');

    if (json is! Map || !json.containsKey('shelves')) {
      throw Exception('Missing shelves in response');
    }

    final shelvesList = json['shelves'] as List;
    return shelvesList
        .map((s) => ShelfDefinition.fromJson(s as Map<String, dynamic>))
        .toList();
  }

  /// Stage 2: Assign a single book to the best matching shelf
  Future<ShelfAssignment> _assignBookToShelf({
    required Book book,
    required List<ShelfDefinition> shelfDefinitions,
    required List<ShelfAssignment> previousAssignments,
  }) async {
    // Prepare shelf info
    final shelvesInfo = shelfDefinitions.map((shelf) {
      return {'name': shelf.name, 'tags': shelf.tags};
    }).toList();

    // Prepare context of previously assigned books (last 5 for context)
    final recentAssignments = previousAssignments.length > 5
        ? previousAssignments.sublist(previousAssignments.length - 5)
        : previousAssignments;

    final assignmentContext = recentAssignments.isEmpty
        ? '(no previous assignments yet)'
        : recentAssignments
              .map(
                (a) => '  - "${a.filePath.split('/').last}" → ${a.shelfName}',
              )
              .join('\n');

    final prompt =
        '''You are a librarian assigning a book to the most appropriate shelf.

AVAILABLE SHELVES WITH THEIR CHARACTERISTIC TAGS:
${jsonEncode(shelvesInfo)}

BOOK TO ASSIGN:
- Title: ${book.title ?? book.fileName}
- Tags (ordered by importance): ${book.tags.join(', ')}

RECENT ASSIGNMENTS FOR CONTEXT:
$assignmentContext

TASK:
Determine which shelf best matches this book based on:
1. Compare book's tags (especially first 2-3 most important) with shelf tags
2. Choose the shelf whose tags best overlap with the book's main topics
3. If book's primary tags match multiple shelves, choose the one with strongest match

Return JSON with the assignment:
{
  "shelf": "Programming"
}''';

    final format = {
      'type': 'object',
      'properties': {
        'shelf': {'type': 'string'},
      },
      'required': ['shelf'],
    };

    final response = await ollamaClient.generate(
      prompt: prompt,
      temperature: 0.2,
      format: format,
    );

    final json = ollamaClient.parseJsonResponse(response);

    if (json is! Map || !json.containsKey('shelf')) {
      throw Exception('Missing shelf in assignment response');
    }

    final shelfName = json['shelf'] as String;

    return ShelfAssignment(filePath: book.filePath, shelfName: shelfName);
  }
}
