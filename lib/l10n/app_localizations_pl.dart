// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Osobista Biblioteka';

  @override
  String get selectBooksDirectory => 'Wybierz Folder';

  @override
  String get recentDirectories => 'Ostatnie';

  @override
  String get favorites => 'Ulubione';

  @override
  String get clearRecent => 'Wyczyść Ostatnie';

  @override
  String get clearFavorites => 'Wyczyść Ulubione';

  @override
  String get addToFavorites => 'Dodaj do Ulubionych';

  @override
  String get removeFromFavorites => 'Usuń z Ulubionych';

  @override
  String get directoryNotFound => 'Folder nie znaleziony';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Folder \"$path\" nie istnieje lub jest niedostępny. Został usunięty z ostatnich.';
  }

  @override
  String get mainScreen => 'Ekran Główny';

  @override
  String get selectedDirectory => 'Wybrany folder:';

  @override
  String get error => 'Błąd';

  @override
  String errorMessage(String message) {
    return 'Błąd: $message';
  }

  @override
  String get retry => 'Spróbuj Ponownie';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Ustawienia';

  @override
  String get language => 'Język';

  @override
  String get allBooks => 'Wszystkie Książki';

  @override
  String get unsortedBooks => 'Nieposortowane';

  @override
  String get shelves => 'Półki';

  @override
  String get createShelf => 'Utwórz Półkę';

  @override
  String get editShelf => 'Edytuj Półkę';

  @override
  String get shelfName => 'Nazwa Półki';

  @override
  String get deleteShelf => 'Usuń Półkę';

  @override
  String get openAllBooks => 'Otwórz Wszystkie';

  @override
  String get searchBooks => 'Szukaj książek...';

  @override
  String get searchShelves => 'Szukaj półek...';

  @override
  String get noBooks => 'Nie znaleziono książek';

  @override
  String get noBooksInShelf => 'Półka jest pusta';

  @override
  String get scanForNewBooks => 'Skanuj Nowe';

  @override
  String get scan => 'Skanuj';

  @override
  String get initializingLibrary => 'Inicjalizacja...';

  @override
  String get loadingLibrary => 'Ładowanie...';

  @override
  String get backToWelcome => 'Powrót';

  @override
  String get addToShelf => 'Dodaj do Półki';

  @override
  String get removeFromShelf => 'Usuń z Półki';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count książek',
      few: '$count książki',
      one: '1 książka',
      zero: 'Brak książek',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Anuluj';

  @override
  String get create => 'Utwórz';

  @override
  String get delete => 'Usuń';

  @override
  String get selected => 'zaznaczono';

  @override
  String get openSelected => 'Otwórz Zaznaczone';

  @override
  String get selectAll => 'Zaznacz Wszystkie';

  @override
  String get clearSelection => 'Wyczyść Zaznaczenie';

  @override
  String get deleteFromShelf => 'Usuń z Półki';

  @override
  String get remove => 'Usuń';

  @override
  String get open => 'Otwórz';

  @override
  String get properties => 'Właściwości';

  @override
  String get bookProperties => 'Właściwości Książki';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Ścieżka Pliku';

  @override
  String get author => 'Autor';

  @override
  String get title => 'Tytuł';

  @override
  String get pageCount => 'Strony';

  @override
  String get fileSize => 'Rozmiar Pliku';

  @override
  String get save => 'Zapisz';

  @override
  String get shortcuts => 'Skróty';

  @override
  String get keyboardShortcuts => 'Skróty Klawiszowe';

  @override
  String get deleteBook => 'Usuń';

  @override
  String get deleteSelected => 'Usuń Zaznaczone';

  @override
  String get deleteAll => 'Usuń Wszystkie';

  @override
  String get confirmDeleteBook => 'Usunąć Książkę?';

  @override
  String get confirmDeleteBookMessage =>
      'Plik zostanie trwale usunięty. Akcja nieodwracalna.';

  @override
  String get confirmDeleteSelected => 'Usunąć Zaznaczone?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików zostanie',
      few: 'pliki zostaną',
      one: 'plik zostanie',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'usuniętych',
      few: 'usunięte',
      one: 'usunięty',
    );
    return '$count $_temp0 trwale $_temp1. Akcja nieodwracalna.';
  }

  @override
  String get confirmDeleteAll => 'Usunąć Wszystkie?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików',
      few: 'pliki',
      one: 'plik',
    );
    return 'Wszystkie $count $_temp0 z tej półki zostaną trwale usunięte. Akcja nieodwracalna.';
  }

  @override
  String get aboutTabularium => 'O Programie';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Przełącz Widok';

  @override
  String get theme => 'Motyw';

  @override
  String get help => 'Pomoc';

  @override
  String get about => 'O Programie';

  @override
  String get resetSettings => 'Resetuj';

  @override
  String get fontSize => 'Rozmiar Czcionki';

  @override
  String get bookScaleGrid => 'Skala (Siatka)';

  @override
  String get bookScaleCabinet => 'Skala (Szafa)';

  @override
  String get add => 'Dodaj';

  @override
  String get selectShelf => 'Wybierz Półkę';

  @override
  String get sortDateAddedNewest => 'Dodano ↓';

  @override
  String get sortDateAddedOldest => 'Dodano ↑';

  @override
  String get sortDateOpenedNewest => 'Otwarto ↓';

  @override
  String get sortDateOpenedOldest => 'Otwarto ↑';

  @override
  String get sortTitleAZ => 'Tytuł A-Z';

  @override
  String get sortTitleZA => 'Tytuł Z-A';

  @override
  String get searchThemes => 'Szukaj motywów...';

  @override
  String get sizeSmall => 'Mały';

  @override
  String get sizeMedium => 'Średni';

  @override
  String get sizeNormal => 'Normalny';

  @override
  String get sizeLarge => 'Duży';

  @override
  String get sizeExtraLarge => 'Bardzo duży';

  @override
  String get sizeTiny => 'Malutki';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Ogólne';

  @override
  String get shortcutsNavigationShelves => 'Nawigacja - Półki';

  @override
  String get shortcutsNavigationBooks => 'Nawigacja - Książki';

  @override
  String get shortcutsShelves => 'Półki';

  @override
  String get shortcutsBooks => 'Książki';

  @override
  String get shortcutToggleScreen =>
      'Przełącz między biblioteką a ekranem powitalnym';

  @override
  String get shortcutCreateShelf => 'Utwórz nową półkę';

  @override
  String get shortcutOpenBooks => 'Otwórz książki (wszystkie lub zaznaczone)';

  @override
  String get shortcutSelectAll => 'Zaznacz wszystkie';

  @override
  String get shortcutClearSelection => 'Wyczyść zaznaczenie';

  @override
  String get shortcutQuickShelf => 'Szybki wybór półki (pierwsze 10)';

  @override
  String get shortcutEdit => 'Edytuj półkę / Właściwości książki';

  @override
  String get shortcutToggleView => 'Przełącz tryb widoku (Siatka/Szafa)';

  @override
  String get shortcutAddToShelf =>
      'Dodaj książki do półki (zaznaczone/fokus/wszystkie)';

  @override
  String get shortcutFocusCenter => 'Fokus na centralną widoczną książkę';

  @override
  String get shortcutJumpFirst => 'Skocz do pierwszej półki/książki';

  @override
  String get shortcutJumpLast => 'Skocz do ostatniej półki/książki';

  @override
  String get shortcutFocusSearch => 'Fokus/defokus pole wyszukiwania';

  @override
  String get shortcutSwitchFocus => 'Przełącz fokus między półkami a książkami';

  @override
  String get shortcutMoveDown => 'Przesuń w dół';

  @override
  String get shortcutMoveUp => 'Przesuń w górę';

  @override
  String get shortcutMoveLeft => 'Przesuń w lewo';

  @override
  String get shortcutMoveRight => 'Przesuń w prawo';

  @override
  String get shortcutMoveShelfDown => 'Przesuń półkę w dół';

  @override
  String get shortcutMoveShelfUp => 'Przesuń półkę w górę';

  @override
  String get shortcutDeleteShelf => 'Usuń półkę';

  @override
  String get shortcutOpenFocused => 'Otwórz książkę w fokusie';

  @override
  String get shortcutToggleSelection =>
      'Przełącz zaznaczenie książki w fokusie';

  @override
  String get shortcutRemoveFromShelf => 'Usuń zaznaczone książki z półki';

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
