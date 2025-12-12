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

      // Build prompt sections based on optimization settings
      final detailedExamplesSection = aiSettings.includeDetailedExamples
          ? '''
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
'''
          : '';

      final extendedInstructionsSection = aiSettings.includeExtendedInstructions
          ? '\nExtract actual title and author from book content, not filename\n'
          : '';

      // Build conditional prompt sections
      final reasoningLanguageNote = aiSettings.includeBookReasoning
          ? '\n- Reasoning MUST be in $outputLanguage'
          : '';
      final reasoningJsonField = aiSettings.includeBookReasoning
          ? ',\n  "reasoning": "2-3 sentences explaining: (1) what subject/genre this book belongs to, (2) why these specific tags were chosen and how they represent the book\'s main themes"'
          : '';
      final reasoningReminder = aiSettings.includeBookReasoning
          ? ' and reasoning'
          : '';

      // Calculate token budget (1 token ≈ 4 chars for Latin, ≈ 2.5 for Cyrillic)
      final tokenBudget = aiSettings.numPredict;
      final charBudget = outputLanguage == 'Russian'
          ? (tokenBudget * 2.5).round()
          : (tokenBudget * 4).round();

      // If no text extracted, analyze based on filename only
      final prompt = text.isNotEmpty
          ? '''You are a librarian analyzing a book. Based on the book's filename and the text from its first pages, extract the following information:

Filename: ${book.fileName}

Text from first pages (excerpt):
$text

🌐 CRITICAL LANGUAGE REQUIREMENT 🌐
RESPOND IN $outputLanguage LANGUAGE!

⚠️ IMPORTANT - LANGUAGE RULES ⚠️
1. TAGS: Write ALL tags ONLY in $outputLanguage language
   - Example: If book is in Russian but output language is English → tags in ENGLISH
   - Example: If book is in English but output language is Russian → tags in RUSSIAN
   - Tags describe book content, translated to $outputLanguage
2. TITLE: Copy EXACTLY as written - preserve original script/alphabet
   - Russian: "Россия в цвете" → "Россия в цвете" (NOT "Rossiya v cvete")
   - Chinese: "红楼梦" → "红楼梦" (NOT "Hong Lou Meng")
   - Arabic: "الفلسفة" → "الفلسفة" (NOT "Al-Falsafa")
   - Japanese: "哲学入門" → "哲学入門" (NOT "Tetsugaku Nyumon")
   - NEVER transliterate or romanize ANY script
3. AUTHOR: Copy EXACTLY as written - preserve original script/alphabet
   - Russian: "Иван Петров" → "Иван Петров" (NOT "Ivan Petrov")
   - Chinese: "王明" → "王明" (NOT "Wang Ming")
   - NEVER transliterate or romanize ANY script$reasoningLanguageNote

⚠️ TOKEN BUDGET: Your response MUST fit within $tokenBudget tokens (~$charBudget characters).
- Be concise and precise
- Use 1-2 word tags only
- Keep reasoning under 100 words (if included)
- JSON only, no extra text

EXTRACT the real title and author from the text. DO NOT use placeholders!
⚠️ CRITICAL: Copy title/author with ORIGINAL script - NO transliteration/romanization! ⚠️
Examples of what NOT to do:
- "Россия в цвете" → "Rossiya v cvete" ✗ WRONG (transliterated)
- "红楼梦" → "Hong Lou Meng" ✗ WRONG (romanized)
- "الفلسفة" → "Al-Falsafa" ✗ WRONG (romanized)
Examples of what TO do:
- "Россия в цвете" → "Россия в цвете" ✓ CORRECT (Cyrillic preserved)
- "红楼梦" → "红楼梦" ✓ CORRECT (Chinese preserved)
- "Philosophy" → "Philosophy" ✓ CORRECT (Latin preserved)

Return ONLY valid JSON (no markdown, no extra text):
{
  "title": "Extract real title from text (preserve original alphabet)",
  "author": "Extract real author from text (preserve original alphabet)",
  "tags": ["subject", "specific-topic1", "specific-topic2", "concept1", "concept2"]$reasoningJsonField
}

CRITICAL RULES FOR TAGS:
- ALL tags in $outputLanguage ONLY (translate concepts if needed)
- 8-12 specific tags about THIS book's content
- Order by importance: broad subjects first, then specific topics
- Use lowercase, 1-2 words per tag
- FORBIDDEN tags: "pdf", "book", "file", publisher names, author name, generic words
- Focus on: subject area, key concepts, methodologies, topics discussed
$detailedExamplesSection$extendedInstructionsSection
🌐 FINAL CHECK:
- ALL tags in $outputLanguage language?
- Title/author with ORIGINAL script (NO transliteration/romanization of ANY language)?
- Cyrillic→Cyrillic, Chinese→Chinese, Arabic→Arabic, Latin→Latin?$reasoningReminder 🌐

Return JSON'''
          : '''You are a librarian analyzing a book. Based on the book's filename, try to extract information:

Filename: ${book.fileName}

🌐 CRITICAL LANGUAGE REQUIREMENT 🌐
RESPOND IN $outputLanguage LANGUAGE!

⚠️ IMPORTANT - LANGUAGE RULES ⚠️
1. TAGS: Write ALL tags ONLY in $outputLanguage language
   - Example: If book is in Russian but output language is English → tags in ENGLISH
   - Example: If book is in English but output language is Russian → tags in RUSSIAN
   - Tags describe book content, translated to $outputLanguage
2. TITLE: Copy EXACTLY as written - preserve original script/alphabet
   - Russian: "Россия в цвете" → "Россия в цвете" (NOT "Rossiya v cvete")
   - Chinese: "红楼梦" → "红楼梦" (NOT "Hong Lou Meng")
   - Arabic: "الفلسفة" → "الفلسفة" (NOT "Al-Falsafa")
   - Japanese: "哲学入門" → "哲学入門" (NOT "Tetsugaku Nyumon")
   - NEVER transliterate or romanize ANY script
3. AUTHOR: Copy EXACTLY as written - preserve original script/alphabet
   - Russian: "Иван Петров" → "Иван Петров" (NOT "Ivan Petrov")
   - Chinese: "王明" → "王明" (NOT "Wang Ming")
   - NEVER transliterate or romanize ANY script$reasoningLanguageNote

⚠️ TOKEN BUDGET: Your response MUST fit within $tokenBudget tokens (~$charBudget characters).
- Be concise: 1-2 word tags only
- JSON only, no extra text

EXTRACT title/author from filename. DO NOT use placeholders!
⚠️ CRITICAL: Preserve ORIGINAL script from filename - NO transliteration/romanization! ⚠️
Examples of what NOT to do:
- "Россия" → "Rossiya" ✗ WRONG
- "红楼梦" → "Hong Lou Meng" ✗ WRONG
- "الفلسفة" → "Al-Falsafa" ✗ WRONG
Examples of what TO do:
- "Россия" → "Россия" ✓ CORRECT
- "红楼梦" → "红楼梦" ✓ CORRECT
- "Philosophy" → "Philosophy" ✓ CORRECT

Return ONLY valid JSON:
{
  "title": "Parse real title from filename (preserve original alphabet)",
  "author": "Parse real author from filename (preserve original alphabet)",
  "tags": ["subject", "topic1", "topic2", "concept1"]
}

CRITICAL RULES FOR TAGS:
- ALL tags in $outputLanguage ONLY
- 5-8 specific tags from filename analysis
- Order by importance: subject first, then topics
- Use lowercase, 1-2 words per tag
- FORBIDDEN: "pdf", "book", "file", publisher names, author name, year numbers
- Focus on: subject area, key topics inferred from title

🌐 FINAL CHECK: Are ALL tags in $outputLanguage language? Title/author in ORIGINAL language? 🌐''';

      // JSON schema for book analysis (conditionally include reasoning)
      final properties = <String, dynamic>{
        'title': {'type': 'string'},
        'author': {'type': 'string'},
        'tags': {
          'type': 'array',
          'items': {'type': 'string'},
        },
      };

      final required = ['title', 'author', 'tags'];

      if (aiSettings.includeBookReasoning) {
        properties['reasoning'] = {'type': 'string'};
        required.add('reasoning');
      }

      final format = {
        'type': 'object',
        'properties': properties,
        'required': required,
      };

      // Prepare Ollama options from AI settings
      final ollamaOptions = <String, dynamic>{
        'num_ctx': aiSettings.numCtx,
        'num_predict': aiSettings.numPredict,
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

      // Get response from AI
      final response = await ollamaClient.generate(
        prompt: prompt,
        temperature: 0.3,
        format: format,
        options: ollamaOptions,
      );
      print('DEBUG: LLM Response for book "${book.fileName}": $response');

      // Parse JSON response
      final json = ollamaClient.parseJsonResponse(response);
      print('DEBUG: Parsed book analysis: $json');

      return BookAnalysisResult.fromJson(json);
    } catch (e) {
      // Don't return fallback data - rethrow error so caller can handle it
      print('ERROR: Failed to analyze book "${book.fileName}": $e');
      rethrow;
    }
  }
}
