import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabularium/l10n/app_localizations.dart';
import '../../../../core/services/app_settings.dart';
import '../../domain/entities/directory_path.dart';

enum FocusedList { favorites, recent }

class WelcomeContent extends StatefulWidget {
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
  State<WelcomeContent> createState() => _WelcomeContentState();
}

class _WelcomeContentState extends State<WelcomeContent> {
  FocusedList _focusedList = FocusedList.favorites;
  int _selectedIndex = 0;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus after frame to capture keyboard events
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<DirectoryPath> get _currentList {
    return _focusedList == FocusedList.favorites
        ? widget.favoriteDirectories
        : widget.recentDirectories;
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final isCtrlPressed = HardwareKeyboard.instance.isControlPressed;

    // Handle Ctrl+W to return to previous directory
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyW) {
      _returnToPreviousDirectory();
      return KeyEventResult.handled;
    }

    // Tab to switch between lists
    if (event.logicalKey == LogicalKeyboardKey.tab) {
      setState(() {
        _focusedList = _focusedList == FocusedList.favorites
            ? FocusedList.recent
            : FocusedList.favorites;
        _selectedIndex = 0;
      });
      return KeyEventResult.handled;
    }

    if (_currentList.isEmpty) return KeyEventResult.ignored;

    // j/k or arrows for navigation
    if (event.logicalKey == LogicalKeyboardKey.keyJ ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _selectedIndex = (_selectedIndex + 1).clamp(0, _currentList.length - 1);
      });
      return KeyEventResult.handled;
    }

    if (event.logicalKey == LogicalKeyboardKey.keyK ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _selectedIndex = (_selectedIndex - 1).clamp(0, _currentList.length - 1);
      });
      return KeyEventResult.handled;
    }

    // Enter to open directory
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      final selectedDir = _currentList[_selectedIndex];
      widget.onSelectDirectory(selectedDir.path);
      return KeyEventResult.handled;
    }

    // Delete to remove directory
    if (event.logicalKey == LogicalKeyboardKey.delete) {
      final selectedDir = _currentList[_selectedIndex];
      if (_focusedList == FocusedList.favorites) {
        widget.onRemoveFromFavorites(selectedDir.path);
      } else {
        widget.onRemoveRecent(selectedDir.path);
      }
      // Adjust selection if needed
      setState(() {
        if (_selectedIndex >= _currentList.length - 1 && _selectedIndex > 0) {
          _selectedIndex--;
        }
      });
      return KeyEventResult.handled;
    }

    // Space to toggle favorite
    if (event.logicalKey == LogicalKeyboardKey.space) {
      final selectedDir = _currentList[_selectedIndex];
      if (_focusedList == FocusedList.favorites) {
        widget.onRemoveFromFavorites(selectedDir.path);
        // Adjust selection if needed
        setState(() {
          if (_selectedIndex >= widget.favoriteDirectories.length - 1 &&
              _selectedIndex > 0) {
            _selectedIndex--;
          }
        });
      } else {
        widget.onAddToFavorites(selectedDir.path);
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _returnToPreviousDirectory() async {
    final prefs = await AppSettings.getInstance();
    final previousDir = prefs.getString('temp_previous_directory');

    if (previousDir != null && mounted) {
      await prefs.remove('temp_previous_directory');
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacementNamed('/main', arguments: previousDir);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: Column(
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
            onPressed: widget.onPickDirectory,
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
          if (widget.recentDirectories.isNotEmpty ||
              widget.favoriteDirectories.isNotEmpty)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Favorites column
                  Expanded(
                    child: _DirectoryList(
                      title: AppLocalizations.of(context)!.favorites,
                      directories: widget.favoriteDirectories,
                      onSelect: widget.onSelectDirectory,
                      onClear: widget.favoriteDirectories.isNotEmpty
                          ? widget.onClearFavorites
                          : null,
                      onRemove: widget.onRemoveFromFavorites,
                      onSecondaryAction:
                          null, // No add to favorites from favorites
                      clearButtonText: AppLocalizations.of(
                        context,
                      )!.clearFavorites,
                      isFocused: _focusedList == FocusedList.favorites,
                      selectedIndex: _focusedList == FocusedList.favorites
                          ? _selectedIndex
                          : null,
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Recent directories column
                  Expanded(
                    child: _DirectoryList(
                      title: AppLocalizations.of(context)!.recentDirectories,
                      directories: widget.recentDirectories,
                      onSelect: widget.onSelectDirectory,
                      onClear: widget.recentDirectories.isNotEmpty
                          ? widget.onClearRecent
                          : null,
                      onRemove: widget.onRemoveRecent,
                      onSecondaryAction: widget.onAddToFavorites,
                      secondaryActionIcon: Icons.star_border,
                      secondaryActionTooltip: AppLocalizations.of(
                        context,
                      )!.addToFavorites,
                      clearButtonText: AppLocalizations.of(
                        context,
                      )!.clearRecent,
                      isFocused: _focusedList == FocusedList.recent,
                      selectedIndex: _focusedList == FocusedList.recent
                          ? _selectedIndex
                          : null,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
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
  final bool isFocused;
  final int? selectedIndex;

  const _DirectoryList({
    required this.title,
    required this.directories,
    required this.onSelect,
    required this.onClear,
    required this.onRemove,
    required this.clearButtonText,
    required this.isFocused,
    required this.selectedIndex,
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: isFocused
              ? BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isFocused
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
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
              final isSelected = isFocused && selectedIndex == index;

              // Determine border decoration based on selection
              final BoxDecoration decoration;
              if (isSelected) {
                decoration = BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                );
              } else {
                // Transparent border to maintain consistent size
                decoration = BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 3),
                  borderRadius: BorderRadius.circular(12),
                );
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: decoration,
                child: Card(
                  margin: EdgeInsets.zero,
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
                ),
              );
            },
          ),
      ],
    );
  }
}
