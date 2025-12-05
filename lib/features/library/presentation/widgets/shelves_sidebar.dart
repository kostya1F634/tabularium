import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../../../core/widgets/dialog_shortcuts_wrapper.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';

/// Sidebar showing list of shelves
class ShelfsSidebar extends StatefulWidget {
  final List<Shelf> shelves;
  final String selectedShelfId;
  final int totalBooksCount;
  final List<Book> allBooks;
  final bool isFocused;
  final void Function(List<Shelf>)? onFilteredShelvesChanged;
  final void Function(void Function())? onRegisterShelfSearchFocusCallback;
  final void Function(bool Function())? onRegisterCheckShelfSearchFocusCallback;
  final VoidCallback? onRequestFocus;
  final VoidCallback? onSwitchToShelvesArea;

  const ShelfsSidebar({
    super.key,
    required this.shelves,
    required this.selectedShelfId,
    required this.totalBooksCount,
    required this.allBooks,
    this.isFocused = false,
    this.onFilteredShelvesChanged,
    this.onRegisterShelfSearchFocusCallback,
    this.onRegisterCheckShelfSearchFocusCallback,
    this.onRequestFocus,
    this.onSwitchToShelvesArea,
  });

  @override
  State<ShelfsSidebar> createState() => _ShelfsSidebarState();
}

class _ShelfsSidebarState extends State<ShelfsSidebar> {
  final TextEditingController _shelfSearchController = TextEditingController();
  final FocusNode _shelfSearchFocusNode = FocusNode();
  final Map<String, GlobalKey> _shelfKeys = {};
  final ScrollController _scrollController = ScrollController();
  String _shelfSearchQuery = '';
  bool _hasScrolledToSelected = false;

