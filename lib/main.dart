import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/routes/app_routes.dart';
import 'core/services/app_settings.dart';
import 'core/services/language_provider.dart';
import 'core/services/language_service.dart';
import 'core/services/theme_service.dart';
import 'core/services/theme_provider.dart';
import 'core/services/ui_settings_service.dart';
import 'core/services/ui_settings_provider.dart';
import 'core/services/window_settings_service.dart';
import 'core/services/window_settings_provider.dart';
import 'package:tabularium/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await AppSettings.getInstance();

  print('Settings file location: ${prefs.getSettingsFilePath()}');

  final languageService = LanguageService(prefs);
  final themeService = ThemeService(prefs);
  final uiSettingsService = UISettingsService(prefs);
  final windowSettingsService = WindowSettingsService(prefs);

  // Initialize window settings
  await windowSettingsService.initializeWindow();

  // Check for last opened directory
  final lastOpenedDir = prefs.getString('last_opened_directory');
  String? initialRoute = AppRoutes.welcome;
  String? initialDirectoryPath;

  if (lastOpenedDir != null) {
    // Verify directory still exists
    final directory = Directory(lastOpenedDir);
    if (await directory.exists()) {
      initialRoute = AppRoutes.main;
      initialDirectoryPath = lastOpenedDir;
    }
  }

  runApp(
    TabulariumApp(
      prefs: prefs,
      languageService: languageService,
      themeService: themeService,
      uiSettingsService: uiSettingsService,
      windowSettingsService: windowSettingsService,
      initialRoute: initialRoute,
      initialDirectoryPath: initialDirectoryPath,
    ),
  );
}

class TabulariumApp extends StatefulWidget {
  final AppSettings prefs;
  final LanguageService languageService;
  final ThemeService themeService;
  final UISettingsService uiSettingsService;
  final WindowSettingsService windowSettingsService;
  final String initialRoute;
  final String? initialDirectoryPath;

  const TabulariumApp({
    super.key,
    required this.prefs,
    required this.languageService,
    required this.themeService,
    required this.uiSettingsService,
    required this.windowSettingsService,
    required this.initialRoute,
    this.initialDirectoryPath,
  });

  @override
  State<TabulariumApp> createState() => _TabulariumAppState();
}

class _TabulariumAppState extends State<TabulariumApp> {
  bool _isFirstRoute = true;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeService: widget.themeService,
      child: LanguageProvider(
        languageService: widget.languageService,
        child: UISettingsProvider(
          uiSettingsService: widget.uiSettingsService,
          child: WindowSettingsProvider(
            windowSettingsService: widget.windowSettingsService,
            child: ListenableBuilder(
              listenable: Listenable.merge([
                widget.languageService,
                widget.themeService,
                widget.uiSettingsService,
              ]),
              builder: (context, child) {
                final baseTheme = widget.themeService.themeData;
                final fontSize = widget.uiSettingsService.fontSize;

                return MaterialApp(
                  title: 'Tabularium',
                  debugShowCheckedModeBanner: false,
                  theme: baseTheme.copyWith(
                    textTheme: baseTheme.textTheme.copyWith(
                      displayLarge: baseTheme.textTheme.displayLarge?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.displayLarge?.fontSize ?? 57) *
                            fontSize,
                      ),
                      displayMedium: baseTheme.textTheme.displayMedium
                          ?.copyWith(
                            fontSize:
                                (baseTheme.textTheme.displayMedium?.fontSize ??
                                    45) *
                                fontSize,
                          ),
                      displaySmall: baseTheme.textTheme.displaySmall?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.displaySmall?.fontSize ?? 36) *
                            fontSize,
                      ),
                      headlineLarge: baseTheme.textTheme.headlineLarge
                          ?.copyWith(
                            fontSize:
                                (baseTheme.textTheme.headlineLarge?.fontSize ??
                                    32) *
                                fontSize,
                          ),
                      headlineMedium: baseTheme.textTheme.headlineMedium
                          ?.copyWith(
                            fontSize:
                                (baseTheme.textTheme.headlineMedium?.fontSize ??
                                    28) *
                                fontSize,
                          ),
                      headlineSmall: baseTheme.textTheme.headlineSmall
                          ?.copyWith(
                            fontSize:
                                (baseTheme.textTheme.headlineSmall?.fontSize ??
                                    24) *
                                fontSize,
                          ),
                      titleLarge: baseTheme.textTheme.titleLarge?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.titleLarge?.fontSize ?? 22) *
                            fontSize,
                      ),
                      titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.titleMedium?.fontSize ?? 16) *
                            fontSize,
                      ),
                      titleSmall: baseTheme.textTheme.titleSmall?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.titleSmall?.fontSize ?? 14) *
                            fontSize,
                      ),
                      bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.bodyLarge?.fontSize ?? 16) *
                            fontSize,
                      ),
                      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.bodyMedium?.fontSize ?? 14) *
                            fontSize,
                      ),
                      bodySmall: baseTheme.textTheme.bodySmall?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.bodySmall?.fontSize ?? 12) *
                            fontSize,
                      ),
                      labelLarge: baseTheme.textTheme.labelLarge?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.labelLarge?.fontSize ?? 14) *
                            fontSize,
                      ),
                      labelMedium: baseTheme.textTheme.labelMedium?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.labelMedium?.fontSize ?? 12) *
                            fontSize,
                      ),
                      labelSmall: baseTheme.textTheme.labelSmall?.copyWith(
                        fontSize:
                            (baseTheme.textTheme.labelSmall?.fontSize ?? 11) *
                            fontSize,
                      ),
                    ),
                  ),
                  locale: widget.languageService.currentLocale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: LanguageService.supportedLocales,
                  initialRoute: widget.initialRoute,
                  onGenerateRoute: (settings) {
                    // Only use initialDirectoryPath when navigating to the initial route for the first time
                    if (_isFirstRoute &&
                        settings.name == widget.initialRoute &&
                        settings.name == AppRoutes.main &&
                        widget.initialDirectoryPath != null) {
                      _isFirstRoute = false;
                      return AppRoutes.generateRoute(
                        RouteSettings(
                          name: AppRoutes.main,
                          arguments: widget.initialDirectoryPath,
                        ),
                        widget.prefs,
                      );
                    }
                    if (settings.name == widget.initialRoute) {
                      _isFirstRoute = false;
                    }
                    return AppRoutes.generateRoute(settings, widget.prefs);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
