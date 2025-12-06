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

/// Use case for sorting entire library with AI
class AISortLibrary {
  final OllamaClient ollamaClient;

  AISortLibrary({required this.ollamaClient});

  /// Sort all books into shelves using AI
  /// generalization: 0.0 = create many specific shelves, 1.0 = create few broad shelves
  Future<LibrarySortResult> call({
    required List<Book> books,
    required List<Shelf> existingShelves,
    required double generalization,
  }) async {
    // Prepare books data for AI
    final booksData = books.map((book) {
      return {
        'filePath': book.filePath,
        'title': book.title ?? book.fileName,
        'author': book.author,
        'tags': book.tags,
      };
    }).toList();

    // Prepare existing shelves data (exclude default shelves)
    final userShelves = existingShelves
        .where((s) => !s.isDefault)
        .map((s) => s.name)
        .toList();

    // Create generalization guidance
    String generalizationGuidance;
    if (generalization < 0.3) {
      generalizationGuidance =
          'Create MANY specific, narrow shelves. Each shelf should focus on a very specific topic or genre. It is better to have many small, focused shelves than few large ones.';
    } else if (generalization < 0.7) {
      generalizationGuidance =
          'Create a MODERATE number of shelves. Balance between specificity and generalization. Group related topics together but keep distinct themes separate.';
    } else {
      generalizationGuidance =
          'Create FEW broad, general shelves. Each shelf should encompass a wide range of related topics. Maximize grouping of books into common themes.';
    }

    // Create prompt
    final prompt =
        '''You are a professional librarian organizing a library. You need to categorize ${books.length} books into shelves.

EXISTING SHELVES:
${userShelves.isEmpty ? '(none)' : userShelves.join(', ')}

ORGANIZATION STRATEGY:
$generalizationGuidance

BOOKS TO ORGANIZE:
${jsonEncode(booksData)}

INSTRUCTIONS:
1. Analyze each book's title, author, and tags
2. ${userShelves.isNotEmpty ? 'First try to use existing shelves' : 'Create appropriate shelf names'}
3. Create new shelves ONLY when needed
4. Do NOT create a separate shelf for each book
5. Group related books together
6. Shelf names should be clear, concise, and descriptive (2-3 words max)

Return ONLY a JSON object with this exact structure (no markdown, no additional text):
{
  "assignments": [
    {"filePath": "/path/to/book.pdf", "shelf": "Shelf Name"},
    ...
  ]
}

Important: Every book MUST be assigned to exactly one shelf.''';

    // Get response from AI
    final response = await ollamaClient.generate(
      prompt: prompt,
      temperature: 0.3, // Lower temperature for more consistent output
    );

    // Parse response
    final json = ollamaClient.parseJsonResponse(response);

    if (!json.containsKey('assignments')) {
      throw Exception('Invalid AI response: missing assignments');
    }

    final assignmentsList = json['assignments'] as List;
    final assignments = assignmentsList
        .map((a) => ShelfAssignment.fromJson(a as Map<String, dynamic>))
        .toList();

    // Identify new shelves
    final allShelfNames = assignments.map((a) => a.shelfName).toSet();
    final newShelfNames = allShelfNames
        .where((name) => !userShelves.contains(name))
        .toList();

    return LibrarySortResult(
      assignments: assignments,
      newShelves: newShelfNames,
    );
  }
}
