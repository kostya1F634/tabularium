import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
    Locale('en'),
    Locale('ru'),
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
