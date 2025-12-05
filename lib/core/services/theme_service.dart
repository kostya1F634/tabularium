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
      // Default (always first)
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';

      // All other themes in alphabetical order
      case AppThemeMode.akane:
        return 'Akane';
      case AppThemeMode.atomOneDark:
        return 'Atom One Dark';
      case AppThemeMode.atomOneLight:
        return 'Atom One Light';
      case AppThemeMode.ayuDark:
        return 'Ayu Dark';
      case AppThemeMode.ayuLight:
        return 'Ayu Light';
      case AppThemeMode.aura:
        return 'Aura';
      case AppThemeMode.azureGlow:
        return 'Azure Glow';
      case AppThemeMode.batou:
        return 'Batou';
      case AppThemeMode.catppuccinLatte:
        return 'Catppuccin Latte';
      case AppThemeMode.catppuccinMocha:
        return 'Catppuccin Mocha';
      case AppThemeMode.dracula:
        return 'Dracula';
      case AppThemeMode.everforestDark:
        return 'Everforest Dark';
      case AppThemeMode.everforestLight:
        return 'Everforest Light';
      case AppThemeMode.flexokiDark:
        return 'Flexoki Dark';
      case AppThemeMode.flexokiLight:
        return 'Flexoki Light';
      case AppThemeMode.felix:
        return 'Felix';
      case AppThemeMode.futurism:
        return 'Futurism';
      case AppThemeMode.githubDark:
        return 'GitHub Dark';
      case AppThemeMode.githubDimmed:
        return 'GitHub Dimmed';
      case AppThemeMode.githubLight:
        return 'GitHub Light';
      case AppThemeMode.greenGarden:
        return 'Green Garden';
      case AppThemeMode.gruber:
        return 'Gruber Darker';
      case AppThemeMode.grudark:
        return 'Grudark';
      case AppThemeMode.gruvboxDark:
        return 'Gruvbox Dark';
      case AppThemeMode.gruvboxLight:
        return 'Gruvbox Light';
      case AppThemeMode.highContrast:
        return 'High Contrast';
      case AppThemeMode.kanagawa:
        return 'Kanagawa';
      case AppThemeMode.materialDark:
        return 'Material Dark';
      case AppThemeMode.materialLight:
        return 'Material Light';
      case AppThemeMode.mars:
        return 'Mars';
      case AppThemeMode.matteBlack:
        return 'Matte Black';
      case AppThemeMode.milkyMatcha:
        return 'Milky Matcha';
      case AppThemeMode.monokai:
        return 'Monokai';
      case AppThemeMode.monochrome:
        return 'Monochrome';
      case AppThemeMode.nordDark:
        return 'Nord Dark';
      case AppThemeMode.nordLight:
        return 'Nord Light';
      case AppThemeMode.osakaJade:
        return 'Osaka Jade';
      case AppThemeMode.paper:
        return 'Paper';
      case AppThemeMode.pulsar:
        return 'Pulsar';
      case AppThemeMode.realistic:
        return 'Realistic';
      case AppThemeMode.ristretto:
        return 'Ristretto';
      case AppThemeMode.retroPC:
        return 'RetroPC';
      case AppThemeMode.rosePineDawn:
        return 'Rosé Pine Dawn';
      case AppThemeMode.rosePineMoon:
        return 'Rosé Pine Moon';
      case AppThemeMode.snow:
        return 'Snow';
      case AppThemeMode.solarizedDark:
        return 'Solarized Dark';
      case AppThemeMode.solarizedLight:
        return 'Solarized Light';
      case AppThemeMode.solarizedOsaka:
        return 'Solarized Osaka';
      case AppThemeMode.spaceMonkey:
        return 'Space Monkey';
      case AppThemeMode.tokyoNight:
        return 'Tokyo Night';
    }
  }

  /// Get themes grouped by family and sorted
  /// Returns a list of all themes in their enum order (already grouped)
  List<AppThemeMode> getGroupedThemes() {
    // The enum is already properly ordered by groups
    return AppThemeMode.values;
  }
}
