import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_routes.dart';
import 'core/services/language_provider.dart';
import 'core/services/language_service.dart';
import 'core/services/theme_service.dart';
import 'core/services/theme_provider.dart';
import 'package:tabularium/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final languageService = LanguageService(prefs);
  final themeService = ThemeService(prefs);

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

  runApp(TabulariumApp(
    prefs: prefs,
    languageService: languageService,
    themeService: themeService,
    initialRoute: initialRoute,
    initialDirectoryPath: initialDirectoryPath,
  ));
}

class TabulariumApp extends StatefulWidget {
  final SharedPreferences prefs;
  final LanguageService languageService;
  final ThemeService themeService;
  final String initialRoute;
  final String? initialDirectoryPath;

  const TabulariumApp({
    super.key,
    required this.prefs,
    required this.languageService,
    required this.themeService,
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
        child: ListenableBuilder(
          listenable: Listenable.merge([widget.languageService, widget.themeService]),
          builder: (context, child) {
            return MaterialApp(
              title: 'Tabularium',
              debugShowCheckedModeBanner: false,
              theme: widget.themeService.themeData,
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
                if (_isFirstRoute && settings.name == widget.initialRoute && settings.name == AppRoutes.main && widget.initialDirectoryPath != null) {
                  _isFirstRoute = false;
                  return AppRoutes.generateRoute(
                    RouteSettings(name: AppRoutes.main, arguments: widget.initialDirectoryPath),
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
    );
  }
}
