import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Tabularium'**
  String get appTitle;

  /// Application subtitle on welcome screen
  ///
  /// In en, this message translates to:
  /// **'Your Personal Library'**
  String get appSubtitle;

  /// Button text for selecting books directory
  ///
  /// In en, this message translates to:
  /// **'Select Books Directory'**
  String get selectBooksDirectory;

  /// Title for recent directories list
  ///
  /// In en, this message translates to:
  /// **'Recent Directories'**
  String get recentDirectories;

  /// Title for favorites directories list
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Button to clear recent directories
  ///
  /// In en, this message translates to:
  /// **'Clear Recent'**
  String get clearRecent;

  /// Button to clear favorite directories
  ///
  /// In en, this message translates to:
  /// **'Clear Favorites'**
  String get clearFavorites;

  /// Button to add directory to favorites
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// Button to remove directory from favorites
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// Error title when directory doesn't exist
  ///
  /// In en, this message translates to:
  /// **'Directory not found'**
  String get directoryNotFound;

  /// Error message when directory doesn't exist
  ///
  /// In en, this message translates to:
  /// **'The directory \"{path}\" no longer exists or is not accessible. It has been removed from your recent directories.'**
  String directoryNotFoundMessage(String path);

  /// Main screen title
  ///
  /// In en, this message translates to:
  /// **'Main Screen'**
  String get mainScreen;

  /// Label for selected directory path
  ///
  /// In en, this message translates to:
  /// **'Selected directory:'**
  String get selectedDirectory;

  /// Error label
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Error message with placeholder
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorMessage(String message);

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Russian language name
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// Settings menu item
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Name of default shelf with all books
  ///
  /// In en, this message translates to:
  /// **'All Books'**
  String get allBooks;

  /// Name of default shelf with unsorted books
  ///
  /// In en, this message translates to:
  /// **'Unsorted'**
  String get unsortedBooks;

  /// Title for shelves sidebar
  ///
  /// In en, this message translates to:
  /// **'Shelves'**
  String get shelves;

  /// Button to create new shelf
  ///
  /// In en, this message translates to:
  /// **'Create Shelf'**
  String get createShelf;

  /// Dialog title for editing shelf
  ///
  /// In en, this message translates to:
  /// **'Edit Shelf'**
  String get editShelf;

  /// Label for shelf name input
  ///
  /// In en, this message translates to:
  /// **'Shelf Name'**
  String get shelfName;

  /// Button to delete shelf
  ///
  /// In en, this message translates to:
  /// **'Delete Shelf'**
  String get deleteShelf;

  /// Button to open all books in current view
  ///
  /// In en, this message translates to:
  /// **'Open All Books'**
  String get openAllBooks;

  /// Placeholder for search input
  ///
  /// In en, this message translates to:
  /// **'Search books...'**
  String get searchBooks;

  /// Placeholder for shelf search input
  ///
  /// In en, this message translates to:
  /// **'Search shelves...'**
  String get searchShelves;

  /// Message when no books are in the library
  ///
  /// In en, this message translates to:
  /// **'No books found'**
  String get noBooks;

  /// Message when selected shelf is empty
  ///
  /// In en, this message translates to:
  /// **'No books in this shelf'**
  String get noBooksInShelf;

  /// Button to scan directory for new books
  ///
  /// In en, this message translates to:
  /// **'Scan for New Books'**
  String get scanForNewBooks;

  /// Menu item to scan for new books
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// Message during library initialization
  ///
  /// In en, this message translates to:
  /// **'Initializing library...'**
  String get initializingLibrary;

  /// Message during library loading
  ///
  /// In en, this message translates to:
  /// **'Loading library...'**
  String get loadingLibrary;

  /// Tooltip for button to return to welcome screen
  ///
  /// In en, this message translates to:
  /// **'Back to Welcome'**
  String get backToWelcome;

  /// Menu item to add book to shelf
  ///
  /// In en, this message translates to:
  /// **'Add to Shelf'**
  String get addToShelf;

  /// Button to remove book from shelf (context menu)
  ///
  /// In en, this message translates to:
  /// **'Remove from Shelf'**
  String get removeFromShelf;

  /// Display book count
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No books} =1{1 book} other{{count} books}}'**
  String bookCount(int count);

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Create button text
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Text showing number of selected items
  ///
  /// In en, this message translates to:
  /// **'selected'**
  String get selected;

  /// Button to open selected books
  ///
  /// In en, this message translates to:
  /// **'Open Selected'**
  String get openSelected;

  /// Button to select all books
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// Button to clear book selection
  ///
  /// In en, this message translates to:
  /// **'Clear Selection'**
  String get clearSelection;

  /// Button to delete selected books from shelf
  ///
  /// In en, this message translates to:
  /// **'Delete from Shelf'**
  String get deleteFromShelf;

  /// Remove menu item
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Open menu item
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Properties menu item
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// Book properties dialog title
  ///
  /// In en, this message translates to:
  /// **'Book Properties'**
  String get bookProperties;

  /// Book alias field label
  ///
  /// In en, this message translates to:
  /// **'Alias'**
  String get alias;

  /// File path field label
  ///
  /// In en, this message translates to:
  /// **'File Path'**
  String get filePath;

  /// Author field label
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// Title field label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Page count field label
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pageCount;

  /// File size field label
  ///
  /// In en, this message translates to:
  /// **'File Size'**
  String get fileSize;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Menu item for keyboard shortcuts
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get shortcuts;

  /// Dialog title for keyboard shortcuts
  ///
  /// In en, this message translates to:
  /// **'Keyboard Shortcuts'**
  String get keyboardShortcuts;

  /// Menu item to delete book
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteBook;

  /// Button to delete selected books
  ///
  /// In en, this message translates to:
  /// **'Delete Selected'**
  String get deleteSelected;

  /// Button to delete all books from current shelf
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// Confirmation dialog title for deleting a book
  ///
  /// In en, this message translates to:
  /// **'Delete Book?'**
  String get confirmDeleteBook;

  /// Confirmation message for deleting a book
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete the book file from disk. This action cannot be undone.'**
  String get confirmDeleteBookMessage;

  /// Confirmation dialog title for deleting selected books
  ///
  /// In en, this message translates to:
  /// **'Delete Selected Books?'**
  String get confirmDeleteSelected;

  /// Confirmation message for deleting selected books
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete {count} {count, plural, =1{book file} other{book files}} from disk. This action cannot be undone.'**
  String confirmDeleteSelectedMessage(int count);

  /// Confirmation dialog title for deleting all books from current shelf
  ///
  /// In en, this message translates to:
  /// **'Delete All Books?'**
  String get confirmDeleteAll;

  /// Confirmation message for deleting all books from current shelf
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all {count} {count, plural, =1{book file} other{book files}} from this shelf from disk. This action cannot be undone.'**
  String confirmDeleteAllMessage(int count);

  /// About dialog title
  ///
  /// In en, this message translates to:
  /// **'About Tabularium'**
  String get aboutTabularium;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Tooltip for toggle view mode button
  ///
  /// In en, this message translates to:
  /// **'Toggle View Mode'**
  String get toggleViewMode;

  /// Theme menu tooltip
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Help menu tooltip
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// About menu item
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Reset settings menu item
  ///
  /// In en, this message translates to:
  /// **'Reset Settings'**
  String get resetSettings;

  /// Font size setting label
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// Book scale for grid view setting label
  ///
  /// In en, this message translates to:
  /// **'Book Scale (Grid)'**
  String get bookScaleGrid;

  /// Book scale for cabinet view setting label
  ///
  /// In en, this message translates to:
  /// **'Book Scale (Cabinet)'**
  String get bookScaleCabinet;

  /// Add to shelf menu item
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Select shelf dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Shelf'**
  String get selectShelf;

  /// Sort by date added, newest first
  ///
  /// In en, this message translates to:
  /// **'Date Added ↓'**
  String get sortDateAddedNewest;

  /// Sort by date added, oldest first
  ///
  /// In en, this message translates to:
  /// **'Date Added ↑'**
  String get sortDateAddedOldest;

  /// Sort by date opened, newest first
  ///
  /// In en, this message translates to:
  /// **'Date Opened ↓'**
  String get sortDateOpenedNewest;

  /// Sort by date opened, oldest first
  ///
  /// In en, this message translates to:
  /// **'Date Opened ↑'**
  String get sortDateOpenedOldest;

  /// Sort by title A to Z
  ///
  /// In en, this message translates to:
  /// **'Title A-Z'**
  String get sortTitleAZ;

  /// Sort by title Z to A
  ///
  /// In en, this message translates to:
  /// **'Title Z-A'**
  String get sortTitleZA;

  /// Placeholder for theme search field
  ///
  /// In en, this message translates to:
  /// **'Search themes...'**
  String get searchThemes;

  /// Small size label
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get sizeSmall;

  /// Medium size label
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get sizeMedium;

  /// Normal size label
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get sizeNormal;

  /// Large size label
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get sizeLarge;

  /// Extra large size label
  ///
  /// In en, this message translates to:
  /// **'Extra Large'**
  String get sizeExtraLarge;

  /// Tiny size label
  ///
  /// In en, this message translates to:
  /// **'Tiny'**
  String get sizeTiny;

  /// XXL size label
  ///
  /// In en, this message translates to:
  /// **'XXL'**
  String get sizeXXL;

  /// No description provided for @shortcutsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get shortcutsGeneral;

  /// No description provided for @shortcutsNavigationShelves.
  ///
  /// In en, this message translates to:
  /// **'Navigation - Shelves'**
  String get shortcutsNavigationShelves;

  /// No description provided for @shortcutsNavigationBooks.
  ///
  /// In en, this message translates to:
  /// **'Navigation - Books'**
  String get shortcutsNavigationBooks;

  /// No description provided for @shortcutsShelves.
  ///
  /// In en, this message translates to:
  /// **'Shelves'**
  String get shortcutsShelves;

  /// No description provided for @shortcutsBooks.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get shortcutsBooks;

  /// No description provided for @shortcutToggleScreen.
  ///
  /// In en, this message translates to:
  /// **'Toggle between library and welcome screen'**
  String get shortcutToggleScreen;

  /// No description provided for @shortcutCreateShelf.
  ///
  /// In en, this message translates to:
  /// **'Create new shelf'**
  String get shortcutCreateShelf;

  /// No description provided for @shortcutOpenBooks.
  ///
  /// In en, this message translates to:
  /// **'Open books (all or selected)'**
  String get shortcutOpenBooks;

  /// No description provided for @shortcutSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all books'**
  String get shortcutSelectAll;

  /// No description provided for @shortcutClearSelection.
  ///
  /// In en, this message translates to:
  /// **'Clear selection'**
  String get shortcutClearSelection;

  /// No description provided for @shortcutQuickShelf.
  ///
  /// In en, this message translates to:
  /// **'Quick shelf selection (first 10 shelves)'**
  String get shortcutQuickShelf;

  /// No description provided for @shortcutEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit shelf / Book properties'**
  String get shortcutEdit;

  /// No description provided for @shortcutToggleView.
  ///
  /// In en, this message translates to:
  /// **'Toggle view mode (Grid/Cabinet)'**
  String get shortcutToggleView;

  /// No description provided for @shortcutAddToShelf.
  ///
  /// In en, this message translates to:
  /// **'Add selected/focused/all books to shelf'**
  String get shortcutAddToShelf;

  /// No description provided for @shortcutFocusCenter.
  ///
  /// In en, this message translates to:
  /// **'Focus on center visible book'**
  String get shortcutFocusCenter;

  /// No description provided for @shortcutJumpFirst.
  ///
  /// In en, this message translates to:
  /// **'Jump to first shelf/book'**
  String get shortcutJumpFirst;

  /// No description provided for @shortcutJumpLast.
  ///
  /// In en, this message translates to:
  /// **'Jump to last shelf/book'**
  String get shortcutJumpLast;

  /// No description provided for @shortcutFocusSearch.
  ///
  /// In en, this message translates to:
  /// **'Focus/unfocus search field'**
  String get shortcutFocusSearch;

  /// No description provided for @shortcutSwitchFocus.
  ///
  /// In en, this message translates to:
  /// **'Switch focus between shelves and books'**
  String get shortcutSwitchFocus;

  /// No description provided for @shortcutMoveDown.
  ///
  /// In en, this message translates to:
  /// **'Move down'**
  String get shortcutMoveDown;

  /// No description provided for @shortcutMoveUp.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get shortcutMoveUp;

  /// No description provided for @shortcutMoveLeft.
  ///
  /// In en, this message translates to:
  /// **'Move left'**
  String get shortcutMoveLeft;

  /// No description provided for @shortcutMoveRight.
  ///
  /// In en, this message translates to:
  /// **'Move right'**
  String get shortcutMoveRight;

  /// No description provided for @shortcutMoveShelfDown.
  ///
  /// In en, this message translates to:
  /// **'Move shelf down'**
  String get shortcutMoveShelfDown;

  /// No description provided for @shortcutMoveShelfUp.
  ///
  /// In en, this message translates to:
  /// **'Move shelf up'**
  String get shortcutMoveShelfUp;

  /// No description provided for @shortcutDeleteShelf.
  ///
  /// In en, this message translates to:
  /// **'Delete shelf'**
  String get shortcutDeleteShelf;

  /// No description provided for @shortcutOpenFocused.
  ///
  /// In en, this message translates to:
  /// **'Open focused book'**
  String get shortcutOpenFocused;

  /// No description provided for @shortcutToggleSelection.
  ///
  /// In en, this message translates to:
  /// **'Toggle selection of focused book'**
  String get shortcutToggleSelection;

  /// No description provided for @shortcutRemoveFromShelf.
  ///
  /// In en, this message translates to:
  /// **'Remove selected books from shelf'**
  String get shortcutRemoveFromShelf;

  /// No description provided for @ai.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get ai;

  /// No description provided for @aiSettings.
  ///
  /// In en, this message translates to:
  /// **'AI Settings'**
  String get aiSettings;

  /// No description provided for @aiFullSort.
  ///
  /// In en, this message translates to:
  /// **'Full Sort (AI)'**
  String get aiFullSort;

  /// No description provided for @ollamaUrl.
  ///
  /// In en, this message translates to:
  /// **'Ollama URL'**
  String get ollamaUrl;

  /// No description provided for @ollamaModel.
  ///
  /// In en, this message translates to:
  /// **'Ollama Model'**
  String get ollamaModel;

  /// No description provided for @generalization.
  ///
  /// In en, this message translates to:
  /// **'Generalization'**
  String get generalization;

  /// No description provided for @generalizationHint.
  ///
  /// In en, this message translates to:
  /// **'0 = many specific shelves, 1 = few broad shelves'**
  String get generalizationHint;

  /// No description provided for @testConnection.
  ///
  /// In en, this message translates to:
  /// **'Test Connection'**
  String get testConnection;

  /// No description provided for @connectionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Connection successful!'**
  String get connectionSuccess;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get connectionFailed;

  /// No description provided for @analyzeBook.
  ///
  /// In en, this message translates to:
  /// **'Analyzing book'**
  String get analyzeBook;

  /// No description provided for @analyzingBooks.
  ///
  /// In en, this message translates to:
  /// **'Analyzing books...'**
  String get analyzingBooks;

  /// No description provided for @sortingLibrary.
  ///
  /// In en, this message translates to:
  /// **'Sorting library...'**
  String get sortingLibrary;

  /// No description provided for @aiSortComplete.
  ///
  /// In en, this message translates to:
  /// **'AI sort complete'**
  String get aiSortComplete;

  /// No description provided for @aiSortFailed.
  ///
  /// In en, this message translates to:
  /// **'AI sort failed'**
  String get aiSortFailed;

  /// Number of books analyzed
  ///
  /// In en, this message translates to:
  /// **'{count} books analyzed'**
  String booksAnalyzed(int count);

  /// Number of new shelves created
  ///
  /// In en, this message translates to:
  /// **'{count} new shelves created'**
  String shelvesCreated(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'da',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'nl',
    'pl',
    'pt',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
