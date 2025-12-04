import 'package:flutter/material.dart';

enum AppThemeMode {
  // Default themes
  light,
  dark,

  // Atom One
  atomOneDark,
  atomOneLight,

  // Ayu
  ayuDark,
  ayuLight,

  // Catppuccin
  catppuccinLatte,
  catppuccinMocha,

  // Dracula
  dracula,

  // Everforest
  everforestDark,
  everforestLight,

  // GitHub
  githubDark,
  githubDimmed,
  githubLight,

  // Gruber
  gruber,

  // Gruvbox
  gruvboxDark,
  gruvboxLight,

  // Material
  materialDark,
  materialLight,

  // Monokai
  monokai,

  // Nord
  nordDark,
  nordLight,

  // Paper
  paper,

  // Realistic
  realistic,

  // Rosé Pine
  rosePineDawn,
  rosePineMoon,

  // Solarized
  solarizedDark,
  solarizedLight,

  // Tokyo Night
  tokyoNight,

  // Special
  highContrast,
}

class AppTheme {
  static const Color primaryColor = Color(0xFF6B4EFF);

  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      // Default
      case AppThemeMode.light:
        return _lightTheme();
      case AppThemeMode.dark:
        return _darkTheme();

      // Atom One
      case AppThemeMode.atomOneDark:
        return _atomOneDarkTheme();
      case AppThemeMode.atomOneLight:
        return _atomOneLightTheme();

      // Ayu
      case AppThemeMode.ayuDark:
        return _ayuDarkTheme();
      case AppThemeMode.ayuLight:
        return _ayuLightTheme();

      // Catppuccin
      case AppThemeMode.catppuccinLatte:
        return _catppuccinLatteTheme();
      case AppThemeMode.catppuccinMocha:
        return _catppuccinMochaTheme();

      // Dracula
      case AppThemeMode.dracula:
        return _draculaTheme();

      // Everforest
      case AppThemeMode.everforestDark:
        return _everforestDarkTheme();
      case AppThemeMode.everforestLight:
        return _everforestLightTheme();

      // GitHub
      case AppThemeMode.githubDark:
        return _githubDarkTheme();
      case AppThemeMode.githubDimmed:
        return _githubDimmedTheme();
      case AppThemeMode.githubLight:
        return _githubLightTheme();

      // Gruber
      case AppThemeMode.gruber:
        return _gruberTheme();

      // Gruvbox
      case AppThemeMode.gruvboxDark:
        return _gruvboxDarkTheme();
      case AppThemeMode.gruvboxLight:
        return _gruvboxLightTheme();

      // Material
      case AppThemeMode.materialDark:
        return _materialDarkTheme();
      case AppThemeMode.materialLight:
        return _materialLightTheme();

      // Monokai
      case AppThemeMode.monokai:
        return _monokaiTheme();

      // Nord
      case AppThemeMode.nordDark:
        return _nordDarkTheme();
      case AppThemeMode.nordLight:
        return _nordLightTheme();

      // Paper
      case AppThemeMode.paper:
        return _paperTheme();

      // Realistic
      case AppThemeMode.realistic:
        return _realisticTheme();

      // Rosé Pine
      case AppThemeMode.rosePineDawn:
        return _rosePineDawnTheme();
      case AppThemeMode.rosePineMoon:
        return _rosePineMoonTheme();

      // Solarized
      case AppThemeMode.solarizedDark:
        return _solarizedDarkTheme();
      case AppThemeMode.solarizedLight:
        return _solarizedLightTheme();

      // Tokyo Night
      case AppThemeMode.tokyoNight:
        return _tokyoNightTheme();

