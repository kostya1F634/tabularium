import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/app_settings.dart';
import 'package:tabularium/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../features/library/presentation/pages/library_view_wrapper.dart';
import '../../features/library/presentation/bloc/library_bloc.dart';
import '../../features/library/presentation/bloc/library_event.dart';
import '../services/language_provider.dart';
import '../services/ai_settings_provider.dart';
import '../services/language_service.dart';
import '../services/theme_provider.dart';
import '../services/ui_settings_provider.dart';
import '../services/ui_settings_service.dart';
import '../services/window_settings_provider.dart';
import '../theme/app_theme.dart';
import 'ai_settings_dialog.dart';
import 'dialog_shortcuts_wrapper.dart';
import 'shortcuts_dialog.dart';
import 'theme_picker_dialog.dart';

/// Reusable menu bar widget with theme and language settings
class AppMenuBar extends StatelessWidget {
  final Widget? centerWidget;

  const AppMenuBar({super.key, this.centerWidget});

  bool _isInLibraryScreen(BuildContext context) {
    final currentRoute = ModalRoute.of(context);
    return currentRoute?.settings.name == '/main';
  }

  bool _canToggleView(BuildContext context) {
    try {
      // Try to find the ViewModeProviderWidget in the widget tree
      return context.findAncestorWidgetOfExactType<ViewModeProviderWidget>() !=
          null;
    } catch (e) {
      return false;
    }
  }

  void _toggleView(BuildContext context) {
    try {
      final provider = context
          .findAncestorWidgetOfExactType<ViewModeProviderWidget>();
      provider?.onToggle();
    } catch (e) {
      // Ignore
    }
  }

