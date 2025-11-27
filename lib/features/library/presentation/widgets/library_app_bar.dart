import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../../../core/services/language_provider.dart';
import '../../../../core/services/theme_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_state.dart';

/// App bar for library screen showing directory path
class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight / 2);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeService = ThemeProvider.of(context);
    final languageService = LanguageProvider.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          // Theme button
          PopupMenuButton<AppThemeMode>(
            icon: const Icon(Icons.palette, size: 16),
            tooltip: 'Theme',
            offset: const Offset(0, 30),
            onSelected: (theme) => themeService.setTheme(theme),
            itemBuilder: (context) => AppThemeMode.values.map((theme) {
              return PopupMenuItem(
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
              );
            }).toList(),
          ),
          // Settings button
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, size: 16),
            tooltip: 'Settings',
            offset: const Offset(0, 30),
            itemBuilder: (context) => [
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: PopupMenuButton<String>(
                  offset: const Offset(180, -10),
                  onSelected: (languageCode) {
                    languageService.changeLanguage(Locale(languageCode));
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: const [
                        Icon(Icons.language, size: 16),
                        SizedBox(width: 8),
                        Text('Language'),
                        Spacer(),
                        Icon(Icons.arrow_right, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      leadingWidth: 100,
      title: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoaded) {
            return InkWell(
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        state.config.directoryPath,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Text(l10n.appTitle);
        },
      ),
      elevation: 1,
    );
  }
}
