import 'package:flutter/material.dart';
import 'app_settings.dart';
import '../theme/app_theme.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'app_theme';
  final AppSettings _prefs;
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
      // Default
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';

      // Atom One
      case AppThemeMode.atomOneDark:
        return 'Atom One Dark';
      case AppThemeMode.atomOneLight:
        return 'Atom One Light';

      // Ayu
      case AppThemeMode.ayuDark:
        return 'Ayu Dark';
      case AppThemeMode.ayuLight:
        return 'Ayu Light';

      // Catppuccin
      case AppThemeMode.catppuccinLatte:
        return 'Catppuccin Latte';
      case AppThemeMode.catppuccinMocha:
        return 'Catppuccin Mocha';

      // Dracula
      case AppThemeMode.dracula:
        return 'Dracula';

      // Everforest
      case AppThemeMode.everforestDark:
        return 'Everforest Dark';
      case AppThemeMode.everforestLight:
        return 'Everforest Light';

      // GitHub
      case AppThemeMode.githubDark:
        return 'GitHub Dark';
      case AppThemeMode.githubDimmed:
        return 'GitHub Dimmed';
      case AppThemeMode.githubLight:
        return 'GitHub Light';

      // Gruber
      case AppThemeMode.gruber:
        return 'Gruber Darker';

      // Gruvbox
      case AppThemeMode.gruvboxDark:
        return 'Gruvbox Dark';
      case AppThemeMode.gruvboxLight:
        return 'Gruvbox Light';

      // Material
      case AppThemeMode.materialDark:
        return 'Material Dark';
      case AppThemeMode.materialLight:
        return 'Material Light';

      // Monokai
      case AppThemeMode.monokai:
        return 'Monokai';

      // Nord
      case AppThemeMode.nordDark:
        return 'Nord Dark';
      case AppThemeMode.nordLight:
        return 'Nord Light';

      // Paper
      case AppThemeMode.paper:
        return 'Paper';

      // Realistic
      case AppThemeMode.realistic:
        return 'Realistic';

      // Rosé Pine
      case AppThemeMode.rosePineDawn:
        return 'Rosé Pine Dawn';
      case AppThemeMode.rosePineMoon:
        return 'Rosé Pine Moon';

      // Solarized
      case AppThemeMode.solarizedDark:
        return 'Solarized Dark';
      case AppThemeMode.solarizedLight:
        return 'Solarized Light';

      // Tokyo Night
      case AppThemeMode.tokyoNight:
        return 'Tokyo Night';

      // Special
      case AppThemeMode.highContrast:
        return 'High Contrast';
    }
  }

  /// Get themes grouped by family and sorted
  /// Returns a list of all themes in their enum order (already grouped)
  List<AppThemeMode> getGroupedThemes() {
    // The enum is already properly ordered by groups
    return AppThemeMode.values;
  }
}
