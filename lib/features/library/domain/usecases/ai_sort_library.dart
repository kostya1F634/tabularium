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
      // Include AI reasoning if available and enabled (helps understand book's subject)
      if (aiSettings.includeBookReasoning &&
          book.aiReasoning != null &&
          book.aiReasoning!.isNotEmpty) {
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

  /// Incremental sorting: Process books one at a time
  /// More reliable and debuggable, but slower
  /// Progress callback called after each book is processed
  Future<LibrarySortResult> callIncremental({
    required List<Book> books,
    required List<Shelf> existingShelves,
    required double generalization,
    void Function(int current, int total)? onProgress,
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

    // Determine tag matching strictness based on generalization
    final String matchingGuidance;
    final int minMatchingTags;

    if (generalization < 0.3) {
      // Low generalization = strict matching = many specific shelves
      matchingGuidance =
          'Be STRICT with matching. Only match if book fits PRECISELY.';
      minMatchingTags = 3; // Need 3+ matching tags
    } else if (generalization < 0.7) {
      // Medium generalization = balanced matching
      matchingGuidance =
          'Match if book fits REASONABLY well (shared main topic).';
      minMatchingTags = 2; // Need 2+ matching tags
    } else {
      // High generalization = loose matching = few broad shelves
      matchingGuidance =
          'Be FLEXIBLE with matching. Match if book has SIMILAR theme.';
      minMatchingTags = 1; // Need 1+ matching tag
    }

    // Track results
    final assignments = <ShelfAssignment>[];
    final newShelvesSet = <String>{};
    final shelfTagsMap = <String, List<String>>{};

    // Get existing shelf data (names and tags)
    final existingShelvesData = existingShelves
        .where((s) => !s.isDefault)
        .map((s) => {'name': s.name, 'tags': s.tags})
        .toList();

    // Prepare Ollama options from AI settings
    final ollamaOptions = <String, dynamic>{
      'num_ctx': aiSettings.numCtx,
      'num_predict': 500, // Shorter responses for incremental
      'repeat_penalty': aiSettings.repeatPenalty,
      'repeat_last_n': 128, // Look at last 128 tokens for repeat penalty
      'top_k': aiSettings.topK,
      'top_p': aiSettings.topP,
      'tfs_z': 0.5, // Tail Free Sampling for more focused output
      'typical_p': 0.9, // Typical sampling to avoid rare/strange words
    };

    // Add optional advanced parameters if set
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

    print('\n========== INCREMENTAL SORT START ==========');
    print('DEBUG: Total books to sort: ${books.length}');
    print('DEBUG: Existing shelves: ${existingShelvesData.length}');
    print('DEBUG: Generalization: $generalization');
    print('DEBUG: Min matching tags: $minMatchingTags');
    print('========================================\n');

    // Process each book individually
    for (var i = 0; i < books.length; i++) {
      final book = books[i];
      onProgress?.call(i, books.length);

      print(
        'DEBUG: [${i + 1}/${books.length}] Processing: ${book.title ?? book.fileName}',
      );
      print(
        'DEBUG: Book tags: ${book.tags.take(5).join(", ")}${book.tags.length > 5 ? "..." : ""}',
      );

      // Build prompt for this single book
      final prompt = _buildIncrementalPrompt(
        book: book,
        existingShelves: existingShelvesData,
        allKnownShelves: [
          ...existingShelvesData.map((s) => s['name'] as String),
          ...newShelvesSet,
        ],
        shelfTagsMap: shelfTagsMap,
        matchingGuidance: matchingGuidance,
        minMatchingTags: minMatchingTags,
        outputLanguage: outputLanguage,
      );

      // JSON schema for single book assignment
      final format = {
        'type': 'object',
        'properties': {
          'shelf': {'type': 'string'},
          'isNew': {'type': 'boolean'},
          'tags': {
            'type': 'array',
            'items': {'type': 'string'},
          },
        },
        'required': ['shelf', 'isNew', 'tags'],
      };

      try {
        final response = await ollamaClient.generate(
          prompt: prompt,
          temperature: 0.3,
          format: format,
          options: ollamaOptions,
        );

        final json = ollamaClient.parseJsonResponse(response);
        final shelfName = json['shelf'] as String;
        final isNew = json['isNew'] as bool;
        final tags = (json['tags'] as List).map((e) => e.toString()).toList();

        print(
          'DEBUG: Assigned to shelf: "$shelfName" (${isNew ? "NEW" : "existing"})',
        );
        print('DEBUG: Shelf tags: ${tags.join(", ")}');

        // Record assignment
        assignments.add(
          ShelfAssignment(filePath: book.filePath, shelfName: shelfName),
        );

        // Track new shelf and its tags
        if (isNew) {
          newShelvesSet.add(shelfName);
          shelfTagsMap[shelfName] = tags;
        } else if (!shelfTagsMap.containsKey(shelfName)) {
          // For existing shelves, use their existing tags if available
          final existingShelf = existingShelvesData.firstWhere(
            (s) => s['name'] == shelfName,
            orElse: () => {'name': shelfName, 'tags': <String>[]},
          );
          shelfTagsMap[shelfName] = List<String>.from(
            existingShelf['tags'] as List,
          );
        }
      } catch (e) {
        print('ERROR: Failed to assign book: $e');
        // On error, assign to first shelf or create a generic one
        if (existingShelvesData.isNotEmpty) {
          final fallbackShelf = existingShelvesData.first['name'] as String;
          assignments.add(
            ShelfAssignment(filePath: book.filePath, shelfName: fallbackShelf),
          );
          print('DEBUG: Fallback assignment to: "$fallbackShelf"');
        } else {
          // No existing shelves, create "Unsorted"
          assignments.add(
            ShelfAssignment(
              filePath: book.filePath,
              shelfName: 'Uncategorized',
            ),
          );
          newShelvesSet.add('Uncategorized');
          shelfTagsMap['Uncategorized'] = ['general', 'misc'];
          print('DEBUG: Created fallback shelf: "Uncategorized"');
        }
      }
    }

    onProgress?.call(books.length, books.length);

    // Filter out only truly new shelves (not in existing)
    final existingShelfNames = existingShelves
        .where((s) => !s.isDefault)
        .map((s) => s.name)
        .toSet();
    final newShelves = newShelvesSet
        .where((name) => !existingShelfNames.contains(name))
        .toList();

    print('\n========== INCREMENTAL SORT COMPLETE ==========');
    print('DEBUG: Created ${newShelves.length} new shelves');
    print('DEBUG: Assigned ${assignments.length} books');
    print('DEBUG: New shelves: ${newShelves.join(", ")}');
    print('===============================================\n');

    return LibrarySortResult(
      assignments: assignments,
      newShelves: newShelves,
      shelfTags: shelfTagsMap,
    );
  }

  /// Build prompt for assigning a single book to a shelf
  String _buildIncrementalPrompt({
    required Book book,
    required List<Map<String, dynamic>> existingShelves,
    required List<String> allKnownShelves,
    required Map<String, List<String>> shelfTagsMap,
    required String matchingGuidance,
    required int minMatchingTags,
    required String outputLanguage,
  }) {
    final bookTitle = (book.title ?? book.fileName).length > 80
        ? '${(book.title ?? book.fileName).substring(0, 77)}...'
        : (book.title ?? book.fileName);

    final reasoningSection =
        aiSettings.includeBookReasoning &&
            book.aiReasoning != null &&
            book.aiReasoning!.isNotEmpty
        ? '\nBook reasoning: ${book.aiReasoning}'
        : '';

    final shelvesListSection = existingShelves.isEmpty
        ? '(No existing shelves yet - you can create the first one)'
        : existingShelves
              .map(
                (s) =>
                    '- "${s['name']}" [tags: ${(s['tags'] as List).take(5).join(", ")}]',
              )
              .join('\n');

    // Calculate token budget (incremental uses fixed 500 tokens)
    const tokenBudget = 500;
    final charBudget = outputLanguage == 'Russian'
        ? (tokenBudget * 2.5).round()
        : (tokenBudget * 4).round();

    return '''You are a librarian assigning ONE book to a shelf.

🌐 CRITICAL: ALL responses MUST be in $outputLanguage language! 🌐

⚠️ TOKEN BUDGET: Your response MUST fit within $tokenBudget tokens (~$charBudget characters).
- Be concise: 1-2 word shelf name, 3-7 word tags
- JSON only, no extra text

BOOK TO ASSIGN:
Title: $bookTitle
Tags (ordered by importance): ${book.tags.join(", ")}$reasoningSection

EXISTING SHELVES:
$shelvesListSection

TASK:
1. Analyze the book's tags (first 2-3 are most important)
2. Check if it matches an existing shelf:
   $matchingGuidance
   - Need at least $minMatchingTags matching/related tags
   - Consider theme similarity, not exact tag matches
3. Decision:
   - If matches existing shelf: assign to it
   - If doesn't match: create NEW shelf with descriptive name

RULES:
- Shelf names: ONE or TWO words, title case (e.g. "Programming", "Science Fiction")
- Shelf names MUST be in $outputLanguage
- Shelf tags: 3-7 relevant tags in $outputLanguage
- Prefer existing shelves when reasonable
- Create new shelf only if book doesn't fit existing ones

Return JSON:
{
  "shelf": "Shelf Name",
  "isNew": true/false,
  "tags": ["tag1", "tag2", "tag3"]
}

Remember: Response in $outputLanguage!''';
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

    // Build conditional sections based on optimization settings
    final reasoningNoteSection = aiSettings.includeBookReasoning
        ? '\nNOTE: Some books include "reasoning" which explains the book\'s subject and why its tags were chosen. Use this context to better understand each book\'s main theme and make more accurate shelf assignments.\n'
        : '';

    final inputAnalysisSection = aiSettings.includeExtendedInstructions
        ? '''
INPUT ANALYSIS:
- You have LARGE CONTEXT with all book information (titles, tags${aiSettings.includeBookReasoning ? ', reasoning' : ''})
- Tags are already ORDERED BY IMPORTANCE (first tags are most relevant)${aiSettings.includeBookReasoning ? '\n- "reasoning" field (when present) explains book\'s subject and tag rationale' : ''}
- Use this rich context to make informed decisions
'''
        : '';

    final detailedStrategySection = aiSettings.includeDetailedExamples
        ? '''
SHELF CREATION STRATEGY:
- First, analyze ALL books and group them by primary topic/subject
- Count how many books fit each topic before creating shelves
- Only create a shelf if you have books that will go into it
- Merge small groups (1-2 books) into broader related shelves
- Shelf names represent SUBJECTS/TOPICS/GENRES, not formats
- Preferably ONE word for broad subjects, maximum TWO words for specific fields
- Use title case (e.g., "Programming", "Web Development", "Physics")
- Follow the tags-per-shelf guidance above
- More specific shelves = fewer tags; broader shelves = more tags (but stay thematic)

BOOK ASSIGNMENT RULES:
- Match each book's FIRST 2-3 TAGS (most important) with shelf names/themes
- Books with similar primary tags should go to the same shelf
- Use the book's tag order as priority (first tags are most relevant)
- Each book appears EXACTLY ONCE in assignments array
- If a book doesn't fit well, PUT IT IN THE CLOSEST RELATED SHELF (don't leave unassigned)
- Never assign the same book (same filePath) to multiple shelves
'''
        : '';

    final jsonExampleSection = aiSettings.includeDetailedExamples
        ? '''
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
'''
        : 'Return JSON with shelves and assignments.\n';

    final validationChecklistSection = aiSettings.includeExtendedInstructions
        ? '''
VALIDATION CHECKLIST before returning:
✓ Count: assignments.length == number of input books
✓ Uniqueness: each filePath appears EXACTLY ONCE in assignments
✓ Coverage: every shelf has at least one book assigned
✓ Validity: every assignment.shelf matches a shelf in the shelves array
✓ Language: shelf names and tags are in $outputLanguage
'''
        : '';

    // Calculate adaptive num_predict based on number of books
    // Each book assignment needs ~50 tokens, shelves add ~30 tokens each
    // Add 1000 tokens overhead for JSON structure and instructions
    final estimatedTokens = (booksData.length * 60) + 1000;
    // Use at least user's setting, but increase for large libraries
    // Cap at 8000 to avoid excessive generation
    final adaptiveNumPredict = estimatedTokens.clamp(
      aiSettings.numPredict,
      8000,
    );

    print('DEBUG: Adaptive num_predict calculation:');
    print('  Base (user setting): ${aiSettings.numPredict}');
    print(
      '  Estimated needed: $estimatedTokens (${booksData.length} books × 60 + 1000)',
    );
    print('  Using: $adaptiveNumPredict tokens');

    // Calculate token budget for prompt (1 token ≈ 4 chars for Latin, ≈ 2.5 for Cyrillic)
    final tokenBudget = adaptiveNumPredict;
    final charBudget = outputLanguage == 'Russian'
        ? (tokenBudget * 2.5).round()
        : (tokenBudget * 4).round();

    final prompt =
        '''You are a librarian organizing ${booksData.length} books into subject-based shelves.

🌐 CRITICAL LANGUAGE REQUIREMENT 🌐
RESPOND IN $outputLanguage LANGUAGE!
- ALL shelf names MUST be in $outputLanguage
- ALL tags MUST be in $outputLanguage
- Book titles stay in ORIGINAL language (already provided)
This is MANDATORY - shelf names and tags MUST be $outputLanguage words/phrases.

⚠️ TOKEN BUDGET: Your response MUST fit within $tokenBudget tokens (~$charBudget characters).
- Be very concise with shelf names (1-2 words) and tags
- ${booksData.length} books need assignments - keep each assignment minimal
- Avoid long tag lists - use only most essential tags per shelf
- JSON only, no extra text or explanations

EXISTING SHELVES (reuse if appropriate):
${existingShelves.isEmpty ? '(none)' : existingShelves.join(', ')}

ALL AVAILABLE TAGS FROM BOOKS:
${allTags.join(', ')}

BOOKS TO ORGANIZE (with filePath, title, tags ordered by importance${aiSettings.includeBookReasoning ? ', and reasoning where available' : ''}):
${jsonEncode(booksData)}
$reasoningNoteSection
STRATEGY:
$generalizationGuidance
$tagsPerShelfGuidance

⚠️ SHELF NAMING RULE ⚠️
Shelf names MUST be SUBJECT/TOPIC-based (e.g., "Programming", "History", "Physics").
NEVER use book titles as shelf names! A shelf should fit MULTIPLE books on the same subject.

CRITICAL TASK:
You must do TWO things in ONE response:
1. Create appropriate subject-based shelves
2. Assign EVERY book to exactly ONE shelf
$inputAnalysisSection
CRITICAL CONSTRAINTS - MUST FOLLOW:
1. EVERY book must be assigned to EXACTLY ONE shelf (no duplicates, no missing books)
2. EVERY shelf you create MUST have AT LEAST ONE book assigned to it
3. Do NOT create empty shelves - only create shelves you will actually use
4. Each book appears ONLY ONCE in assignments (one filePath = one shelf)
5. Books can only be assigned to shelves you create or existing shelves
$detailedStrategySection$jsonExampleSection$validationChecklistSection
🌐 FINAL REMINDER: Shelf names and tags MUST be in $outputLanguage language! 🌐

Remember: EVERY book EXACTLY ONCE, EVERY shelf has books, NO DUPLICATES, $outputLanguage LANGUAGE.''';

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

    // Prepare Ollama options from AI settings
    final ollamaOptions = <String, dynamic>{
      'num_ctx': aiSettings.numCtx,
      'num_predict': adaptiveNumPredict, // Adaptive based on library size
      'repeat_penalty': aiSettings.repeatPenalty,
      'repeat_last_n': 128, // Look at last 128 tokens for repeat penalty
      'top_k': aiSettings.topK,
      'top_p': aiSettings.topP,
      'tfs_z': 0.5, // Tail Free Sampling for more focused output
      'typical_p': 0.9, // Typical sampling to avoid rare/strange words
      'num_batch': aiSettings.numBatch,
    };

    // Add optional advanced parameters if set
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
    if (aiSettings.stopSequences.isNotEmpty) {
      // Parse comma-separated stop sequences
      final stopList = aiSettings.stopSequences
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      if (stopList.isNotEmpty) {
        ollamaOptions['stop'] = stopList;
      }
    }

    print('\n========== AI SORT DEBUG START ==========');
    print('DEBUG: Books to sort: ${booksData.length}');
    print('DEBUG: Existing shelves: ${existingShelves.length}');
    print('DEBUG: Generalization guidance: $generalizationGuidance');
    print('DEBUG: Prompt length: ${prompt.length} characters');
    print('DEBUG: Context window (num_ctx): ${aiSettings.numCtx}');
    print('DEBUG: Max output tokens (num_predict): ${aiSettings.numPredict}');
    print('\n--- PROMPT PREVIEW (first 500 chars) ---');
    print(prompt.substring(0, prompt.length > 500 ? 500 : prompt.length));
    print('...\n');

    final response = await ollamaClient.generate(
      prompt: prompt,
      temperature: 0.3,
      format: format,
      options: ollamaOptions,
    );

    print('DEBUG: LLM response received');
    print('DEBUG: Response length: ${response.length} characters');
    print('--- RAW RESPONSE (first 1000 chars) ---');
    print(
      response.substring(0, response.length > 1000 ? 1000 : response.length),
    );
    if (response.length > 1000) {
      print('...\n--- RAW RESPONSE (last 500 chars) ---');
      print(response.substring(response.length - 500));
    }
    print('');

    final json = ollamaClient.parseJsonResponse(response);
    print('DEBUG: JSON parsing successful');
    print(
      'DEBUG: Parsed sorting result: shelves=${json['shelves']?.length}, assignments=${json['assignments']?.length}',
    );
    if (json['shelves'] != null) {
      print(
        'DEBUG: Shelf names: ${(json['shelves'] as List).map((s) => s['name']).join(', ')}',
      );
    }
    print('========== AI SORT DEBUG END ==========\n');

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

    // VALIDATION 1: Check for duplicate book assignments
    final seenFilePaths = <String>{};
    final duplicates = <String>[];
    for (final assignment in assignmentsList) {
      if (seenFilePaths.contains(assignment.filePath)) {
        duplicates.add(assignment.filePath);
      } else {
        seenFilePaths.add(assignment.filePath);
      }
    }

    if (duplicates.isNotEmpty) {
      print('WARNING: Found duplicate assignments for books: $duplicates');
      // Remove duplicates - keep only first occurrence
      final uniqueAssignments = <String, ShelfAssignment>{};
      for (final assignment in assignmentsList) {
        uniqueAssignments.putIfAbsent(assignment.filePath, () => assignment);
      }
      assignmentsList.clear();
      assignmentsList.addAll(uniqueAssignments.values);
      print(
        'DEBUG: After deduplication: ${assignmentsList.length} unique assignments',
      );
    }

    // VALIDATION 2: Check that all input books are assigned
    final inputBookPaths = booksData
        .map((b) => b['filePath'] as String)
        .toSet();
    final assignedPaths = assignmentsList.map((a) => a.filePath).toSet();
    final missingBooks = inputBookPaths.difference(assignedPaths);

    if (missingBooks.isNotEmpty) {
      print('WARNING: ${missingBooks.length} books not assigned by LLM');
      // Assign missing books to first available shelf
      if (shelfList.isNotEmpty) {
        final fallbackShelf = shelfList.first;
        for (final missingPath in missingBooks) {
          assignmentsList.add(
            ShelfAssignment(filePath: missingPath, shelfName: fallbackShelf),
          );
        }
        print(
          'DEBUG: Assigned ${missingBooks.length} missing books to "$fallbackShelf"',
        );
      }
    }

    // VALIDATION 3: Check for empty shelves
    final shelfAssignmentCounts = <String, int>{};
    for (final shelf in shelfList) {
      shelfAssignmentCounts[shelf] = 0;
    }
    for (final assignment in assignmentsList) {
      if (shelfAssignmentCounts.containsKey(assignment.shelfName)) {
        shelfAssignmentCounts[assignment.shelfName] =
            shelfAssignmentCounts[assignment.shelfName]! + 1;
      }
    }

    final emptyShelves = shelfAssignmentCounts.entries
        .where((e) => e.value == 0)
        .map((e) => e.key)
        .toList();

    if (emptyShelves.isNotEmpty) {
      print(
        'WARNING: ${emptyShelves.length} empty shelves created: $emptyShelves',
      );
      // Remove empty shelves from the list
      shelfList.removeWhere((shelf) => emptyShelves.contains(shelf));
      shelfTagsMap.removeWhere((shelf, _) => emptyShelves.contains(shelf));
      print(
        'DEBUG: Removed empty shelves, remaining: ${shelfList.length} shelves',
      );
    }

    // Identify truly new shelves (not in existing)
    final existingShelfNames = existingShelves.toSet();
    final newShelfNames = shelfList
        .where((name) => !existingShelfNames.contains(name))
        .toList();

    print(
      'DEBUG: Validation complete - ${assignmentsList.length} assignments, ${newShelfNames.length} new shelves',
    );

    return LibrarySortResult(
      assignments: assignmentsList,
      newShelves: newShelfNames,
      shelfTags: shelfTagsMap,
    );
  }
}
