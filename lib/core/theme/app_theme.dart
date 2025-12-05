import 'package:flutter/material.dart';

enum AppThemeMode {
  // Default themes (always first)
  light,
  dark,

  // All other themes in alphabetical order
  akane,
  atomOneDark,
  atomOneLight,
  aura,
  ayuDark,
  ayuLight,
  azureGlow,
  batou,
  catppuccinLatte,
  catppuccinMocha,
  dracula,
  everforestDark,
  everforestLight,
  felix,
  flexokiDark,
  flexokiLight,
  futurism,
  githubDark,
  githubDimmed,
  githubLight,
  greenGarden,
  gruber,
  grudark,
  gruvboxDark,
  gruvboxLight,
  highContrast,
  kanagawa,
  mars,
  materialDark,
  materialLight,
  matteBlack,
  milkyMatcha,
  monokai,
  monochrome,
  nordDark,
  nordLight,
  osakaJade,
  paper,
  pulsar,
  realistic,
  retroPC,
  ristretto,
  rosePineDawn,
  rosePineMoon,
  snow,
  solarizedDark,
  solarizedLight,
  solarizedOsaka,
  spaceMonkey,
  tokyoNight,
}

class AppTheme {
  static const Color primaryColor = Color(0xFF6B4EFF);

  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      // Default (always first)
      case AppThemeMode.light:
        return _lightTheme();
      case AppThemeMode.dark:
        return _darkTheme();

      // All other themes in alphabetical order
      case AppThemeMode.akane:
        return _akaneTheme();
      case AppThemeMode.atomOneDark:
        return _atomOneDarkTheme();
      case AppThemeMode.atomOneLight:
        return _atomOneLightTheme();
      case AppThemeMode.ayuDark:
        return _ayuDarkTheme();
      case AppThemeMode.ayuLight:
        return _ayuLightTheme();
      case AppThemeMode.aura:
        return _auraTheme();
      case AppThemeMode.azureGlow:
        return _azureGlowTheme();
      case AppThemeMode.batou:
        return _batouTheme();
      case AppThemeMode.catppuccinLatte:
        return _catppuccinLatteTheme();
      case AppThemeMode.catppuccinMocha:
        return _catppuccinMochaTheme();
      case AppThemeMode.dracula:
        return _draculaTheme();
      case AppThemeMode.everforestDark:
        return _everforestDarkTheme();
      case AppThemeMode.everforestLight:
        return _everforestLightTheme();
      case AppThemeMode.flexokiDark:
        return _flexokiDarkTheme();
      case AppThemeMode.flexokiLight:
        return _flexokiLightTheme();
      case AppThemeMode.felix:
        return _felixTheme();
      case AppThemeMode.futurism:
        return _futurismTheme();
      case AppThemeMode.githubDark:
        return _githubDarkTheme();
      case AppThemeMode.githubDimmed:
        return _githubDimmedTheme();
      case AppThemeMode.githubLight:
        return _githubLightTheme();
      case AppThemeMode.greenGarden:
        return _greenGardenTheme();
      case AppThemeMode.gruber:
        return _gruberTheme();
      case AppThemeMode.grudark:
        return _grudarkTheme();
      case AppThemeMode.gruvboxDark:
        return _gruvboxDarkTheme();
      case AppThemeMode.gruvboxLight:
        return _gruvboxLightTheme();
      case AppThemeMode.highContrast:
        return _highContrastTheme();
      case AppThemeMode.kanagawa:
        return _kanagawaTheme();
      case AppThemeMode.materialDark:
        return _materialDarkTheme();
      case AppThemeMode.materialLight:
        return _materialLightTheme();
      case AppThemeMode.mars:
        return _marsTheme();
      case AppThemeMode.matteBlack:
        return _matteBlackTheme();
      case AppThemeMode.milkyMatcha:
        return _milkyMatchaTheme();
      case AppThemeMode.monokai:
        return _monokaiTheme();
      case AppThemeMode.monochrome:
        return _monochromeTheme();
      case AppThemeMode.nordDark:
        return _nordDarkTheme();
      case AppThemeMode.nordLight:
        return _nordLightTheme();
      case AppThemeMode.osakaJade:
        return _osakaJadeTheme();
      case AppThemeMode.paper:
        return _paperTheme();
      case AppThemeMode.pulsar:
        return _pulsarTheme();
      case AppThemeMode.realistic:
        return _realisticTheme();
      case AppThemeMode.ristretto:
        return _ristrettoTheme();
      case AppThemeMode.retroPC:
        return _retroPCTheme();
      case AppThemeMode.rosePineDawn:
        return _rosePineDawnTheme();
      case AppThemeMode.rosePineMoon:
        return _rosePineMoonTheme();
      case AppThemeMode.snow:
        return _snowTheme();
      case AppThemeMode.solarizedDark:
        return _solarizedDarkTheme();
      case AppThemeMode.solarizedLight:
        return _solarizedLightTheme();
      case AppThemeMode.solarizedOsaka:
        return _solarizedOsakaTheme();
      case AppThemeMode.spaceMonkey:
        return _spaceMonkeyTheme();
      case AppThemeMode.tokyoNight:
        return _tokyoNightTheme();
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
    const secondary = Color(0xFFFABD2F);

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

