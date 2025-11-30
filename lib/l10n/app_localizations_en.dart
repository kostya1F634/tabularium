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
}
