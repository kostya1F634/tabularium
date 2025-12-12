// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'La Sua Biblioteca Personale';

  @override
  String get selectBooksDirectory => 'Seleziona Cartella';

  @override
  String get recentDirectories => 'Recenti';

  @override
  String get favorites => 'Preferiti';

  @override
  String get clearRecent => 'Cancella Recenti';

  @override
  String get clearFavorites => 'Cancella Preferiti';

  @override
  String get addToFavorites => 'Aggiungi ai Preferiti';

  @override
  String get removeFromFavorites => 'Rimuovi dai Preferiti';

  @override
  String get directoryNotFound => 'Cartella non trovata';

  @override
  String directoryNotFoundMessage(String path) {
    return 'La cartella \"$path\" non esiste più o non è accessibile. È stata rimossa dai recenti.';
  }

  @override
  String get mainScreen => 'Schermata Principale';

  @override
  String get selectedDirectory => 'Cartella selezionata:';

  @override
  String get error => 'Errore';

  @override
  String errorMessage(String message) {
    return 'Errore: $message';
  }

  @override
  String get retry => 'Riprova';

  @override
  String get loading => 'Caricamento...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Impostazioni';

  @override
  String get language => 'Lingua';

  @override
  String get allBooks => 'Tutti i Libri';

  @override
  String get unsortedBooks => 'Non Ordinati';

  @override
  String get shelves => 'Scaffali';

  @override
  String get createShelf => 'Crea Scaffale';

  @override
  String get editShelf => 'Modifica Scaffale';

  @override
  String get shelfName => 'Nome Scaffale';

  @override
  String get deleteShelf => 'Elimina Scaffale';

  @override
  String get openAllBooks => 'Apri Tutti';

  @override
  String get searchBooks => 'Cerca libri...';

  @override
  String get searchShelves => 'Cerca scaffali...';

  @override
  String get noBooks => 'Nessun libro trovato';

  @override
  String get noBooksInShelf => 'Scaffale vuoto';

  @override
  String get scanForNewBooks => 'Scansiona Nuovi';

  @override
  String get scan => 'Scansiona';

  @override
  String get initializingLibrary => 'Inizializzazione...';

  @override
  String get loadingLibrary => 'Caricamento...';

  @override
  String get backToWelcome => 'Indietro';

  @override
  String get addToShelf => 'Aggiungi allo Scaffale';

  @override
  String get removeFromShelf => 'Rimuovi dallo Scaffale';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count libri',
      one: '1 libro',
      zero: 'Nessun libro',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Annulla';

  @override
  String get create => 'Crea';

  @override
  String get delete => 'Elimina';

  @override
  String get selected => 'selezionato/i';

  @override
  String get openSelected => 'Apri Selezionati';

  @override
  String get selectAll => 'Seleziona Tutto';

  @override
  String get clearSelection => 'Cancella Selezione';

  @override
  String get deleteFromShelf => 'Elimina dallo Scaffale';

  @override
  String get remove => 'Rimuovi';

  @override
  String get open => 'Apri';

  @override
  String get properties => 'Proprietà';

  @override
  String get bookProperties => 'Proprietà Libro';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Percorso File';

  @override
  String get author => 'Autore';

  @override
  String get title => 'Titolo';

  @override
  String get pageCount => 'Pagine';

  @override
  String get fileSize => 'Dimensione';

  @override
  String get save => 'Salva';

  @override
  String get shortcuts => 'Scorciatoie';

  @override
  String get keyboardShortcuts => 'Scorciatoie Tastiera';

  @override
  String get deleteBook => 'Elimina';

  @override
  String get deleteSelected => 'Elimina Selezionati';

  @override
  String get deleteAll => 'Elimina Tutto';

  @override
  String get confirmDeleteBook => 'Eliminare Libro?';

  @override
  String get confirmDeleteBookMessage =>
      'Il file verrà eliminato permanentemente. Azione irreversibile.';

  @override
  String get confirmDeleteSelected => 'Eliminare Selezionati?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file verranno eliminati',
      one: 'file verrà eliminato',
    );
    return '$count $_temp0 permanentemente. Azione irreversibile.';
  }

  @override
  String get confirmDeleteAll => 'Eliminare Tutto?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file',
      one: 'file',
    );
    return 'Tutti i $count $_temp0 di questo scaffale verranno eliminati permanentemente. Azione irreversibile.';
  }

  @override
  String get aboutTabularium => 'Informazioni';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Cambia Vista';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Aiuto';

  @override
  String get about => 'Informazioni';

  @override
  String get resetSettings => 'Ripristina';

  @override
  String get fontSize => 'Dimensione Font';

  @override
  String get bookScaleGrid => 'Scala (Griglia)';

  @override
  String get bookScaleCabinet => 'Scala (Libreria)';

  @override
  String get add => 'Aggiungi';

  @override
  String get selectShelf => 'Seleziona Scaffale';

  @override
  String get sortDateAddedNewest => 'Aggiunto ↓';

  @override
  String get sortDateAddedOldest => 'Aggiunto ↑';

  @override
  String get sortDateOpenedNewest => 'Aperto ↓';

  @override
  String get sortDateOpenedOldest => 'Aperto ↑';

  @override
  String get sortTitleAZ => 'Titolo A-Z';

  @override
  String get sortTitleZA => 'Titolo Z-A';

  @override
  String get searchThemes => 'Cerca temi...';

  @override
  String get sizeSmall => 'Piccolo';

  @override
  String get sizeMedium => 'Medio';

  @override
  String get sizeNormal => 'Normale';

  @override
  String get sizeLarge => 'Grande';

  @override
  String get sizeExtraLarge => 'Molto grande';

  @override
  String get sizeTiny => 'Minuscolo';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Generale';

  @override
  String get shortcutsNavigationShelves => 'Navigazione - Scaffali';

  @override
  String get shortcutsNavigationBooks => 'Navigazione - Libri';

  @override
  String get shortcutsShelves => 'Scaffali';

  @override
  String get shortcutsBooks => 'Libri';

  @override
  String get shortcutToggleScreen =>
      'Passa tra biblioteca e schermata di benvenuto';

  @override
  String get shortcutCreateShelf => 'Crea nuovo scaffale';

  @override
  String get shortcutOpenBooks => 'Apri libri (tutti o selezionati)';

  @override
  String get shortcutSelectAll => 'Seleziona tutto';

  @override
  String get shortcutClearSelection => 'Cancella selezione';

  @override
  String get shortcutQuickShelf => 'Selezione rapida scaffale (primi 10)';

  @override
  String get shortcutEdit => 'Modifica scaffale / Proprietà libro';

  @override
  String get shortcutToggleView => 'Cambia modalità vista (Griglia/Libreria)';

  @override
  String get shortcutAddToShelf =>
      'Aggiungi libri a scaffale (selezionati/focus/tutti)';

  @override
  String get shortcutFocusCenter => 'Focalizza libro centrale visibile';

  @override
  String get shortcutJumpFirst => 'Vai al primo scaffale/libro';

  @override
  String get shortcutJumpLast => 'Vai all\'ultimo scaffale/libro';

  @override
  String get shortcutFocusSearch => 'Focalizza/defocalizza campo di ricerca';

  @override
  String get shortcutSwitchFocus => 'Cambia focus tra scaffali e libri';

  @override
  String get shortcutMoveDown => 'Sposta giù';

  @override
  String get shortcutMoveUp => 'Sposta su';

  @override
  String get shortcutMoveLeft => 'Sposta a sinistra';

  @override
  String get shortcutMoveRight => 'Sposta a destra';

  @override
  String get shortcutMoveShelfDown => 'Sposta scaffale giù';

  @override
  String get shortcutMoveShelfUp => 'Sposta scaffale su';

  @override
  String get shortcutDeleteShelf => 'Elimina scaffale';

  @override
  String get shortcutOpenFocused => 'Apri libro focalizzato';

  @override
  String get shortcutToggleSelection => 'Cambia selezione libro focalizzato';

  @override
  String get shortcutRemoveFromShelf =>
      'Rimuovi libri selezionati dallo scaffale';

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
