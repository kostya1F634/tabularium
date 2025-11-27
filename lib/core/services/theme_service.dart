import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'app_theme';
  final SharedPreferences _prefs;
  AppThemeMode _currentTheme;

  ThemeService(this._prefs)
      : _currentTheme = AppThemeMode.values.firstWhere(
          (theme) => theme.name == _prefs.getString(_themeKey),
          orElse: () => AppThemeMode.light,
        );

  AppThemeMode get currentTheme => _currentTheme;
  ThemeData get themeData => AppTheme.getTheme(_currentTheme);

  Future<void> setTheme(AppThemeMode theme) async {
    if (_currentTheme == theme) return;

    _currentTheme = theme;
    await _prefs.setString(_themeKey, theme.name);
    notifyListeners();
  }

  String getThemeName(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.githubLight:
        return 'GitHub Light';
      case AppThemeMode.githubDark:
        return 'GitHub Dark';
      case AppThemeMode.tokyoNight:
        return 'Tokyo Night';
      case AppThemeMode.highContrast:
        return 'High Contrast';
    }
  }
}
