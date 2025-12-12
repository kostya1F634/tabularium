// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Dit Personlige Bibliotek';

  @override
  String get selectBooksDirectory => 'Vælg Bogmappe';

  @override
  String get recentDirectories => 'Seneste';

  @override
  String get favorites => 'Favoritter';

  @override
  String get clearRecent => 'Ryd Seneste';

  @override
  String get clearFavorites => 'Ryd Favoritter';

  @override
  String get addToFavorites => 'Tilføj til Favoritter';

  @override
  String get removeFromFavorites => 'Fjern fra Favoritter';

  @override
  String get directoryNotFound => 'Mappe ikke fundet';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Mappen \"$path\" findes ikke eller er utilgængelig. Den er fjernet fra seneste.';
  }

  @override
  String get mainScreen => 'Hovedskærm';

  @override
  String get selectedDirectory => 'Valgt mappe:';

  @override
  String get error => 'Fejl';

  @override
  String errorMessage(String message) {
    return 'Fejl: $message';
  }

  @override
  String get retry => 'Prøv Igen';

  @override
  String get loading => 'Indlæser...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Indstillinger';

  @override
  String get language => 'Sprog';

  @override
  String get allBooks => 'Alle Bøger';

  @override
  String get unsortedBooks => 'Usorteret';

  @override
  String get shelves => 'Hylder';

  @override
  String get createShelf => 'Opret Hylde';

  @override
  String get editShelf => 'Rediger Hylde';

  @override
  String get shelfName => 'Hyldenavn';

  @override
  String get deleteShelf => 'Slet Hylde';

  @override
  String get openAllBooks => 'Åbn Alle';

  @override
  String get searchBooks => 'Søg bøger...';

  @override
  String get searchShelves => 'Søg hylder...';

  @override
  String get noBooks => 'Ingen bøger fundet';

  @override
  String get noBooksInShelf => 'Hylde er tom';

  @override
  String get scanForNewBooks => 'Scan Nye Bøger';

  @override
  String get scan => 'Scan';

  @override
  String get initializingLibrary => 'Initialiserer...';

  @override
  String get loadingLibrary => 'Indlæser...';

  @override
  String get backToWelcome => 'Tilbage';

  @override
  String get addToShelf => 'Tilføj til Hylde';

  @override
  String get removeFromShelf => 'Fjern fra Hylde';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bøger',
      one: '1 bog',
      zero: 'Ingen bøger',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Annuller';

  @override
  String get create => 'Opret';

  @override
  String get delete => 'Slet';

  @override
  String get selected => 'valgt';

  @override
  String get openSelected => 'Åbn Valgte';

  @override
  String get selectAll => 'Vælg Alle';

  @override
  String get clearSelection => 'Ryd Valg';

  @override
  String get deleteFromShelf => 'Slet fra Hylde';

  @override
  String get remove => 'Fjern';

  @override
  String get open => 'Åbn';

  @override
  String get properties => 'Egenskaber';

  @override
  String get bookProperties => 'Bogegenskaber';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Filsti';

  @override
  String get author => 'Forfatter';

  @override
  String get title => 'Titel';

  @override
  String get pageCount => 'Sider';

  @override
  String get fileSize => 'Filstørrelse';

  @override
  String get save => 'Gem';

  @override
  String get shortcuts => 'Genveje';

  @override
  String get keyboardShortcuts => 'Tastaturgenveje';

  @override
  String get deleteBook => 'Slet';

  @override
  String get deleteSelected => 'Slet Valgte';

  @override
  String get deleteAll => 'Slet Alle';

  @override
  String get confirmDeleteBook => 'Slet Bog?';

  @override
  String get confirmDeleteBookMessage =>
      'Filen slettes permanent. Handling kan ikke fortrydes.';

  @override
  String get confirmDeleteSelected => 'Slet Valgte?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer slettes',
      one: 'fil slettes',
    );
    return '$count $_temp0 permanent. Handling kan ikke fortrydes.';
  }

  @override
  String get confirmDeleteAll => 'Slet Alle?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
    );
    return 'Alle $count $_temp0 fra denne hylde slettes permanent. Handling kan ikke fortrydes.';
  }

  @override
  String get aboutTabularium => 'Om Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Skift Visning';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Hjælp';

  @override
  String get about => 'Om';

  @override
  String get resetSettings => 'Nulstil';

  @override
  String get fontSize => 'Skriftstørrelse';

  @override
  String get bookScaleGrid => 'Skala (Gitter)';

  @override
  String get bookScaleCabinet => 'Skala (Skab)';

  @override
  String get add => 'Tilføj';

  @override
  String get selectShelf => 'Vælg Hylde';

  @override
  String get sortDateAddedNewest => 'Tilføjet ↓';

  @override
  String get sortDateAddedOldest => 'Tilføjet ↑';

  @override
  String get sortDateOpenedNewest => 'Åbnet ↓';

  @override
  String get sortDateOpenedOldest => 'Åbnet ↑';

  @override
  String get sortTitleAZ => 'Titel A-Z';

  @override
  String get sortTitleZA => 'Titel Z-A';

  @override
  String get searchThemes => 'Søg temaer...';

  @override
  String get sizeSmall => 'Lille';

  @override
  String get sizeMedium => 'Mellem';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Stor';

  @override
  String get sizeExtraLarge => 'Ekstra stor';

  @override
  String get sizeTiny => 'Meget lille';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Generelt';

  @override
  String get shortcutsNavigationShelves => 'Navigation - Hylder';

  @override
  String get shortcutsNavigationBooks => 'Navigation - Bøger';

  @override
  String get shortcutsShelves => 'Hylder';

  @override
  String get shortcutsBooks => 'Bøger';

  @override
  String get shortcutToggleScreen => 'Skift mellem bibliotek og velkomstskærm';

  @override
  String get shortcutCreateShelf => 'Opret ny hylde';

  @override
  String get shortcutOpenBooks => 'Åbn bøger (alle eller valgte)';

  @override
  String get shortcutSelectAll => 'Vælg alle';

  @override
  String get shortcutClearSelection => 'Ryd valg';

  @override
  String get shortcutQuickShelf => 'Hurtig hyldevalg (første 10)';

  @override
  String get shortcutEdit => 'Rediger hylde / Bogegenskaber';

  @override
  String get shortcutToggleView => 'Skift visningstilstand (Gitter/Skab)';

  @override
  String get shortcutAddToShelf =>
      'Tilføj bøger til hylde (valgte/fokuseret/alle)';

  @override
  String get shortcutFocusCenter => 'Fokuser på central synlig bog';

  @override
  String get shortcutJumpFirst => 'Hop til første hylde/bog';

  @override
  String get shortcutJumpLast => 'Hop til sidste hylde/bog';

  @override
  String get shortcutFocusSearch => 'Fokuser/defokuser søgefelt';

  @override
  String get shortcutSwitchFocus => 'Skift fokus mellem hylder og bøger';

  @override
  String get shortcutMoveDown => 'Flyt ned';

  @override
  String get shortcutMoveUp => 'Flyt op';

  @override
  String get shortcutMoveLeft => 'Flyt til venstre';

  @override
  String get shortcutMoveRight => 'Flyt til højre';

  @override
  String get shortcutMoveShelfDown => 'Flyt hylde ned';

  @override
  String get shortcutMoveShelfUp => 'Flyt hylde op';

  @override
  String get shortcutDeleteShelf => 'Slet hylde';

  @override
  String get shortcutOpenFocused => 'Åbn fokuseret bog';

  @override
  String get shortcutToggleSelection => 'Skift valg af fokuseret bog';

  @override
  String get shortcutRemoveFromShelf => 'Fjern valgte bøger fra hylde';

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
