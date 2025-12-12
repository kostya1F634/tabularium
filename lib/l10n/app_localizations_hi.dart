// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'आपकी व्यक्तिगत लाइब्रेरी';

  @override
  String get selectBooksDirectory => 'किताबों का फ़ोल्डर चुनें';

  @override
  String get recentDirectories => 'हाल ही के';

  @override
  String get favorites => 'पसंदीदा';

  @override
  String get clearRecent => 'हाल ही के साफ़ करें';

  @override
  String get clearFavorites => 'पसंदीदा साफ़ करें';

  @override
  String get addToFavorites => 'पसंदीदा में जोड़ें';

  @override
  String get removeFromFavorites => 'पसंदीदा से हटाएं';

  @override
  String get directoryNotFound => 'फ़ोल्डर नहीं मिला';

  @override
  String directoryNotFoundMessage(String path) {
    return 'फ़ोल्डर \"$path\" मौजूद नहीं है या पहुंच योग्य नहीं है। इसे हाल ही के से हटा दिया गया है।';
  }

  @override
  String get mainScreen => 'मुख्य स्क्रीन';

  @override
  String get selectedDirectory => 'चयनित फ़ोल्डर:';

  @override
  String get error => 'त्रुटि';

  @override
  String errorMessage(String message) {
    return 'त्रुटि: $message';
  }

  @override
  String get retry => 'पुनः प्रयास';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get language => 'भाषा';

  @override
  String get allBooks => 'सभी किताबें';

  @override
  String get unsortedBooks => 'अवर्गीकृत';

  @override
  String get shelves => 'शेल्फ़';

  @override
  String get createShelf => 'शेल्फ़ बनाएं';

  @override
  String get editShelf => 'शेल्फ़ संपादित करें';

  @override
  String get shelfName => 'शेल्फ़ का नाम';

  @override
  String get deleteShelf => 'शेल्फ़ हटाएं';

  @override
  String get openAllBooks => 'सभी खोलें';

  @override
  String get searchBooks => 'किताबें खोजें...';

  @override
  String get searchShelves => 'शेल्फ़ खोजें...';

  @override
  String get noBooks => 'कोई किताब नहीं मिली';

  @override
  String get noBooksInShelf => 'शेल्फ़ खाली है';

  @override
  String get scanForNewBooks => 'नई किताबें स्कैन करें';

  @override
  String get scan => 'स्कैन करें';

  @override
  String get initializingLibrary => 'प्रारंभ हो रहा है...';

  @override
  String get loadingLibrary => 'लोड हो रहा है...';

  @override
  String get backToWelcome => 'वापस जाएं';

  @override
  String get addToShelf => 'शेल्फ़ में जोड़ें';

  @override
  String get removeFromShelf => 'शेल्फ़ से हटाएं';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count किताबें',
      one: '1 किताब',
      zero: 'कोई किताब नहीं',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'रद्द करें';

  @override
  String get create => 'बनाएं';

  @override
  String get delete => 'हटाएं';

  @override
  String get selected => 'चयनित';

  @override
  String get openSelected => 'चयनित खोलें';

  @override
  String get selectAll => 'सभी चुनें';

  @override
  String get clearSelection => 'चयन साफ़ करें';

  @override
  String get deleteFromShelf => 'शेल्फ़ से हटाएं';

  @override
  String get remove => 'हटाएं';

  @override
  String get open => 'खोलें';

  @override
  String get properties => 'गुण';

  @override
  String get bookProperties => 'किताब के गुण';

  @override
  String get alias => 'उपनाम';

  @override
  String get filePath => 'फ़ाइल पथ';

  @override
  String get author => 'लेखक';

  @override
  String get title => 'शीर्षक';

  @override
  String get pageCount => 'पृष्ठ';

  @override
  String get fileSize => 'फ़ाइल आकार';

  @override
  String get save => 'सहेजें';

  @override
  String get shortcuts => 'शॉर्टकट';

  @override
  String get keyboardShortcuts => 'कीबोर्ड शॉर्टकट';

  @override
  String get deleteBook => 'हटाएं';

  @override
  String get deleteSelected => 'चयनित हटाएं';

  @override
  String get deleteAll => 'सभी हटाएं';

  @override
  String get confirmDeleteBook => 'किताब हटाएं?';

  @override
  String get confirmDeleteBookMessage =>
      'फ़ाइल स्थायी रूप से हटा दी जाएगी। यह क्रिया अपरिवर्तनीय है।';

  @override
  String get confirmDeleteSelected => 'चयनित हटाएं?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return '$count फ़ाइलें स्थायी रूप से हटा दी जाएंगी। यह क्रिया अपरिवर्तनीय है।';
  }

  @override
  String get confirmDeleteAll => 'सभी हटाएं?';

  @override
  String confirmDeleteAllMessage(int count) {
    return 'इस शेल्फ़ की सभी $count फ़ाइलें स्थायी रूप से हटा दी जाएंगी। यह क्रिया अपरिवर्तनीय है।';
  }

  @override
  String get aboutTabularium => 'Tabularium के बारे में';

  @override
  String get ok => 'ठीक है';

  @override
  String get toggleViewMode => 'दृश्य बदलें';

  @override
  String get theme => 'थीम';

  @override
  String get help => 'मदद';

  @override
  String get about => 'के बारे में';

  @override
  String get resetSettings => 'रीसेट करें';

  @override
  String get fontSize => 'फ़ॉन्ट आकार';

  @override
  String get bookScaleGrid => 'स्केल (ग्रिड)';

  @override
  String get bookScaleCabinet => 'स्केल (कैबिनेट)';

  @override
  String get add => 'जोड़ें';

  @override
  String get selectShelf => 'शेल्फ़ चुनें';

  @override
  String get sortDateAddedNewest => 'जोड़ा गया ↓';

  @override
  String get sortDateAddedOldest => 'जोड़ा गया ↑';

  @override
  String get sortDateOpenedNewest => 'खोला गया ↓';

  @override
  String get sortDateOpenedOldest => 'खोला गया ↑';

  @override
  String get sortTitleAZ => 'शीर्षक A-Z';

  @override
  String get sortTitleZA => 'शीर्षक Z-A';

  @override
  String get searchThemes => 'थीम खोजें...';

  @override
  String get sizeSmall => 'छोटा';

  @override
  String get sizeMedium => 'मध्यम';

  @override
  String get sizeNormal => 'सामान्य';

  @override
  String get sizeLarge => 'बड़ा';

  @override
  String get sizeExtraLarge => 'बहुत बड़ा';

  @override
  String get sizeTiny => 'अति छोटा';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'सामान्य';

  @override
  String get shortcutsNavigationShelves => 'नेविगेशन - शेल्फ़';

  @override
  String get shortcutsNavigationBooks => 'नेविगेशन - किताबें';

  @override
  String get shortcutsShelves => 'शेल्फ़';

  @override
  String get shortcutsBooks => 'किताबें';

  @override
  String get shortcutToggleScreen =>
      'लाइब्रेरी और स्वागत स्क्रीन के बीच टॉगल करें';

  @override
  String get shortcutCreateShelf => 'नई शेल्फ़ बनाएं';

  @override
  String get shortcutOpenBooks => 'किताबें खोलें (सभी या चयनित)';

  @override
  String get shortcutSelectAll => 'सभी चुनें';

  @override
  String get shortcutClearSelection => 'चयन साफ़ करें';

  @override
  String get shortcutQuickShelf => 'त्वरित शेल्फ़ चयन (पहले 10)';

  @override
  String get shortcutEdit => 'शेल्फ़ संपादित करें / किताब गुण';

  @override
  String get shortcutToggleView => 'दृश्य मोड टॉगल करें (ग्रिड/कैबिनेट)';

  @override
  String get shortcutAddToShelf => 'शेल्फ़ में जोड़ें (चयनित/फोकस/सभी)';

  @override
  String get shortcutFocusCenter => 'केंद्रीय दृश्यमान किताब पर फोकस करें';

  @override
  String get shortcutJumpFirst => 'पहली शेल्फ़/किताब पर जाएं';

  @override
  String get shortcutJumpLast => 'अंतिम शेल्फ़/किताब पर जाएं';

  @override
  String get shortcutFocusSearch => 'खोज फ़ील्ड फोकस/अनफोकस करें';

  @override
  String get shortcutSwitchFocus => 'शेल्फ़ और किताबों के बीच फोकस स्विच करें';

  @override
  String get shortcutMoveDown => 'नीचे जाएं';

  @override
  String get shortcutMoveUp => 'ऊपर जाएं';

  @override
  String get shortcutMoveLeft => 'बाईं ओर जाएं';

  @override
  String get shortcutMoveRight => 'दाईं ओर जाएं';

  @override
  String get shortcutMoveShelfDown => 'शेल्फ़ को नीचे ले जाएं';

  @override
  String get shortcutMoveShelfUp => 'शेल्फ़ को ऊपर ले जाएं';

  @override
  String get shortcutDeleteShelf => 'शेल्फ़ हटाएं';

  @override
  String get shortcutOpenFocused => 'फोकस की गई किताब खोलें';

  @override
  String get shortcutToggleSelection => 'फोकस की गई किताब का चयन टॉगल करें';

  @override
  String get shortcutRemoveFromShelf => 'चयनित किताबें शेल्फ़ से हटाएं';

  @override
  String get ai => 'AI';

  @override
  String get aiSettings => 'AI Settings';

  @override
  String get aiFullSort => 'Full Sort';

  @override
  String get ollamaUrl => 'Ollama URL';

  @override
  String get ollamaModel => 'Ollama Model';

  @override
  String get generalization => 'Generalization';

  @override
  String get generalizationHint =>
      '0 = many specific shelves, 100 = few broad shelves';

  @override
  String get maxPages => 'Max Pages';

  @override
  String get maxPagesHint =>
      'Number of pages to read per book (1-50, starting from page 2)';

  @override
  String get processImages => 'Process Images';

  @override
  String get processImagesHint =>
      'Include book cover thumbnail as visual context for analysis (requires vision-capable model)';

  @override
  String get testConnection => 'Test Connection';

  @override
  String get connectionSuccess => 'Connection successful!';

  @override
  String get connectionFailed => 'Connection failed';

  @override
  String get analyzeBook => 'Analyzing book';

  @override
  String get analyzingBooks => 'Analyzing books...';

  @override
  String get sortingLibrary => 'Sorting library...';

  @override
  String get aiSortComplete => 'AI sort complete';

  @override
  String get aiSortFailed => 'AI sort failed';

  @override
  String booksAnalyzed(int count) {
    return '$count books analyzed';
  }

  @override
  String shelvesCreated(int count) {
    return '$count new shelves created';
  }

  @override
  String get aiRename => 'Auto Titling';

  @override
  String get aiSort => 'Sort';

  @override
  String get aiTitle => 'AI: Title & Tags';

  @override
  String get outputLanguage => 'Output Language';

  @override
  String get outputLanguageHint =>
      'Language for shelf names, tags, and reasoning (book titles stay in original language)';

  @override
  String get testLanguage => 'Test Language';

  @override
  String get languageTestResult => 'Language Test Result';

  @override
  String get includeDetailedExamples => 'Include Detailed Examples';

  @override
  String get includeDetailedExamplesHint =>
      'Include GOOD/BAD tag examples in prompts (reduces tokens when disabled)';

  @override
  String get includeBookReasoning => 'Include Book Reasoning';

  @override
  String get includeBookReasoningHint =>
      'Include AI reasoning about books when sorting library (reduces tokens when disabled)';

  @override
  String get includeExtendedInstructions => 'Include Extended Instructions';

  @override
  String get includeExtendedInstructionsHint =>
      'Include validation checklists and detailed explanations in prompts (reduces tokens when disabled)';

  @override
  String get aiParameters => 'Parameters';

  @override
  String get ollamaParameters => 'Ollama Parameters';

  @override
  String get numCtx => 'Context Window';

  @override
  String get numCtxHint =>
      'Number of tokens in context window (2048-32768). Default Ollama value is 2048, which may be too small for complex prompts. Larger values use more memory.';

  @override
  String get numCtxEffect =>
      '↑ More context → Better understanding | ↓ Less context → Faster, less memory';

  @override
  String get numPredict => 'Max Output Tokens';

  @override
  String get numPredictHint =>
      'Maximum number of tokens to generate (128-4096, -1 for unlimited). Limits response length.';

  @override
  String get numPredictEffect => '↑ Longer responses | ↓ Shorter responses';

  @override
  String get repeatPenalty => 'Repeat Penalty';

  @override
  String get repeatPenaltyHint =>
      'Penalty for repeating tokens (0.0-2.0). Higher values reduce repetition. Default: 1.1';

  @override
  String get repeatPenaltyEffect => '↑ Less repetition | ↓ More repetition';

  @override
  String get topK => 'Top-K';

  @override
  String get topKHint =>
      'Number of top tokens to consider (1-100). Lower values make output more focused. Default: 40';

  @override
  String get topKEffect => '↑ More diverse | ↓ More focused';

  @override
  String get topP => 'Top-P (Nucleus)';

  @override
  String get topPHint =>
      'Nucleus sampling threshold (0.0-1.0). Lower values make output more deterministic. Default: 0.9';

  @override
  String get topPEffect => '↑ More creative | ↓ More deterministic';

  @override
  String get numBatch => 'Batch Size';

  @override
  String get numBatchHint =>
      'Batch size for prompt processing (32-1024). Reduce if experiencing out-of-memory errors. Default: 512';

  @override
  String get numBatchEffect => '↑ Faster processing | ↓ Less memory usage';

  @override
  String get presencePenalty => 'Presence Penalty';

  @override
  String get presencePenaltyHint =>
      'Penalizes tokens that already appeared (0.0-2.0). Encourages diversity. Higher values = more variety in tags/shelves. Default: 0.0';

  @override
  String get presencePenaltyEffect => '↑ More variety | ↓ May repeat';

  @override
  String get frequencyPenalty => 'Frequency Penalty';

  @override
  String get frequencyPenaltyHint =>
      'Penalizes tokens based on frequency (0.0-2.0). Reduces repetition proportionally. Default: 0.0';

  @override
  String get frequencyPenaltyEffect =>
      '↑ Less frequent words | ↓ Common words OK';

  @override
  String get minP => 'Min-P';

  @override
  String get minPHint =>
      'Minimum probability threshold (0.0-1.0). Alternative to Top-P. Only considers tokens with probability ≥ min_p × max_probability. Default: 0.0 (disabled)';

  @override
  String get minPEffect => '↑ More conservative | ↓ More diverse';

  @override
  String get seed => 'Random Seed';

  @override
  String get seedHint =>
      'Random seed for reproducibility. Set to -1 for random generation, or fixed value (e.g., 42) for consistent results. Useful for debugging.';

  @override
  String get seedEffect => 'Fixed = Reproducible | -1 = Random';

  @override
  String get stopSequences => 'Stop Sequences';

  @override
  String get stopSequencesHint =>
      'Comma-separated stop sequences (e.g., \\n\\n\\n,```,---). Generation stops when encountering these. Saves tokens by stopping after JSON.';

  @override
  String get stopSequencesEffect => 'Saves tokens by early stopping';

  @override
  String get contextParameters => 'Context & Output';

  @override
  String get samplingParameters => 'Sampling & Creativity';

  @override
  String get penaltyParameters => 'Penalties & Control';

  @override
  String get resetDefaults => 'Reset to Defaults';

  @override
  String get advancedParameters => 'Advanced Parameters';

  @override
  String get useIncrementalSort => 'Incremental Sort (Reliable)';

  @override
  String get useIncrementalSortHint =>
      'Sort books one at a time instead of all at once. More reliable and debuggable, but slower. Recommended for large libraries or if batch sorting fails.';
}
