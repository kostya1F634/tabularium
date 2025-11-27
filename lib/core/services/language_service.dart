import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing application language
class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'app_language';
  static const Locale _defaultLocale = Locale('en');

  Locale _currentLocale = _defaultLocale;
  final SharedPreferences _prefs;

  LanguageService(this._prefs) {
    _loadLanguage();
  }

  /// Get current locale
  Locale get currentLocale => _currentLocale;

  /// Load saved language from preferences
  Future<void> _loadLanguage() async {
    final languageCode = _prefs.getString(_languageKey);
    if (languageCode != null) {
      _currentLocale = Locale(languageCode);
      notifyListeners();
    }
  }

  /// Change application language
  Future<void> changeLanguage(Locale locale) async {
    if (_currentLocale == locale) return;

    _currentLocale = locale;
    await _prefs.setString(_languageKey, locale.languageCode);
    notifyListeners();
  }

  /// Get list of supported locales
  static List<Locale> get supportedLocales => const [
        Locale('en'), // English
        Locale('ru'), // Russian
      ];

  /// Check if locale is supported
  static bool isSupported(Locale locale) {
    return supportedLocales.any((l) => l.languageCode == locale.languageCode);
  }
}
