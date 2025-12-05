import 'package:flutter/material.dart';
import 'app_settings.dart';

/// Service for managing application language
class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'app_language';
  static const Locale _defaultLocale = Locale('en');

  Locale _currentLocale = _defaultLocale;
  final AppSettings _prefs;

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
    Locale('ru'), // Русский
    Locale('zh'), // 中文
    Locale('de'), // Deutsch
    Locale('fr'), // Français
    Locale('es'), // Español
    Locale('it'), // Italiano
    Locale('pt'), // Português
    Locale('ja'), // 日本語
    Locale('ko'), // 한국어
    Locale('hi'), // हिन्दी
    Locale('ar'), // العربية
    Locale('tr'), // Türkçe
    Locale('nl'), // Nederlands
    Locale('da'), // Dansk
    Locale('pl'), // Polski
  ];

  /// Check if locale is supported
  static bool isSupported(Locale locale) {
    return supportedLocales.any((l) => l.languageCode == locale.languageCode);
  }
}
