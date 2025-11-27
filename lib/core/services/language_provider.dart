import 'package:flutter/material.dart';
import 'language_service.dart';

/// Provider for accessing LanguageService in the widget tree
class LanguageProvider extends InheritedNotifier<LanguageService> {
  const LanguageProvider({
    super.key,
    required LanguageService languageService,
    required super.child,
  }) : super(notifier: languageService);

  /// Get LanguageService from context
  static LanguageService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LanguageProvider>()!
        .notifier!;
  }

  /// Try to get LanguageService from context (nullable)
  static LanguageService? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LanguageProvider>()
        ?.notifier;
  }
}

/// Example usage for changing language in UI:
///
/// ```dart
/// // Get language service
/// final languageService = LanguageProvider.of(context);
///
/// // Change to Russian
/// await languageService.changeLanguage(const Locale('ru'));
///
/// // Change to English
/// await languageService.changeLanguage(const Locale('en'));
///
/// // Get current locale
/// final currentLocale = languageService.currentLocale;
/// ```
///
/// Example widget for language selection:
///
/// ```dart
/// class LanguageSelector extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     final languageService = LanguageProvider.of(context);
///     final l10n = AppLocalizations.of(context)!;
///
///     return DropdownButton<Locale>(
///       value: languageService.currentLocale,
///       items: [
///         DropdownMenuItem(
///           value: const Locale('en'),
///           child: Text(l10n.languageEnglish),
///         ),
///         DropdownMenuItem(
///           value: const Locale('ru'),
///           child: Text(l10n.languageRussian),
///         ),
///       ],
///       onChanged: (locale) {
///         if (locale != null) {
///           languageService.changeLanguage(locale);
///         }
///       },
///     );
///   }
/// }
/// ```
