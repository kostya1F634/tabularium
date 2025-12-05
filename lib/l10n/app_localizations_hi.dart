// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'आपकी व्यक्तिगत लाइब्रेरी';

  @override
  String get selectBooksDirectory => 'किताबों का फ़ोल्डर चुनें';

  @override
  String get recentDirectories => 'हाल ही के';

  @override
  String get favorites => 'पसंदीदा';

  @override
  String get clearRecent => 'हाल ही के साफ़ करें';

  @override
  String get clearFavorites => 'पसंदीदा साफ़ करें';

  @override
  String get addToFavorites => 'पसंदीदा में जोड़ें';

  @override
  String get removeFromFavorites => 'पसंदीदा से हटाएं';

  @override
  String get directoryNotFound => 'फ़ोल्डर नहीं मिला';

  @override
  String directoryNotFoundMessage(String path) {
    return 'फ़ोल्डर \"$path\" मौजूद नहीं है या पहुंच योग्य नहीं है। इसे हाल ही के से हटा दिया गया है।';
  }

  @override
  String get mainScreen => 'मुख्य स्क्रीन';

  @override
  String get selectedDirectory => 'चयनित फ़ोल्डर:';

  @override
  String get error => 'त्रुटि';

  @override
  String errorMessage(String message) {
    return 'त्रुटि: $message';
  }

  @override
  String get retry => 'पुनः प्रयास';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get language => 'भाषा';

  @override
  String get allBooks => 'सभी किताबें';

  @override
  String get unsortedBooks => 'अवर्गीकृत';

  @override
  String get shelves => 'शेल्फ़';

  @override
  String get createShelf => 'शेल्फ़ बनाएं';

  @override
  String get editShelf => 'शेल्फ़ संपादित करें';

  @override
  String get shelfName => 'शेल्फ़ का नाम';

  @override
  String get deleteShelf => 'शेल्फ़ हटाएं';

  @override
  String get openAllBooks => 'सभी खोलें';

  @override
  String get searchBooks => 'किताबें खोजें...';

  @override
  String get searchShelves => 'शेल्फ़ खोजें...';

  @override
  String get noBooks => 'कोई किताब नहीं मिली';

  @override
  String get noBooksInShelf => 'शेल्फ़ खाली है';

  @override
  String get scanForNewBooks => 'नई किताबें स्कैन करें';

  @override
  String get scan => 'स्कैन करें';

  @override
  String get initializingLibrary => 'प्रारंभ हो रहा है...';

  @override
  String get loadingLibrary => 'लोड हो रहा है...';

  @override
  String get backToWelcome => 'वापस जाएं';

  @override
  String get addToShelf => 'शेल्फ़ में जोड़ें';

  @override
  String get removeFromShelf => 'शेल्फ़ से हटाएं';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count किताबें',
      one: '1 किताब',
      zero: 'कोई किताब नहीं',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'रद्द करें';

  @override
  String get create => 'बनाएं';

  @override
  String get delete => 'हटाएं';

  @override
  String get selected => 'चयनित';

  @override
  String get openSelected => 'चयनित खोलें';

  @override
  String get selectAll => 'सभी चुनें';

  @override
  String get clearSelection => 'चयन साफ़ करें';

  @override
  String get deleteFromShelf => 'शेल्फ़ से हटाएं';

  @override
  String get remove => 'हटाएं';

  @override
  String get open => 'खोलें';

  @override
  String get properties => 'गुण';

  @override
  String get bookProperties => 'किताब के गुण';

  @override
  String get alias => 'उपनाम';

  @override
  String get filePath => 'फ़ाइल पथ';

  @override
  String get author => 'लेखक';

  @override
  String get title => 'शीर्षक';

  @override
  String get pageCount => 'पृष्ठ';

  @override
  String get fileSize => 'फ़ाइल आकार';

  @override
  String get save => 'सहेजें';

  @override
  String get shortcuts => 'शॉर्टकट';

  @override
  String get keyboardShortcuts => 'कीबोर्ड शॉर्टकट';

  @override
  String get deleteBook => 'हटाएं';

  @override
  String get deleteSelected => 'चयनित हटाएं';

  @override
  String get deleteAll => 'सभी हटाएं';

  @override
  String get confirmDeleteBook => 'किताब हटाएं?';

  @override
  String get confirmDeleteBookMessage =>
      'फ़ाइल स्थायी रूप से हटा दी जाएगी। यह क्रिया अपरिवर्तनीय है।';

  @override
  String get confirmDeleteSelected => 'चयनित हटाएं?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return '$count फ़ाइलें स्थायी रूप से हटा दी जाएंगी। यह क्रिया अपरिवर्तनीय है।';
  }

  @override
  String get confirmDeleteAll => 'सभी हटाएं?';

  @override
  String confirmDeleteAllMessage(int count) {
    return 'इस शेल्फ़ की सभी $count फ़ाइलें स्थायी रूप से हटा दी जाएंगी। यह क्रिया अपरिवर्तनीय है।';
  }

  @override
  String get aboutTabularium => 'Tabularium के बारे में';

  @override
  String get ok => 'ठीक है';

  @override
  String get toggleViewMode => 'दृश्य बदलें';

  @override
  String get theme => 'थीम';

  @override
  String get help => 'मदद';

  @override
  String get about => 'के बारे में';

  @override
  String get resetSettings => 'रीसेट करें';

  @override
  String get fontSize => 'फ़ॉन्ट आकार';

  @override
  String get bookScaleGrid => 'स्केल (ग्रिड)';

  @override
  String get bookScaleCabinet => 'स्केल (कैबिनेट)';

  @override
  String get add => 'जोड़ें';

  @override
  String get selectShelf => 'शेल्फ़ चुनें';

  @override
  String get sortDateAddedNewest => 'जोड़ा गया ↓';

  @override
  String get sortDateAddedOldest => 'जोड़ा गया ↑';

  @override
  String get sortDateOpenedNewest => 'खोला गया ↓';

  @override
  String get sortDateOpenedOldest => 'खोला गया ↑';

  @override
  String get sortTitleAZ => 'शीर्षक A-Z';

  @override
  String get sortTitleZA => 'शीर्षक Z-A';
}
