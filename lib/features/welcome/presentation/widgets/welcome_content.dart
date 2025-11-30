import 'package:flutter/material.dart';
import 'package:tabularium/l10n/app_localizations.dart';
import '../../domain/entities/directory_path.dart';

class WelcomeContent extends StatelessWidget {
  final List<DirectoryPath> recentDirectories;
  final List<DirectoryPath> favoriteDirectories;
  final VoidCallback onPickDirectory;
  final Function(String) onSelectDirectory;
  final VoidCallback onClearRecent;
  final Function(String) onRemoveRecent;
  final Function(String) onAddToFavorites;
  final Function(String) onRemoveFromFavorites;
  final VoidCallback onClearFavorites;

  const WelcomeContent({
    super.key,
    required this.recentDirectories,
    required this.favoriteDirectories,
    required this.onPickDirectory,
    required this.onSelectDirectory,
    required this.onClearRecent,
    required this.onRemoveRecent,
    required this.onAddToFavorites,
    required this.onRemoveFromFavorites,
    required this.onClearFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Application name
        Text(
          AppLocalizations.of(context)!.appTitle,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          AppLocalizations.of(context)!.appSubtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),

        const SizedBox(height: 48),

        // Directory selection button
        ElevatedButton.icon(
          onPressed: onPickDirectory,
          icon: const Icon(Icons.folder_open, size: 24),
          label: Text(AppLocalizations.of(context)!.selectBooksDirectory),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
          ),
        ),

        const SizedBox(height: 48),

        // Two columns: Favorites and Recent
        if (recentDirectories.isNotEmpty || favoriteDirectories.isNotEmpty)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Favorites column
                Expanded(
                  child: _DirectoryList(
                    title: AppLocalizations.of(context)!.favorites,
                    directories: favoriteDirectories,
                    onSelect: onSelectDirectory,
                    onClear: favoriteDirectories.isNotEmpty
                        ? onClearFavorites
                        : null,
                    onRemove: onRemoveFromFavorites,
                    onSecondaryAction:
                        null, // No add to favorites from favorites
                    clearButtonText: AppLocalizations.of(
                      context,
                    )!.clearFavorites,
                  ),
                ),

                const SizedBox(width: 24),

                // Recent directories column
                Expanded(
                  child: _DirectoryList(
                    title: AppLocalizations.of(context)!.recentDirectories,
                    directories: recentDirectories,
                    onSelect: onSelectDirectory,
                    onClear: recentDirectories.isNotEmpty
                        ? onClearRecent
                        : null,
                    onRemove: onRemoveRecent,
                    onSecondaryAction: onAddToFavorites,
                    secondaryActionIcon: Icons.star_border,
                    secondaryActionTooltip: AppLocalizations.of(
                      context,
                    )!.addToFavorites,
                    clearButtonText: AppLocalizations.of(context)!.clearRecent,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DirectoryList extends StatelessWidget {
  final String title;
  final List<DirectoryPath> directories;
  final Function(String) onSelect;
  final VoidCallback? onClear;
  final Function(String) onRemove;
  final Function(String)? onSecondaryAction;
  final IconData? secondaryActionIcon;
  final String? secondaryActionTooltip;
  final String clearButtonText;

  const _DirectoryList({
    required this.title,
    required this.directories,
    required this.onSelect,
    required this.onClear,
    required this.onRemove,
    required this.clearButtonText,
    this.onSecondaryAction,
    this.secondaryActionIcon,
    this.secondaryActionTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and clear button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (onClear != null)
              TextButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear_all, size: 16),
                label: Text(clearButtonText),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
          ],
        ),

        const SizedBox(height: 16),

        // Directory list
        if (directories.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                'No directories',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: directories.length,
            itemBuilder: (context, index) {
              final dir = directories[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  title: Text(
                    dir.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    dir.path,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Secondary action button (add to favorites)
                      if (onSecondaryAction != null &&
                          secondaryActionIcon != null)
                        IconButton(
                          icon: Icon(secondaryActionIcon, size: 20),
                          tooltip: secondaryActionTooltip,
                          onPressed: () => onSecondaryAction!(dir.path),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                        ),
                      // Remove button
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        tooltip: 'Remove',
                        onPressed: () => onRemove(dir.path),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      // Arrow icon
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.4),
                      ),
                    ],
                  ),
                  onTap: () => onSelect(dir.path),
                ),
              );
            },
          ),
      ],
    );
  }
}
