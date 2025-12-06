import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../services/theme_service.dart';
import '../services/ui_settings_provider.dart';
import '../theme/app_theme.dart';
import 'dialog_shortcuts_wrapper.dart';

/// Dialog for selecting application theme with search functionality
class ThemePickerDialog extends StatefulWidget {
  final ThemeService themeService;

  const ThemePickerDialog({super.key, required this.themeService});

  @override
  State<ThemePickerDialog> createState() => _ThemePickerDialogState();
}

class _ThemePickerDialogState extends State<ThemePickerDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<AppThemeMode> _getFilteredThemes() {
    final allThemes = widget.themeService.getGroupedThemes();
    if (_searchQuery.isEmpty) {
      return allThemes;
    }
    return allThemes.where((theme) {
      final themeName = widget.themeService.getThemeName(theme).toLowerCase();
      return themeName.contains(_searchQuery);
    }).toList();
  }

  bool _shouldShowDivider(int index, List<AppThemeMode> themes) {
    if (index == 0) return false;
    if (_searchQuery.isNotEmpty) return false; // No dividers when searching

    final current = themes[index];

    // Only show divider after Dark theme (separator between default and other themes)
    return current == AppThemeMode.akane;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final uiSettings = UISettingsProvider.of(context);
    final filteredThemes = _getFilteredThemes();

    return DialogShortcutsWrapper(
      onEnterKey: () {
        if (filteredThemes.isNotEmpty) {
          widget.themeService.setTheme(filteredThemes.first);
          Navigator.of(context).pop();
        }
      },
      dialog: AlertDialog(
        title: Text(l10n.theme),
        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        content: SizedBox(
          width: 600,
          height: 500,
          child: Column(
            children: [
              // Search field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: l10n.searchThemes,
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Theme list
              Expanded(
                child: filteredThemes.isEmpty
                    ? Center(
                        child: Text(
                          'No themes found',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.fontSize! *
                                    uiSettings.fontSize,
                              ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredThemes.length,
                        itemBuilder: (context, index) {
                          final theme = filteredThemes[index];
                          final isSelected =
                              widget.themeService.currentTheme == theme;

                          return Column(
                            children: [
                              if (_shouldShowDivider(index, filteredThemes))
                                const Divider(height: 1),
                              ListTile(
                                dense: true,
                                tileColor: isSelected
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.primary.withOpacity(0.15)
                                    : null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                title: Text(
                                  widget.themeService.getThemeName(theme),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.fontSize! *
                                            uiSettings.fontSize,
                                      ),
                                ),
                                onTap: () {
                                  widget.themeService.setTheme(theme);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }
}
