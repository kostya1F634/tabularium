// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Your Personal Library';

  @override
  String get selectBooksDirectory => 'Select Books Directory';

  @override
  String get recentDirectories => 'Recent Directories';

  @override
  String get favorites => 'Favorites';

  @override
  String get clearRecent => 'Clear Recent';

  @override
  String get clearFavorites => 'Clear Favorites';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get directoryNotFound => 'Directory not found';

  @override
  String directoryNotFoundMessage(String path) {
    return 'The directory \"$path\" no longer exists or is not accessible. It has been removed from your recent directories.';
  }

  @override
  String get mainScreen => 'Main Screen';

  @override
  String get selectedDirectory => 'Selected directory:';

  @override
  String get error => 'Error';

  @override
  String errorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Russian';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get allBooks => 'All Books';

  @override
  String get unsortedBooks => 'Unsorted';

  @override
  String get shelves => 'Shelves';

  @override
  String get createShelf => 'Create Shelf';

  @override
  String get editShelf => 'Edit Shelf';

  @override
  String get shelfName => 'Shelf Name';

  @override
  String get deleteShelf => 'Delete Shelf';

  @override
  String get openAllBooks => 'Open All Books';

  @override
  String get searchBooks => 'Search books...';

  @override
  String get searchShelves => 'Search shelves...';

  @override
  String get noBooks => 'No books found';

  @override
  String get noBooksInShelf => 'No books in this shelf';

  @override
  String get scanForNewBooks => 'Scan for New Books';

  @override
  String get scan => 'Scan';

  @override
  String get initializingLibrary => 'Initializing library...';

  @override
  String get loadingLibrary => 'Loading library...';

  @override
  String get backToWelcome => 'Back to Welcome';

  @override
  String get addToShelf => 'Add to Shelf';

  @override
  String get removeFromShelf => 'Remove from Shelf';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count books',
      one: '1 book',
      zero: 'No books',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get create => 'Create';

  @override
  String get delete => 'Delete';

  @override
  String get selected => 'selected';

  @override
  String get openSelected => 'Open Selected';

  @override
  String get selectAll => 'Select All';

  @override
  String get clearSelection => 'Clear Selection';

  @override
  String get deleteFromShelf => 'Delete from Shelf';

  @override
  String get remove => 'Remove';

  @override
  String get open => 'Open';

  @override
  String get properties => 'Properties';

  @override
  String get bookProperties => 'Book Properties';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'File Path';

  @override
  String get author => 'Author';

  @override
  String get title => 'Title';

  @override
  String get pageCount => 'Pages';

  @override
  String get fileSize => 'File Size';

  @override
  String get save => 'Save';

  @override
  String get shortcuts => 'Shortcuts';

  @override
  String get keyboardShortcuts => 'Keyboard Shortcuts';

  @override
  String get deleteBook => 'Delete';

  @override
  String get deleteSelected => 'Delete Selected';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get confirmDeleteBook => 'Delete Book?';

  @override
  String get confirmDeleteBookMessage =>
      'This will permanently delete the book file from disk. This action cannot be undone.';

  @override
  String get confirmDeleteSelected => 'Delete Selected Books?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'book files',
      one: 'book file',
    );
    return 'This will permanently delete $count $_temp0 from disk. This action cannot be undone.';
  }

  @override
  String get confirmDeleteAll => 'Delete All Books?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'book files',
      one: 'book file',
    );
    return 'This will permanently delete all $count $_temp0 from this shelf from disk. This action cannot be undone.';
  }

  @override
  String get aboutTabularium => 'About Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Toggle View Mode';

  @override
  String get theme => 'Theme';

  @override
  String get help => 'Help';

  @override
  String get about => 'About';

  @override
  String get resetSettings => 'Reset Settings';

  @override
  String get fontSize => 'Font Size';

  @override
  String get bookScaleGrid => 'Book Scale (Grid)';

  @override
  String get bookScaleCabinet => 'Book Scale (Cabinet)';

  @override
  String get add => 'Add';

  @override
  String get selectShelf => 'Select Shelf';

  @override
  String get sortDateAddedNewest => 'Date Added ↓';

  @override
  String get sortDateAddedOldest => 'Date Added ↑';

  @override
  String get sortDateOpenedNewest => 'Date Opened ↓';

  @override
  String get sortDateOpenedOldest => 'Date Opened ↑';

  @override
  String get sortTitleAZ => 'Title A-Z';

  @override
  String get sortTitleZA => 'Title Z-A';

  @override
  String get searchThemes => 'Search themes...';

  @override
  String get sizeSmall => 'Small';

  @override
  String get sizeMedium => 'Medium';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Large';

  @override
  String get sizeExtraLarge => 'Extra Large';

  @override
  String get sizeTiny => 'Tiny';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'General';

  @override
  String get shortcutsNavigationShelves => 'Navigation - Shelves';

  @override
  String get shortcutsNavigationBooks => 'Navigation - Books';

  @override
  String get shortcutsShelves => 'Shelves';

  @override
  String get shortcutsBooks => 'Books';

  @override
  String get shortcutToggleScreen =>
      'Toggle between library and welcome screen';

  @override
  String get shortcutCreateShelf => 'Create new shelf';

  @override
  String get shortcutOpenBooks => 'Open books (all or selected)';

  @override
  String get shortcutSelectAll => 'Select all books';

  @override
  String get shortcutClearSelection => 'Clear selection';

  @override
  String get shortcutQuickShelf => 'Quick shelf selection (first 10 shelves)';

  @override
  String get shortcutEdit => 'Edit shelf / Book properties';

  @override
  String get shortcutToggleView => 'Toggle view mode (Grid/Cabinet)';

  @override
  String get shortcutAddToShelf => 'Add selected/focused/all books to shelf';

  @override
  String get shortcutFocusCenter => 'Focus on center visible book';

  @override
  String get shortcutJumpFirst => 'Jump to first shelf/book';

  @override
  String get shortcutJumpLast => 'Jump to last shelf/book';

  @override
  String get shortcutFocusSearch => 'Focus/unfocus search field';

  @override
  String get shortcutSwitchFocus => 'Switch focus between shelves and books';

  @override
  String get shortcutMoveDown => 'Move down';

  @override
  String get shortcutMoveUp => 'Move up';

  @override
  String get shortcutMoveLeft => 'Move left';

  @override
  String get shortcutMoveRight => 'Move right';

  @override
  String get shortcutMoveShelfDown => 'Move shelf down';

  @override
  String get shortcutMoveShelfUp => 'Move shelf up';

  @override
  String get shortcutDeleteShelf => 'Delete shelf';

  @override
  String get shortcutOpenFocused => 'Open focused book';

  @override
  String get shortcutToggleSelection => 'Toggle selection of focused book';

  @override
  String get shortcutRemoveFromShelf => 'Remove selected books from shelf';

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
}