  Future<void> _showAboutDialog(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!context.mounted) return;

    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => DialogShortcutsWrapper(
        onEnterKey: () => Navigator.of(dialogContext).pop(),
        dialog: AlertDialog(
          title: Text(l10n.aboutTabularium),
          content: Text(
            'Tabularium - ${l10n.appSubtitle}\n\n'
            'Version: ${packageInfo.version}\n\n'
            'A modern PDF library manager built with Flutter.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.ok),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeService = ThemeProvider.of(context);
    final languageService = LanguageProvider.of(context);
    final uiSettings = UISettingsProvider.of(context);
    final windowSettings = WindowSettingsProvider.of(context);

    // Calculate submenu offset based on font size to prevent overlap
    final double submenuOffset;
    if (uiSettings.fontSize >= 1.5) {
      submenuOffset = 285.0; // Extra Large
    } else {
      submenuOffset = 230.0; // Large, Normal and below
    }

    return Row(
      children: [
        const SizedBox(width: 8),
        // View mode toggle button (only in library screen)
        if (_isInLibraryScreen(context))
          Builder(
            builder: (context) {
              // Check if we have access to the toggle function
              final canToggle = _canToggleView(context);
              return IconButton(
                icon: const Icon(Icons.view_module, size: 16),
                tooltip: l10n.toggleViewMode,
                onPressed: canToggle ? () => _toggleView(context) : null,
              );
            },
          ),
        // Theme button
        IconButton(
          icon: const Icon(Icons.palette, size: 16),
          tooltip: l10n.theme,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>
                  ThemePickerDialog(themeService: themeService),
            );
          },
        ),
        // AI button (only in library screen)
        if (_isInLibraryScreen(context))
          PopupMenuButton<String>(
            icon: const Icon(Icons.psychology, size: 16),
            tooltip: l10n.ai,
            offset: const Offset(0, 30),
            onSelected: (value) {
              if (value == 'settings') {
                final aiSettings = AISettingsProvider.of(context);
                showDialog(
                  context: context,
                  builder: (dialogContext) => AISettingsDialog(
                    initialUrl: aiSettings.ollamaUrl,
                    initialModel: aiSettings.ollamaModel,
                    initialGeneralization: aiSettings.generalization,
                    initialMaxPages: aiSettings.maxPages,
                    initialProcessImages: aiSettings.processImages,
                    initialOutputLanguage: aiSettings.outputLanguage,
                    aiSettingsService: aiSettings,
                  ),
                );
              } else if (value == 'fullsort') {
                context.read<LibraryBloc>().add(const AIFullSort());
              } else if (value == 'rename') {
                context.read<LibraryBloc>().add(const AIRenameBooks());
              }
            },
            itemBuilder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return [
                PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      const Icon(Icons.settings, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.aiSettings),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'fullsort',
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.aiFullSort),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'rename',
                  child: Row(
                    children: [
                      const Icon(Icons.edit, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.aiRename),
                    ],
                  ),
                ),
              ];
            },
          ),
        // Settings button
        PopupMenuButton<String>(
          icon: const Icon(Icons.settings, size: 16),
          tooltip: l10n.settings,
          offset: const Offset(0, 30),
          itemBuilder: (context) => [
            // Language submenu
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: PopupMenuButton<String>(
                offset: Offset(submenuOffset, -10),
                onSelected: (languageCode) {
                  languageService.changeLanguage(Locale(languageCode));
                  Navigator.pop(context); // Close parent menu
                },
                itemBuilder: (context) =>
                    _buildLanguageMenuItems(context, languageService),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.language, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.language),
                      const Spacer(),
                      const Icon(Icons.arrow_right, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            // Font Size submenu
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: PopupMenuButton<double>(
                offset: Offset(submenuOffset, -50),
                onSelected: (size) {
                  uiSettings.setFontSize(size);
                  Navigator.pop(context); // Close parent menu
                },
                itemBuilder: (context) => [0.8, 0.9, 1.0, 1.2, 1.5].map((size) {
                  return PopupMenuItem(
                    value: size,
                    child: Container(
                      decoration: uiSettings.fontSize == size
                          ? BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            )
                          : null,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        UISettingsService.getFontSizeLabel(l10n, size),
                      ),
                    ),
                  );
                }).toList(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.text_fields, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.fontSize),
                      const Spacer(),
                      const Icon(Icons.arrow_right, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            // Book Scale submenu
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: PopupMenuButton<double>(
                offset: Offset(submenuOffset, -90),
                onSelected: (scale) {
                  uiSettings.setBookScale(scale);
                  Navigator.pop(context); // Close parent menu
                },
                itemBuilder: (context) =>
                    [0.7, 0.85, 1.0, 1.25, 1.5, 2.0].map((scale) {
                      return PopupMenuItem(
                        value: scale,
                        child: Container(
                          decoration: uiSettings.bookScale == scale
                              ? BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(4),
                                )
                              : null,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            UISettingsService.getBookScaleLabel(l10n, scale),
                          ),
                        ),
                      );
                    }).toList(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.photo_size_select_large, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.bookScaleGrid),
                      const Spacer(),
                      const Icon(Icons.arrow_right, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            // Book Scale (Cabinet) submenu
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: PopupMenuButton<double>(
                offset: Offset(submenuOffset, -90),
                onSelected: (scale) {
                  uiSettings.setBookScaleCabinet(scale);
                  Navigator.pop(context); // Close parent menu
                },
                itemBuilder: (context) =>
                    [0.7, 0.85, 1.0, 1.25, 1.5, 2.0].map((scale) {
                      return PopupMenuItem(
                        value: scale,
                        child: Container(
                          decoration: uiSettings.bookScaleCabinet == scale
                              ? BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(4),
                                )
                              : null,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            UISettingsService.getBookScaleLabel(l10n, scale),
                          ),
                        ),
                      );
                    }).toList(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shelves, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.bookScaleCabinet),
                      const Spacer(),
                      const Icon(Icons.arrow_right, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // Help button
        PopupMenuButton<String>(
          icon: const Icon(Icons.help_outline, size: 16),
          tooltip: l10n.help,
          offset: const Offset(0, 30),
          onSelected: (value) async {
            if (value == 'scan') {
              // Trigger scan for new books
              if (_isInLibraryScreen(context)) {
                context.read<LibraryBloc>().add(const ScanForNewBooks());
              }
            } else if (value == 'reset') {
              uiSettings.setFontSize(1.0);
              uiSettings.setBookScale(1.0);
              uiSettings.setBookScaleCabinet(1.0);
              themeService.setTheme(AppThemeMode.light);
              languageService.changeLanguage(const Locale('en'));
              windowSettings.resetWindowSettings();

              // Reset view mode
              final prefs = await AppSettings.getInstance();
              await prefs.remove('view_mode');
            } else if (value == 'shortcuts') {
              showDialog(
                context: context,
                builder: (context) => const ShortcutsDialog(),
              );
            } else if (value == 'about') {
              _showAboutDialog(context);
            }
          },
          itemBuilder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return [
              // Scan (only in library screen)
              if (_isInLibraryScreen(context))
                PopupMenuItem(
                  value: 'scan',
                  child: Row(
                    children: [
                      const Icon(Icons.refresh, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.scan),
                    ],
                  ),
                ),
              if (_isInLibraryScreen(context)) const PopupMenuDivider(),
              PopupMenuItem(
                value: 'shortcuts',
                child: Row(
                  children: [
                    const Icon(Icons.keyboard_outlined, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.shortcuts),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.about),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    const Icon(Icons.restart_alt, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.resetSettings),
                  ],
                ),
              ),
            ];
          },
        ),
        if (centerWidget != null) ...[
          Expanded(child: Center(child: centerWidget)),
        ],
      ],
    );
  }

  /// Build language menu items for all supported languages
  List<PopupMenuEntry<String>> _buildLanguageMenuItems(
    BuildContext context,
    LanguageService languageService,
  ) {
    // Map of language codes to their native names
    const languageNames = {
      'en': 'English',
      'ru': 'Русский',
      'zh': '中文',
      'de': 'Deutsch',
      'fr': 'Français',
      'es': 'Español',
      'it': 'Italiano',
      'pt': 'Português',
      'ja': '日本語',
      'ko': '한국어',
      'hi': 'हिन्दी',
      'ar': 'العربية',
      'tr': 'Türkçe',
      'nl': 'Nederlands',
      'da': 'Dansk',
      'pl': 'Polski',
    };

    return languageNames.entries.map((entry) {
      final languageCode = entry.key;
      final languageName = entry.value;
      final isSelected =
          languageService.currentLocale.languageCode == languageCode;

      return PopupMenuItem(
        value: languageCode,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(languageName),
        ),
      );
    }).toList();
  }
}
