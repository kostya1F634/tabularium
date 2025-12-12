// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Ihre Persönliche Bibliothek';

  @override
  String get selectBooksDirectory => 'Ordner Auswählen';

  @override
  String get recentDirectories => 'Zuletzt Verwendet';

  @override
  String get favorites => 'Favoriten';

  @override
  String get clearRecent => 'Zuletzt Löschen';

  @override
  String get clearFavorites => 'Favoriten Löschen';

  @override
  String get addToFavorites => 'Zu Favoriten';

  @override
  String get removeFromFavorites => 'Aus Favoriten';

  @override
  String get directoryNotFound => 'Ordner nicht gefunden';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Der Ordner \"$path\" existiert nicht mehr oder ist nicht zugänglich. Er wurde aus den zuletzt verwendeten entfernt.';
  }

  @override
  String get mainScreen => 'Hauptbildschirm';

  @override
  String get selectedDirectory => 'Ausgewählter Ordner:';

  @override
  String get error => 'Fehler';

  @override
  String errorMessage(String message) {
    return 'Fehler: $message';
  }

  @override
  String get retry => 'Wiederholen';

  @override
  String get loading => 'Laden...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get allBooks => 'Alle Bücher';

  @override
  String get unsortedBooks => 'Unsortiert';

  @override
  String get shelves => 'Regale';

  @override
  String get createShelf => 'Regal Erstellen';

  @override
  String get editShelf => 'Regal Bearbeiten';

  @override
  String get shelfName => 'Regalname';

  @override
  String get deleteShelf => 'Regal Löschen';

  @override
  String get openAllBooks => 'Alle Öffnen';

  @override
  String get searchBooks => 'Bücher suchen...';

  @override
  String get searchShelves => 'Regale suchen...';

  @override
  String get noBooks => 'Keine Bücher gefunden';

  @override
  String get noBooksInShelf => 'Regal ist leer';

  @override
  String get scanForNewBooks => 'Neue Scannen';

  @override
  String get scan => 'Scannen';

  @override
  String get initializingLibrary => 'Initialisierung...';

  @override
  String get loadingLibrary => 'Laden...';

  @override
  String get backToWelcome => 'Zurück';

  @override
  String get addToShelf => 'Zu Regal Hinzufügen';

  @override
  String get removeFromShelf => 'Aus Regal Entfernen';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bücher',
      one: '1 Buch',
      zero: 'Keine Bücher',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get create => 'Erstellen';

  @override
  String get delete => 'Löschen';

  @override
  String get selected => 'ausgewählt';

  @override
  String get openSelected => 'Auswahl Öffnen';

  @override
  String get selectAll => 'Alles Auswählen';

  @override
  String get clearSelection => 'Auswahl Aufheben';

  @override
  String get deleteFromShelf => 'Aus Regal Löschen';

  @override
  String get remove => 'Entfernen';

  @override
  String get open => 'Öffnen';

  @override
  String get properties => 'Eigenschaften';

  @override
  String get bookProperties => 'Bucheigenschaften';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Dateipfad';

  @override
  String get author => 'Autor';

  @override
  String get title => 'Titel';

  @override
  String get pageCount => 'Seiten';

  @override
  String get fileSize => 'Dateigröße';

  @override
  String get save => 'Speichern';

  @override
  String get shortcuts => 'Tastenkürzel';

  @override
  String get keyboardShortcuts => 'Tastaturkürzel';

  @override
  String get deleteBook => 'Löschen';

  @override
  String get deleteSelected => 'Auswahl Löschen';

  @override
  String get deleteAll => 'Alles Löschen';

  @override
  String get confirmDeleteBook => 'Buch Löschen?';

  @override
  String get confirmDeleteBookMessage =>
      'Die Datei wird dauerhaft gelöscht. Aktion unwiderruflich.';

  @override
  String get confirmDeleteSelected => 'Auswahl Löschen?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien werden',
      one: 'Datei wird',
    );
    return '$count $_temp0 dauerhaft gelöscht. Aktion unwiderruflich.';
  }

  @override
  String get confirmDeleteAll => 'Alles Löschen?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien',
      one: 'Datei',
    );
    return 'Alle $count $_temp0 dieses Regals werden dauerhaft gelöscht. Aktion unwiderruflich.';
  }

  @override
  String get aboutTabularium => 'Über Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Ansicht Wechseln';

  @override
  String get theme => 'Design';

  @override
  String get help => 'Hilfe';

  @override
  String get about => 'Über';

  @override
  String get resetSettings => 'Zurücksetzen';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get bookScaleGrid => 'Skalierung (Raster)';

  @override
  String get bookScaleCabinet => 'Skalierung (Regal)';

  @override
  String get add => 'Hinzufügen';

  @override
  String get selectShelf => 'Regal Auswählen';

  @override
  String get sortDateAddedNewest => 'Hinzugefügt ↓';

  @override
  String get sortDateAddedOldest => 'Hinzugefügt ↑';

  @override
  String get sortDateOpenedNewest => 'Geöffnet ↓';

  @override
  String get sortDateOpenedOldest => 'Geöffnet ↑';

  @override
  String get sortTitleAZ => 'Titel A-Z';

  @override
  String get sortTitleZA => 'Titel Z-A';

  @override
  String get searchThemes => 'Themen suchen...';

  @override
  String get sizeSmall => 'Klein';

  @override
  String get sizeMedium => 'Mittel';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Groß';

  @override
  String get sizeExtraLarge => 'Sehr groß';

  @override
  String get sizeTiny => 'Sehr klein';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Allgemein';

  @override
  String get shortcutsNavigationShelves => 'Navigation - Regale';

  @override
  String get shortcutsNavigationBooks => 'Navigation - Bücher';

  @override
  String get shortcutsShelves => 'Regale';

  @override
  String get shortcutsBooks => 'Bücher';

  @override
  String get shortcutToggleScreen =>
      'Zwischen Bibliothek und Startbildschirm wechseln';

  @override
  String get shortcutCreateShelf => 'Neues Regal erstellen';

  @override
  String get shortcutOpenBooks => 'Bücher öffnen (alle oder ausgewählte)';

  @override
  String get shortcutSelectAll => 'Alle Bücher auswählen';

  @override
  String get shortcutClearSelection => 'Auswahl aufheben';

  @override
  String get shortcutQuickShelf => 'Schnellauswahl Regal (erste 10)';

  @override
  String get shortcutEdit => 'Regal bearbeiten / Bucheigenschaften';

  @override
  String get shortcutToggleView => 'Ansichtsmodus wechseln (Raster/Regal)';

  @override
  String get shortcutAddToShelf =>
      'Bücher zu Regal hinzufügen (ausgewählt/fokussiert/alle)';

  @override
  String get shortcutFocusCenter => 'Mittleres sichtbares Buch fokussieren';

  @override
  String get shortcutJumpFirst => 'Zum ersten Regal/Buch springen';

  @override
  String get shortcutJumpLast => 'Zum letzten Regal/Buch springen';

  @override
  String get shortcutFocusSearch => 'Suchfeld fokussieren/aufheben';

  @override
  String get shortcutSwitchFocus =>
      'Fokus zwischen Regalen und Büchern wechseln';

  @override
  String get shortcutMoveDown => 'Nach unten bewegen';

  @override
  String get shortcutMoveUp => 'Nach oben bewegen';

  @override
  String get shortcutMoveLeft => 'Nach links bewegen';

  @override
  String get shortcutMoveRight => 'Nach rechts bewegen';

  @override
  String get shortcutMoveShelfDown => 'Regal nach unten bewegen';

  @override
  String get shortcutMoveShelfUp => 'Regal nach oben bewegen';

  @override
  String get shortcutDeleteShelf => 'Regal löschen';

  @override
  String get shortcutOpenFocused => 'Fokussiertes Buch öffnen';

  @override
  String get shortcutToggleSelection =>
      'Auswahl des fokussierten Buchs umschalten';

  @override
  String get shortcutRemoveFromShelf =>
      'Ausgewählte Bücher aus Regal entfernen';

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
