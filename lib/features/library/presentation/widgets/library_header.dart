import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../../../core/widgets/dialog_shortcuts_wrapper.dart';
import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

/// Header with action buttons
class LibraryHeader extends StatefulWidget {
  final Shelf selectedShelf;
  final int bookCount;
  final bool isFocused;
  final void Function(void Function())? onRegisterFocusCallback;
  final void Function(bool Function())? onRegisterCheckFocusCallback;

  const LibraryHeader({
    super.key,
    required this.selectedShelf,
    required this.bookCount,
    this.isFocused = false,
    this.onRegisterFocusCallback,
    this.onRegisterCheckFocusCallback,
  });

  @override
  State<LibraryHeader> createState() => _LibraryHeaderState();
}

class _LibraryHeaderState extends State<LibraryHeader> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Register callback to focus search field
    widget.onRegisterFocusCallback?.call(() {
      _searchFocusNode.requestFocus();
    });
    // Register callback to check if search has focus
    widget.onRegisterCheckFocusCallback?.call(() {
      return _searchFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _getSortOptionText(BuildContext context, BookSortOption option) {
    final l10n = AppLocalizations.of(context)!;
    switch (option) {
      case BookSortOption.dateAddedNewest:
        return l10n.sortDateAddedNewest;
      case BookSortOption.dateAddedOldest:
        return l10n.sortDateAddedOldest;
      case BookSortOption.dateOpenedNewest:
        return l10n.sortDateOpenedNewest;
      case BookSortOption.dateOpenedOldest:
        return l10n.sortDateOpenedOldest;
      case BookSortOption.titleAZ:
        return l10n.sortTitleAZ;
      case BookSortOption.titleZA:
        return l10n.sortTitleZA;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is! LibraryLoaded) {
          return const SizedBox.shrink();
        }

        final hasSelection = state.hasSelection;
        final selectedCount = state.selectedBookIds.length;
        final isAllShelf = widget.selectedShelf.id == 'all';
        final isUnsortedShelf = widget.selectedShelf.id == 'unsorted';
        final isDefaultShelf = isAllShelf || isUnsortedShelf;

        // Clear search field if search was cleared from elsewhere
        if (state.searchQuery == null && _searchController.text.isNotEmpty) {
          _searchController.clear();
        }

        return Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 40, // Fixed height to prevent jittering
            child: Row(
              children: [
                if (hasSelection) ...[
                  // Selection mode actions
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<LibraryBloc>().add(const OpenAllBooks()),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: Text(l10n.openSelected),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () =>
                        context.read<LibraryBloc>().add(const SelectAllBooks()),
                    icon: const Icon(Icons.select_all, size: 18),
                    label: Text(l10n.selectAll),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => context.read<LibraryBloc>().add(
                      const ClearBookSelection(),
                    ),
                    icon: const Icon(Icons.deselect, size: 18),
                    label: Text(l10n.clearSelection),
                  ),
                  if (!isDefaultShelf) ...[
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () => context.read<LibraryBloc>().add(
                        const DeleteSelectedBooks(),
                      ),
                      icon: const Icon(Icons.remove_circle_outline, size: 18),
                      label: Text(l10n.removeFromShelf),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => DialogShortcutsWrapper(
                          onEnterKey: () =>
                              Navigator.of(dialogContext).pop(true),
                          dialog: AlertDialog(
                            title: Text(l10n.confirmDeleteSelected),
                            content: Text(
                              l10n.confirmDeleteSelectedMessage(selectedCount),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(false),
                                child: Text(l10n.cancel),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(true),
                                style: TextButton.styleFrom(
                                  foregroundColor: Theme.of(
                                    dialogContext,
                                  ).colorScheme.error,
                                ),
                                child: Text(l10n.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        context.read<LibraryBloc>().add(
                          const DeleteSelectedBooksPermanently(),
                        );
                      }
                    },
                    icon: const Icon(Icons.delete, size: 18),
                    label: Text(l10n.deleteSelected),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$selectedCount ${l10n.selected}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  // Normal mode actions
                  ElevatedButton.icon(
                    onPressed: widget.bookCount > 0
                        ? () => context.read<LibraryBloc>().add(
                            const OpenAllBooks(),
                          )
                        : null,
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: Text(l10n.openAllBooks),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: widget.bookCount > 0
                        ? () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) =>
                                  DialogShortcutsWrapper(
                                    onEnterKey: () =>
                                        Navigator.of(dialogContext).pop(true),
                                    dialog: AlertDialog(
                                      title: Text(l10n.confirmDeleteAll),
                                      content: Text(
                                        l10n.confirmDeleteAllMessage(
                                          widget.bookCount,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(
                                            dialogContext,
                                          ).pop(false),
                                          child: Text(l10n.cancel),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(
                                            dialogContext,
                                          ).pop(true),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Theme.of(
                                              dialogContext,
                                            ).colorScheme.error,
                                          ),
                                          child: Text(l10n.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                            if (confirmed == true && context.mounted) {
                              context.read<LibraryBloc>().add(
                                DeleteAllBooksFromShelf(
                                  widget.selectedShelf.id,
                                ),
                              );
                            }
                          }
                        : null,
                    icon: const Icon(Icons.delete, size: 18),
                    label: Text(l10n.deleteAll),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                // Search field (always visible when not in selection mode, aligned to the right)
                if (!hasSelection) ...[
                  const Spacer(),
                  // Sort menu
                  PopupMenuButton<BookSortOption>(
                    offset: const Offset(0, 48),
                    onSelected: (BookSortOption newValue) {
                      context.read<LibraryBloc>().add(SortBooks(newValue));
                      FocusScope.of(context).unfocus();
                    },
                    itemBuilder: (context) {
                      final menuL10n = AppLocalizations.of(context)!;
                      return [
                        PopupMenuItem(
                          value: BookSortOption.dateAddedNewest,
                          child: Container(
                            decoration:
                                state.sortOption ==
                                    BookSortOption.dateAddedNewest
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
                            child: Text(menuL10n.sortDateAddedNewest),
                          ),
                        ),
                        PopupMenuItem(
                          value: BookSortOption.dateAddedOldest,
                          child: Container(
                            decoration:
                                state.sortOption ==
                                    BookSortOption.dateAddedOldest
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
                            child: Text(menuL10n.sortDateAddedOldest),
                          ),
                        ),
                        PopupMenuItem(
                          value: BookSortOption.dateOpenedNewest,
                          child: Container(
                            decoration:
                                state.sortOption ==
                                    BookSortOption.dateOpenedNewest
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
                            child: Text(menuL10n.sortDateOpenedNewest),
                          ),
                        ),
                        PopupMenuItem(
                          value: BookSortOption.dateOpenedOldest,
                          child: Container(
                            decoration:
                                state.sortOption ==
                                    BookSortOption.dateOpenedOldest
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
                            child: Text(menuL10n.sortDateOpenedOldest),
                          ),
                        ),
                        PopupMenuItem(
                          value: BookSortOption.titleAZ,
                          child: Container(
                            decoration:
                                state.sortOption == BookSortOption.titleAZ
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
                            child: Text(menuL10n.sortTitleAZ),
                          ),
                        ),
                        PopupMenuItem(
                          value: BookSortOption.titleZA,
                          child: Container(
                            decoration:
                                state.sortOption == BookSortOption.titleZA
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
                            child: Text(menuL10n.sortTitleZA),
                          ),
                        ),
                      ];
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_getSortOptionText(context, state.sortOption)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: l10n.searchBooks,
                        prefixIcon: const Icon(Icons.search, size: 20),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<LibraryBloc>().add(
                                    const ClearSearch(),
                                  );
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        isDense: true,
                      ),
                      onChanged: (query) {
                        setState(() {}); // Update to show/hide clear button
                        if (query.isEmpty) {
                          context.read<LibraryBloc>().add(const ClearSearch());
                        } else {
                          context.read<LibraryBloc>().add(SearchBooks(query));
                        }
                      },
                      onSubmitted: (_) {
                        // Pressing Enter in search should unfocus
                        _searchFocusNode.unfocus();
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