  // ==================== Omarchy Themes ====================

  static ThemeData _matteBlackTheme() {
    const background = Color(0xFF121212);
    const surface = Color(0xFF1E1E1E);
    const primary = Color(0xFFD35F5F);
    const secondary = Color(0xFFFFC107);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF121212),
        onSecondary: Color(0xFF121212),
        onSurface: Color(0xFFBEBEBE),
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
          foregroundColor: const Color(0xFF121212),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _kanagawaTheme() {
    const background = Color(0xFF1F1F28);
    const surface = Color(0xFF2A2A37);
    const primary = Color(0xFF7E9CD8);
    const secondary = Color(0xFF98BB6C);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF1F1F28),
        onSecondary: Color(0xFF1F1F28),
        onSurface: Color(0xFFDCD7BA),
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
          foregroundColor: const Color(0xFF1F1F28),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _ristrettoTheme() {
    const background = Color(0xFF2C2525);
    const surface = Color(0xFF403E41);
    const primary = Color(0xFFF9CC6C);
    const secondary = Color(0xFFA8A9EB);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF2C2525),
        onSecondary: Color(0xFF2C2525),
        onSurface: Color(0xFFE6D9DB),
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
          foregroundColor: const Color(0xFF2C2525),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _greenGardenTheme() {
    const background = Color(0xFF1D271F);
    const surface = Color(0xFF293427);
    const primary = Color(0xFF7E9C58);
    const secondary = Color(0xFF89D9D0);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF1D271F),
        onSecondary: Color(0xFF1D271F),
        onSurface: Color(0xFFE4D8B4),
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
          foregroundColor: const Color(0xFF1D271F),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _pulsarTheme() {
    const background = Color(0xFF0A0314);
    const surface = Color(0xFF1A0D28);
    const primary = Color(0xFFB82AFF);
    const secondary = Color(0xFF3DF2F2);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF0A0314),
        onSecondary: Color(0xFF0A0314),
        onSurface: Color(0xFFE0E6FF),
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
          foregroundColor: const Color(0xFF0A0314),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  static ThemeData _snowTheme() {
    const background = Color(0xFFFFFFFF);
    const surface = Color(0xFFF0F0F0);
    const primary = Color(0xFF606060);
    const secondary = Color(0xFF909090);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF0A0A0A),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFD0D0D0), width: 1),
        ),
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

  static ThemeData _akaneTheme() {
    const background = Color(0xFF0E1E36);
    const surface = Color(0xFF574F72);
    const primary = Color(0xFF9279AA);
    const secondary = Color(0xFFFA7E75);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF0E1E36),
        onSecondary: Color(0xFF0E1E36),
        onSurface: Color(0xFFF4B999),
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
          foregroundColor: const Color(0xFF0E1E36),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _batouTheme() {
    const background = Color(0xFF121212);
    const surface = Color(0xFF1E1E1E);
    const primary = Color(0xFFE19E74);
    const secondary = Color(0xFFC2BBB0);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF121212),
        onSecondary: Color(0xFF121212),
        onSurface: Color(0xFFA4A4A4),
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
          foregroundColor: const Color(0xFF121212),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _grudarkTheme() {
    const background = Color(0xFF1D201E);
    const surface = Color(0xFF2A2D2B);
    const primary = Color(0xFF89AE92);
    const secondary = Color(0xFFDACF6D);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF1D201E),
        onSecondary: Color(0xFF1D201E),
        onSurface: Color(0xFFFDFDFB),
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
          foregroundColor: const Color(0xFF1D201E),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _osakaJadeTheme() {
    const background = Color(0xFF111C18);
    const surface = Color(0xFF23372B);
    const primary = Color(0xFF549E6A);
    const secondary = Color(0xFF2DD5B7);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF111C18),
        onSecondary: Color(0xFF111C18),
        onSurface: Color(0xFFC1C497),
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
          foregroundColor: const Color(0xFF111C18),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _flexokiDarkTheme() {
    const background = Color(0xFF100F0F);
    const surface = Color(0xFF282726);
    const primary = Color(0xFFAF3029);
    const secondary = Color(0xFF879A39);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF100F0F),
        onSecondary: Color(0xFF100F0F),
        onSurface: Color(0xFFCECDC3),
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
          foregroundColor: const Color(0xFFFFFCF0),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _flexokiLightTheme() {
    const background = Color(0xFFFFFCF0);
    const surface = Color(0xFFF2F0E5);
    const primary = Color(0xFFD14D41);
    const secondary = Color(0xFF879A39);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF100F0F),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFCECDC3), width: 1),
        ),
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

  static ThemeData _auraTheme() {
    const background = Color(0xFF282A36);
    const surface = Color(0xFF3A3C4E);
    const primary = Color(0xFFFF79C6);
    const secondary = Color(0xFF8BE9FD);

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: const Color(0xFF282A36),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _azureGlowTheme() {
    const background = Color(0xFF0A0F1A);
    const surface = Color(0xFF151B2E);
    const primary = Color(0xFF00CCFF);
    const secondary = Color(0xFFA8DFFF);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Color(0xFF0A0F1A),
        onSecondary: Color(0xFF0A0F1A),
        onSurface: Color(0xFFE0F4FF),
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
          foregroundColor: const Color(0xFF0A0F1A),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _felixTheme() {
    const background = Color(0xFF000000);
    const surface = Color(0xFF1A1A1A);
    const primary = Color(0xFFE24254);
    const secondary = Color(0xFFF9C859);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFFE6D9DB),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _futurismTheme() {
    const background = Color(0xFF0A1428);
    const surface = Color(0xFF152238);
    const primary = Color(0xFFFF40A3);
    const secondary = Color(0xFF00BFFF);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFFE0E9FF),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _marsTheme() {
    const background = Color(0xFF000000);
    const surface = Color(0xFF2A1810);
    const primary = Color(0xFFE07B5F);
    const secondary = Color(0xFFD9AFA7);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Color(0xFFD9AFA7),
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
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _milkyMatchaTheme() {
    const background = Color(0xFFF4F1E8);
    const surface = Color(0xFFE8E5DC);
    const primary = Color(0xFF7A9461);
    const secondary = Color(0xFF5C6A53);

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF3A3F35),
      ),
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      cardTheme: CardThemeData(
        elevation: 1,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFD4D1C8), width: 1),
        ),
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

  static ThemeData _monochromeTheme() {
    const background = Color(0xFF282828);
    const surface = Color(0xFF3C3C3C);
    const primary = Color(0xFFB8B8B8);
    const secondary = Color(0xFF8C8C8C);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Color(0xFFE4E4E4),
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
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _retroPCTheme() {
    const background = Color(0xFF0A0A08);
    const surface = Color(0xFF1A1A15);
    const primary = Color(0xFFFFB000);
    const secondary = Color(0xFFD49000);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Color(0xFFFFB000),
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
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _solarizedOsakaTheme() {
    const background = Color(0xFF001C2B);
    const surface = Color(0xFF073642);
    const primary = Color(0xFF268BD2);
    const secondary = Color(0xFF2AA198);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData _spaceMonkeyTheme() {
    const background = Color(0xFF1C0E00);
    const surface = Color(0xFF2D1E10);
    const primary = Color(0xFFE7AA5A);
    const secondary = Color(0xFFD4915A);

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Color(0xFFE7AA5A),
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
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