      // Special
      case AppThemeMode.highContrast:
        return _highContrastTheme();
    }
  }

  // ==================== Light Themes ====================

  static ThemeData _lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _githubLightTheme() {
    const background = Color(0xFFFFFFFF);
    const surface = Color(0xFFF6F8FA);
    const primary = Color(0xFF08872B); // GitHub Green 4
    const secondary = Color(0xFF6E7781);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1F2328),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFD0D7DE), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  static ThemeData _solarizedLightTheme() {
    const background = Color(0xFFFDF6E3);
    const surface = Color(0xFFEEE8D5);
    const primary = Color(0xFF268BD2);
    const secondary = Color(0xFF2AA198);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF657B83),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _nordLightTheme() {
    const background = Color(0xFFECEFF4);
    const surface = Color(0xFFE5E9F0);
    const primary = Color(0xFF5E81AC);
    const secondary = Color(0xFF88C0D0);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Color(0xFF2E3440),
        onSurface: Color(0xFF2E3440),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _catppuccinLatteTheme() {
    const background = Color(0xFFEFF1F5);
    const surface = Color(0xFFE6E9EF);
    const primary = Color(0xFF1E66F5);
    const secondary = Color(0xFF8839EF);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF4C4F69),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _ayuLightTheme() {
    const background = Color(0xFFFAFAFA);
    const surface = Color(0xFFF3F4F5);
    const primary = Color(0xFF399EE6);
    const secondary = Color(0xFFF2AE49);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Color(0xFF575F66),
        onSurface: Color(0xFF575F66),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _atomOneLightTheme() {
    const background = Color(0xFFFAFAFA);
    const surface = Color(0xFFF0F0F0);
    const primary = Color(0xFF4078F2);
    const secondary = Color(0xFF50A14F);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF383A42),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  static ThemeData _atomOneDarkTheme() {
    const background = Color(0xFF282C34);
    const surface = Color(0xFF21252B);
    const primary = Color(0xFF61AFEF);
    const secondary = Color(0xFF98C379);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF282C34),
        onSecondary: Color(0xFF282C34),
        onSurface: Color(0xFFABB2BF),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF282C34),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  static ThemeData _ayuDarkTheme() {
    const background = Color(0xFF0A0E14);
    const surface = Color(0xFF0D1016);
    const primary = Color(0xFF59C2FF);
    const secondary = Color(0xFFFFB454);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF0A0E14),
        onSecondary: Color(0xFF0A0E14),
        onSurface: Color(0xFFB3B1AD),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF0A0E14),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  static ThemeData _paperTheme() {
    const background = Color(0xFFF5F2E8);
    const surface = Color(0xFFEEE9DC);
    const primary = Color(0xFF8B7355);
    const secondary = Color(0xFF6B5D4F);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF3E3632),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Color(0xFFD9D3C6), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }

  // ==================== Dark Themes ====================

  static ThemeData _darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _githubDarkTheme() {
    const background = Color(0xFF0D1117);
    const surface = Color(0xFF161B22);
    const primary = Color(0xFF5FED83); // GitHub Green 3
    const secondary = Color(0xFF8B949E);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF0D1117),
        onSecondary: Colors.white,
        onSurface: Color(0xFFC9D1D9),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF30363D), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF0D1117),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  static ThemeData _tokyoNightTheme() {
    const background = Color(0xFF1A1B26);
    const surface = Color(0xFF24283B);
    const primary = Color(0xFF7AA2F7);
    const secondary = Color(0xFFBB9AF7);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF1A1B26),
        onSecondary: Color(0xFF1A1B26),
        onSurface: Color(0xFFC0CAF5),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF1A1B26),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _draculaTheme() {
    const background = Color(0xFF282A36);
    const surface = Color(0xFF44475A);
    const primary = Color(0xFFBD93F9);
    const secondary = Color(0xFFFF79C6);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF282A36),
        onSecondary: Color(0xFF282A36),
        onSurface: Color(0xFFF8F8F2),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF282A36),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _monokaiTheme() {
    const background = Color(0xFF272822);
    const surface = Color(0xFF3E3D32);
    const primary = Color(0xFF66D9EF);
    const secondary = Color(0xFFA6E22E);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF272822),
        onSecondary: Color(0xFF272822),
        onSurface: Color(0xFFF8F8F2),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF272822),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _nordDarkTheme() {
    const background = Color(0xFF2E3440);
    const surface = Color(0xFF3B4252);
    const primary = Color(0xFF88C0D0);
    const secondary = Color(0xFF81A1C1);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF2E3440),
        onSecondary: Color(0xFF2E3440),
        onSurface: Color(0xFFECEFF4),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF2E3440),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _catppuccinMochaTheme() {
    const background = Color(0xFF1E1E2E);
    const surface = Color(0xFF313244);
    const primary = Color(0xFF89B4FA);
    const secondary = Color(0xFFCBA6F7);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF1E1E2E),
        onSecondary: Color(0xFF1E1E2E),
        onSurface: Color(0xFFCDD6F4),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF1E1E2E),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _gruvboxDarkTheme() {
    const background = Color(0xFF282828);
    const surface = Color(0xFF3C3836);
    const primary = Color(0xFFFE8019);
    const secondary = Color(0xFABD2F);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF282828),
        onSecondary: Color(0xFF282828),
        onSurface: Color(0xFFEBDBB2),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF282828),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _realisticTheme() {
    const background = Color(0xFF1C1C1C);
    const surface = Color(0xFF2A2A2A);
    const primary = Color(0xFF909090);
    const secondary = Color(0xFF707070);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Color(0xFFE0E0E0),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 4,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black,
          elevation: 6,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _gruberTheme() {
    const background = Color(0xFF181818);
    const surface = Color(0xFF282828);
    const primary = Color(0xFFFFDD33);
    const secondary = Color(0xFF95A99F);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF181818),
        onSecondary: Color(0xFF181818),
        onSurface: Color(0xFFF4F4FF),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF181818),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }

  static ThemeData _everforestLightTheme() {
    const background = Color(0xFFF3F4F1);
    const surface = Color(0xFFE6E8E4);
    const primary = Color(0xFF8DA101);
    const secondary = Color(0xFF7FBBB3);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF5C6A72),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _everforestDarkTheme() {
    const background = Color(0xFF2D353B);
    const surface = Color(0xFF343F44);
    const primary = Color(0xFFA7C080);
    const secondary = Color(0xFF7FBBB3);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF2D353B),
        onSecondary: Color(0xFF2D353B),
        onSurface: Color(0xFFD3C6AA),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF2D353B),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _githubDimmedTheme() {
    const background = Color(0xFF22272E);
    const surface = Color(0xFF2D333B);
    const primary = Color(0xFF5FED83); // GitHub Green 3
    const secondary = Color(0xFF768390);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF22272E),
        onSecondary: Colors.white,
        onSurface: Color(0xFFADBAC7),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF444C56), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  static ThemeData _gruvboxLightTheme() {
    const background = Color(0xFFFBF1C7);
    const surface = Color(0xFFEBDBB2);
    const primary = Color(0xFF689D6A);
    const secondary = Color(0xFFD79921);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF3C3836),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _materialLightTheme() {
    const background = Color(0xFFFAFAFA);
    const surface = Color(0xFFFFFFFF);
    const primary = Color(0xFF2196F3);
    const secondary = Color(0xFF03DAC6);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFF000000),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 4,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 6,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _materialDarkTheme() {
    const background = Color(0xFF121212);
    const surface = Color(0xFF1E1E1E);
    const primary = Color(0xFFBB86FC);
    const secondary = Color(0xFF03DAC6);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 4,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black,
          elevation: 6,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData _rosePineDawnTheme() {
    const background = Color(0xFFFAF4ED);
    const surface = Color(0xFFFFFAF3);
    const primary = Color(0xFFD7827E);
    const secondary = Color(0xFF907AA9);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF575279),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _rosePineMoonTheme() {
    const background = Color(0xFF232136);
    const surface = Color(0xFF2A273F);
    const primary = Color(0xFFEA9A97);
    const secondary = Color(0xFFC4A7E7);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF232136),
        onSecondary: Color(0xFF232136),
        onSurface: Color(0xFFE0DEF4),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF232136),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _solarizedDarkTheme() {
    const background = Color(0xFF002B36);
    const surface = Color(0xFF073642);
    const primary = Color(0xFF268BD2);
    const secondary = Color(0xFF2AA198);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF002B36),
        onSecondary: Color(0xFF002B36),
        onSurface: Color(0xFF839496),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 2,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  // ==================== Special Themes ====================

  static ThemeData _highContrastTheme() {
    const background = Color(0xFF000000);
    const surface = Color(0xFF000000);
    const primary = Color(0xFF00FF00);
    const secondary = Color(0xFFFFFF00);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF000000),
        onSecondary: Color(0xFF000000),
        onSurface: Color(0xFFFFFFFF),
        error: Color(0xFFFF0000),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }
}
