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
  String get shelves => 'Shelves';

  @override
  String get createShelf => 'Create Shelf';

  @override
  String get shelfName => 'Shelf Name';

  @override
  String get deleteShelf => 'Delete Shelf';

  @override
  String get openAllBooks => 'Open All Books';

  @override
  String get searchBooks => 'Search books...';

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
}
