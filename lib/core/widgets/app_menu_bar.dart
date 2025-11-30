import 'package:flutter/material.dart';
import '../services/app_settings.dart';
import 'package:tabularium/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../features/library/presentation/pages/library_view_wrapper.dart';
import '../services/language_provider.dart';
import '../services/theme_provider.dart';
import '../services/ui_settings_provider.dart';
import '../services/window_settings_provider.dart';
import '../theme/app_theme.dart';
import 'shortcuts_dialog.dart';

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
      builder: (context) => AlertDialog(
        title: Text(l10n.aboutTabularium),
        content: Text(
          'Tabularium - ${l10n.appSubtitle}\n\n'
          'Version: ${packageInfo.version}\n\n'
          'A modern PDF library manager built with Flutter.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.ok),
          ),
        ],
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
        PopupMenuButton<AppThemeMode>(
          icon: const Icon(Icons.palette, size: 16),
          tooltip: l10n.theme,
          offset: const Offset(0, 30),
          onSelected: (theme) => themeService.setTheme(theme),
          itemBuilder: (context) {
            final items = <PopupMenuEntry<AppThemeMode>>[];
            final themes = themeService.getGroupedThemes();

            for (int i = 0; i < themes.length; i++) {
              final theme = themes[i];

              // Add divider between theme families
              if (i > 0 && _shouldAddDivider(themes[i - 1], theme)) {
                items.add(const PopupMenuDivider());
              }

              items.add(
                PopupMenuItem(
                  value: theme,
                  child: Row(
                    children: [
                      if (themeService.currentTheme == theme)
                        const Icon(Icons.check, size: 16)
                      else
                        const SizedBox(width: 16),
                      const SizedBox(width: 8),
                      Text(themeService.getThemeName(theme)),
                    ],
                  ),
                ),
              );
            }

            return items;
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
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        if (languageService.currentLocale.languageCode == 'en')
                          const Icon(Icons.check, size: 16)
                        else
                          const SizedBox(width: 16),
                        const SizedBox(width: 8),
                        const Text('English'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'ru',
                    child: Row(
                      children: [
                        if (languageService.currentLocale.languageCode == 'ru')
                          const Icon(Icons.check, size: 16)
                        else
                          const SizedBox(width: 16),
                        const SizedBox(width: 8),
                        const Text('Русский'),
                      ],
                    ),
                  ),
                ],
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
                    child: Row(
                      children: [
                        if (uiSettings.fontSize == size)
                          const Icon(Icons.check, size: 16)
                        else
                          const SizedBox(width: 16),
                        const SizedBox(width: 8),
                        Text(uiSettings.getFontSizeLabel(size)),
                      ],
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
                        child: Row(
                          children: [
                            if (uiSettings.bookScale == scale)
                              const Icon(Icons.check, size: 16)
                            else
                              const SizedBox(width: 16),
                            const SizedBox(width: 8),
                            Text(uiSettings.getBookScaleLabel(scale)),
                          ],
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
                        child: Row(
                          children: [
                            if (uiSettings.bookScaleCabinet == scale)
                              const Icon(Icons.check, size: 16)
                            else
                              const SizedBox(width: 16),
                            const SizedBox(width: 8),
                            Text(uiSettings.getBookScaleLabel(scale)),
                          ],
                        ),
                      );
                    }).toList(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.shelves, size: 16),
                      SizedBox(width: 8),
                      Text('Book Scale (Cabinet)'),
                      Spacer(),
                      Icon(Icons.arrow_right, size: 16),
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
          tooltip: 'Help',
          offset: const Offset(0, 30),
          onSelected: (value) async {
            if (value == 'reset') {
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
              const PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16),
                    SizedBox(width: 8),
                    Text('About'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.restart_alt, size: 16),
                    SizedBox(width: 8),
                    Text('Reset Settings'),
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

  /// Determines if a divider should be added between two themes
  /// Returns true if themes belong to different families
  static bool _shouldAddDivider(AppThemeMode prev, AppThemeMode current) {
    // Define theme family boundaries
    // A divider is added when switching from one family to another
    final familyStarts = [
      AppThemeMode.light, // Default
      AppThemeMode.atomOneDark, // Atom One
      AppThemeMode.ayuDark, // Ayu
      AppThemeMode.catppuccinLatte, // Catppuccin
      AppThemeMode.dracula, // Dracula
      AppThemeMode.everforestDark, // Everforest
      AppThemeMode.githubDark, // GitHub
      AppThemeMode.gruber, // Gruber
      AppThemeMode.gruvboxDark, // Gruvbox
      AppThemeMode.materialDark, // Material
      AppThemeMode.monokai, // Monokai
      AppThemeMode.nordDark, // Nord
      AppThemeMode.paper, // Paper
      AppThemeMode.realistic, // Realistic
      AppThemeMode.rosePineDawn, // Rosé Pine
      AppThemeMode.solarizedDark, // Solarized
      AppThemeMode.tokyoNight, // Tokyo Night
      AppThemeMode.highContrast, // Special
    ];

    return familyStarts.contains(current);
  }
}
