// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Uw Persoonlijke Bibliotheek';

  @override
  String get selectBooksDirectory => 'Map Selecteren';

  @override
  String get recentDirectories => 'Recente';

  @override
  String get favorites => 'Favorieten';

  @override
  String get clearRecent => 'Recente Wissen';

  @override
  String get clearFavorites => 'Favorieten Wissen';

  @override
  String get addToFavorites => 'Aan Favorieten';

  @override
  String get removeFromFavorites => 'Uit Favorieten';

  @override
  String get directoryNotFound => 'Map niet gevonden';

  @override
  String directoryNotFoundMessage(String path) {
    return 'De map \"$path\" bestaat niet meer of is niet toegankelijk. Het is verwijderd uit recente.';
  }

  @override
  String get mainScreen => 'Hoofdscherm';

  @override
  String get selectedDirectory => 'Geselecteerde map:';

  @override
  String get error => 'Fout';

  @override
  String errorMessage(String message) {
    return 'Fout: $message';
  }

  @override
  String get retry => 'Opnieuw';

  @override
  String get loading => 'Laden...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Instellingen';

  @override
  String get language => 'Taal';

  @override
  String get allBooks => 'Alle Boeken';

  @override
  String get unsortedBooks => 'Ongesorteerd';

  @override
  String get shelves => 'Planken';

  @override
  String get createShelf => 'Plank Maken';

  @override
  String get editShelf => 'Plank Bewerken';

  @override
  String get shelfName => 'Planknaam';

  @override
  String get deleteShelf => 'Plank Verwijderen';

  @override
  String get openAllBooks => 'Alles Openen';

  @override
  String get searchBooks => 'Boeken zoeken...';

  @override
  String get searchShelves => 'Planken zoeken...';

  @override
  String get noBooks => 'Geen boeken gevonden';

  @override
  String get noBooksInShelf => 'Plank is leeg';

  @override
  String get scanForNewBooks => 'Nieuwe Scannen';

  @override
  String get scan => 'Scannen';

  @override
  String get initializingLibrary => 'Initialiseren...';

  @override
  String get loadingLibrary => 'Laden...';

  @override
  String get backToWelcome => 'Terug';

  @override
  String get addToShelf => 'Aan Plank Toevoegen';

  @override
  String get removeFromShelf => 'Van Plank Verwijderen';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count boeken',
      one: '1 boek',
      zero: 'Geen boeken',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Annuleren';

  @override
  String get create => 'Maken';

  @override
  String get delete => 'Verwijderen';

  @override
  String get selected => 'geselecteerd';

  @override
  String get openSelected => 'Selectie Openen';

  @override
  String get selectAll => 'Alles Selecteren';

  @override
  String get clearSelection => 'Selectie Wissen';

  @override
  String get deleteFromShelf => 'Van Plank Verwijderen';

  @override
  String get remove => 'Verwijderen';

  @override
  String get open => 'Openen';

  @override
  String get properties => 'Eigenschappen';

  @override
  String get bookProperties => 'Boekeigenschappen';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Bestandspad';

  @override
  String get author => 'Auteur';

  @override
  String get title => 'Titel';

  @override
  String get pageCount => 'Pagina\'s';

  @override
  String get fileSize => 'Bestandsgrootte';

  @override
  String get save => 'Opslaan';

  @override
  String get shortcuts => 'Sneltoetsen';

  @override
  String get keyboardShortcuts => 'Toetsenbordsneltoetsen';

  @override
  String get deleteBook => 'Verwijderen';

  @override
  String get deleteSelected => 'Selectie Verwijderen';

  @override
  String get deleteAll => 'Alles Verwijderen';

  @override
  String get confirmDeleteBook => 'Boek Verwijderen?';

  @override
  String get confirmDeleteBookMessage =>
      'Het bestand wordt permanent verwijderd. Actie onomkeerbaar.';

  @override
  String get confirmDeleteSelected => 'Selectie Verwijderen?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bestanden worden',
      one: 'bestand wordt',
    );
    return '$count $_temp0 permanent verwijderd. Actie onomkeerbaar.';
  }

  @override
  String get confirmDeleteAll => 'Alles Verwijderen?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bestanden',
      one: 'bestand',
    );
    return 'Alle $count $_temp0 van deze plank worden permanent verwijderd. Actie onomkeerbaar.';
  }

  @override
  String get aboutTabularium => 'Over Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Weergave Wisselen';

  @override
  String get theme => 'Thema';

  @override
  String get help => 'Help';

  @override
  String get about => 'Over';

  @override
  String get resetSettings => 'Resetten';

  @override
  String get fontSize => 'Lettergrootte';

  @override
  String get bookScaleGrid => 'Schaal (Raster)';

  @override
  String get bookScaleCabinet => 'Schaal (Kast)';

  @override
  String get add => 'Toevoegen';

  @override
  String get selectShelf => 'Plank Selecteren';

  @override
  String get sortDateAddedNewest => 'Toegevoegd ↓';

  @override
  String get sortDateAddedOldest => 'Toegevoegd ↑';

  @override
  String get sortDateOpenedNewest => 'Geopend ↓';

  @override
  String get sortDateOpenedOldest => 'Geopend ↑';

  @override
  String get sortTitleAZ => 'Titel A-Z';

  @override
  String get sortTitleZA => 'Titel Z-A';

  @override
  String get searchThemes => 'Thema\'s zoeken...';

  @override
  String get sizeSmall => 'Klein';

  @override
  String get sizeMedium => 'Gemiddeld';

  @override
  String get sizeNormal => 'Normaal';

  @override
  String get sizeLarge => 'Groot';

  @override
  String get sizeExtraLarge => 'Extra groot';

  @override
  String get sizeTiny => 'Zeer klein';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Algemeen';

  @override
  String get shortcutsNavigationShelves => 'Navigatie - Planken';

  @override
  String get shortcutsNavigationBooks => 'Navigatie - Boeken';

  @override
  String get shortcutsShelves => 'Planken';

  @override
  String get shortcutsBooks => 'Boeken';

  @override
  String get shortcutToggleScreen =>
      'Schakelen tussen bibliotheek en welkomstscherm';

  @override
  String get shortcutCreateShelf => 'Nieuwe plank maken';

  @override
  String get shortcutOpenBooks => 'Boeken openen (alle of geselecteerd)';

  @override
  String get shortcutSelectAll => 'Alles selecteren';

  @override
  String get shortcutClearSelection => 'Selectie wissen';

  @override
  String get shortcutQuickShelf => 'Snelle plankselectie (eerste 10)';

  @override
  String get shortcutEdit => 'Plank bewerken / Boekeigenschappen';

  @override
  String get shortcutToggleView => 'Weergavemodus wisselen (Raster/Kast)';

  @override
  String get shortcutAddToShelf =>
      'Boeken toevoegen aan plank (geselecteerd/focus/alle)';

  @override
  String get shortcutFocusCenter => 'Focus op centraal zichtbaar boek';

  @override
  String get shortcutJumpFirst => 'Spring naar eerste plank/boek';

  @override
  String get shortcutJumpLast => 'Spring naar laatste plank/boek';

  @override
  String get shortcutFocusSearch => 'Zoekveld focus/defocus';

  @override
  String get shortcutSwitchFocus => 'Wissel focus tussen planken en boeken';

  @override
  String get shortcutMoveDown => 'Naar beneden';

  @override
  String get shortcutMoveUp => 'Naar boven';

  @override
  String get shortcutMoveLeft => 'Naar links';

  @override
  String get shortcutMoveRight => 'Naar rechts';

  @override
  String get shortcutMoveShelfDown => 'Plank naar beneden';

  @override
  String get shortcutMoveShelfUp => 'Plank naar boven';

  @override
  String get shortcutDeleteShelf => 'Plank verwijderen';

  @override
  String get shortcutOpenFocused => 'Gefocust boek openen';

  @override
  String get shortcutToggleSelection => 'Selectie van gefocust boek wisselen';

  @override
  String get shortcutRemoveFromShelf =>
      'Geselecteerde boeken van plank verwijderen';

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