  @override
  void initState() {
    super.initState();
    // Register callbacks for shelf search focus control
    widget.onRegisterShelfSearchFocusCallback?.call(() {
      _shelfSearchFocusNode.requestFocus();
    });
    widget.onRegisterCheckShelfSearchFocusCallback?.call(() {
      return _shelfSearchFocusNode.hasFocus;
    });

    // Scroll to selected shelf on initial build with delay to ensure layout is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _scrollToSelectedShelf();
          _hasScrolledToSelected = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _shelfSearchController.dispose();
    _shelfSearchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ShelfsSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Scroll to selected shelf when it changes (keyboard navigation or click)
    // OR when shelf order changes (reordering with Ctrl+j/k)
    final selectedShelfChanged =
        oldWidget.selectedShelfId != widget.selectedShelfId;
    final shelvesOrderChanged =
        oldWidget.shelves.length == widget.shelves.length &&
        !_shelvesOrderEqual(oldWidget.shelves, widget.shelves);

    if (selectedShelfChanged || shelvesOrderChanged) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedShelf();
      });
    }
  }

  bool _shelvesOrderEqual(List<Shelf> oldShelves, List<Shelf> newShelves) {
    if (oldShelves.length != newShelves.length) return false;
    for (int i = 0; i < oldShelves.length; i++) {
      if (oldShelves[i].id != newShelves[i].id) return false;
    }
    return true;
  }

  void _scrollToSelectedShelf() {
    final selectedShelf = widget.shelves.firstWhere(
      (s) => s.id == widget.selectedShelfId,
      orElse: () => widget.shelves.first,
    );

    // Only scroll if it's a user shelf (not All Books or Unsorted)
    if (selectedShelf.isDefault) return;

    // Get or create key for selected shelf
    if (!_shelfKeys.containsKey(selectedShelf.id)) {
      _shelfKeys[selectedShelf.id] = GlobalKey();
    }

    final key = _shelfKeys[selectedShelf.id];
    final userShelves = widget.shelves.where((s) => !s.isDefault).toList();
    final shelfIndex = userShelves.indexWhere((s) => s.id == selectedShelf.id);

    // For last 2 shelves, scroll to bottom using ScrollController
    if (shelfIndex >= userShelves.length - 2 && _scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        maxScroll,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (key != null && key.currentContext != null) {
      // For other shelves, use ensureVisible with center alignment
      try {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
      } catch (e) {
        // Silently catch any scroll errors
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Separate fixed shelves from user shelves
    final allShelf = widget.shelves.firstWhere((s) => s.id == Shelf.allShelfId);
    final unsortedShelf = widget.shelves.firstWhere(
      (s) => s.id == Shelf.unsortedShelfId,
    );
    final userShelves = widget.shelves.where((s) => !s.isDefault).toList();

    // Filter user shelves by search query
    final filteredUserShelves = _shelfSearchQuery.isEmpty
        ? userShelves
        : userShelves.where((shelf) {
            return shelf.name.toLowerCase().contains(
              _shelfSearchQuery.toLowerCase(),
            );
          }).toList();

    // Notify parent about filtered shelves (including default shelves)
    final filteredAllShelves = [
      allShelf,
      unsortedShelf,
      ...filteredUserShelves,
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onFilteredShelvesChanged?.call(filteredAllShelves);
    });

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 40, // Fixed height to match LibraryHeader
              child: Row(
                children: [
                  Icon(
                    Icons.collections_bookmark,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.shelves,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 3,
            color: widget.isFocused
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
          ),
          // Fixed shelves (All Books, Unsorted)
          _buildShelfItem(context, allShelf, 0, isFixed: true),
          _buildShelfItem(context, unsortedShelf, 1, isFixed: true),
          // Search field for shelves
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              controller: _shelfSearchController,
              focusNode: _shelfSearchFocusNode,
              decoration: InputDecoration(
                hintText: l10n.searchShelves,
                prefixIcon: const Icon(Icons.search, size: 18),
                suffixIcon: _shelfSearchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          setState(() {
                            _shelfSearchController.clear();
                            _shelfSearchQuery = '';
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                isDense: true,
              ),
              onChanged: (query) {
                setState(() {
                  _shelfSearchQuery = query;
                });
              },
            ),
          ),
          // Scrollable user shelves
          Expanded(
            child: filteredUserShelves.isEmpty
                ? Center(
                    child: Text(
                      _shelfSearchQuery.isEmpty
                          ? 'No shelves found'
                          : 'No matching shelves',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ReorderableListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    scrollController: _scrollController,
                    buildDefaultDragHandles: false,
                    padding: const EdgeInsets.only(bottom: 8),
                    itemCount: filteredUserShelves.length,
                    onReorder: (oldIndex, newIndex) {
                      final actualOldIndex =
                          userShelves.indexOf(filteredUserShelves[oldIndex]) +
                          2;
                      final actualNewIndex =
                          userShelves.indexOf(filteredUserShelves[newIndex]) +
                          2;

                      context.read<LibraryBloc>().add(
                        ReorderShelves(
                          oldIndex: actualOldIndex,
                          newIndex: actualNewIndex,
                          fromDrag: true,
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      final shelf = filteredUserShelves[index];
                      final actualIndex = widget.shelves.indexOf(shelf);
                      return _buildShelfItem(
                        context,
                        shelf,
                        actualIndex,
                        isFixed: false,
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          // Create shelf button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showCreateShelfDialog(context),
                icon: const Icon(Icons.add),
                label: Text(l10n.createShelf),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShelfItem(
    BuildContext context,
    Shelf shelf,
    int index, {
    required bool isFixed,
  }) {
    final isSelected = shelf.id == widget.selectedShelfId;
    final isAllShelf = shelf.id == Shelf.allShelfId;
    final isUnsortedShelf = shelf.id == Shelf.unsortedShelfId;

    // Calculate book count
    int bookCount;
    if (isAllShelf) {
      bookCount = widget.totalBooksCount;
    } else if (isUnsortedShelf) {
      // Count books that are not in any user shelf
      final Set<String> booksInShelves = {};
      for (final s in widget.shelves) {
        if (!s.isDefault) {
          booksInShelves.addAll(s.bookIds);
        }
      }
      bookCount = widget.allBooks
          .where((book) => !booksInShelves.contains(book.id))
          .length;
    } else {
      bookCount = shelf.bookIds.length;
    }

    // Get or create GlobalKey for this shelf (only for user shelves)
    GlobalKey? shelfKey;
    if (!shelf.isDefault) {
      if (!_shelfKeys.containsKey(shelf.id)) {
        _shelfKeys[shelf.id] = GlobalKey();
      }
      shelfKey = _shelfKeys[shelf.id];
    }

    return _ShelfItem(
      key: shelfKey ?? ValueKey(shelf.id),
      index: index,
      shelf: shelf,
      isSelected: isSelected,
      isDefaultShelf: shelf.isDefault,
      isFixed: isFixed,
      bookCount: bookCount,
      isFocused: widget.isFocused && isSelected,
      onTap: () {
        context.read<LibraryBloc>().add(SelectShelf(shelf.id));
        // Request focus for main screen when clicking on a shelf
        widget.onRequestFocus?.call();
        // Switch focus area to shelves after a small delay to let SelectShelf process
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.onSwitchToShelvesArea?.call();
        });

        // Scroll to shelf if it's a user shelf
        if (!shelf.isDefault) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final userShelves = widget.shelves
                .where((s) => !s.isDefault)
                .toList();
            final shelfIndex = userShelves.indexWhere((s) => s.id == shelf.id);

            if (shelfIndex == -1) return;

            // For last 2 shelves, scroll to bottom using ScrollController
            if (shelfIndex >= userShelves.length - 2 &&
                _scrollController.hasClients) {
              final maxScroll = _scrollController.position.maxScrollExtent;
              _scrollController.animateTo(
                maxScroll,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              // For other shelves, use ensureVisible
              final ctx = shelfKey?.currentContext;
              if (ctx != null) {
                Scrollable.ensureVisible(
                  ctx,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: 0.5,
                );
              }
            }
          });
        }
      },
      onDelete: shelf.isDefault
          ? null
          : () {
              _showDeleteDialog(context, shelf);
            },
    );
  }

  void _showCreateShelfDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    void createShelf() {
      final name = controller.text.trim();
      if (name.isNotEmpty) {
        context.read<LibraryBloc>().add(CreateShelf(name));
        Navigator.of(context).pop();
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) => DialogShortcutsWrapper(
        onEnterKey: createShelf,
        dialog: AlertDialog(
          title: Text(l10n.createShelf),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: l10n.shelfName,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                createShelf();
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(onPressed: createShelf, child: Text(l10n.create)),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Shelf shelf) {
    final l10n = AppLocalizations.of(context)!;

    void deleteShelf() {
      context.read<LibraryBloc>().add(DeleteShelf(shelf.id));
      Navigator.of(context).pop();
    }

    showDialog(
      context: context,
      builder: (dialogContext) => DialogShortcutsWrapper(
        onEnterKey: deleteShelf,
        dialog: AlertDialog(
          title: Text(l10n.deleteShelf),
          content: Text('${l10n.delete} "${shelf.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: deleteShelf,
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(l10n.delete),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShelfItem extends StatelessWidget {
  final int index;
  final Shelf shelf;
  final bool isSelected;
  final bool isDefaultShelf;
  final bool isFixed;
  final int bookCount;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool isFocused;

  const _ShelfItem({
    super.key,
    required this.index,
    required this.shelf,
    required this.isSelected,
    required this.isDefaultShelf,
    required this.isFixed,
    required this.bookCount,
    required this.onTap,
    this.onDelete,
    this.isFocused = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) {
        // Don't accept drops on default shelves (All and Unsorted)
        return !isDefaultShelf;
      },
      onAcceptWithDetails: (details) {
        final data = details.data;
        final bookIds = List<String>.from(data['bookIds'] as List);
        final sourceShelfId = data['sourceShelfId'] as String;

        context.read<LibraryBloc>().add(
          MoveBooksToShelf(
            bookIds: bookIds,
            targetShelfId: shelf.id,
            sourceShelfId: sourceShelfId,
          ),
        );
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;

        // Determine decoration based on focus and hover states
        // Always have a border to prevent layout shift
        final BoxDecoration decoration;
        if (isFocused) {
          // Focus border (tertiary color, same as books)
          decoration = BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
              width: 3,
            ),
          );
        } else if (isHovering) {
          // Drop target hover border
          decoration = BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withOpacity(0.5),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 3,
            ),
          );
        } else {
          // Transparent border to maintain consistent size
          decoration = BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
          );
        }

        return Container(
          decoration: decoration,
          child: _buildListTile(context, l10n),
        );
      },
    );
  }

  Widget _buildListTile(BuildContext context, AppLocalizations l10n) {
    final isAllShelf = shelf.id == Shelf.allShelfId;
    final isUnsortedShelf = shelf.id == Shelf.unsortedShelfId;

    // Determine icon based on shelf type
    IconData icon;
    if (isAllShelf) {
      icon = Icons.library_books;
    } else if (isUnsortedShelf) {
      icon = Icons.inbox;
    } else {
      icon = Icons.bookmark;
    }

    // Determine display name
    String displayName;
    if (isAllShelf) {
      displayName = l10n.allBooks;
    } else if (isUnsortedShelf) {
      displayName = l10n.unsortedBooks;
    } else {
      displayName = shelf.name;
    }

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        displayName,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        '$bookCount ${bookCount == 1 ? 'book' : 'books'}',
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(
        context,
      ).colorScheme.primaryContainer.withOpacity(0.3),
      onTap: onTap,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: onDelete,
              tooltip: l10n.deleteShelf,
            ),
          if (!isDefaultShelf)
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle, size: 20),
            ),
        ],
      ),
    );
  }
}
