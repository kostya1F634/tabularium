import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

/// Sidebar showing list of shelves
class ShelfsSidebar extends StatelessWidget {
  final List<Shelf> shelves;
  final String selectedShelfId;
  final int totalBooksCount;
  final List<Book> allBooks;
  final bool isFocused;

  const ShelfsSidebar({
    super.key,
    required this.shelves,
    required this.selectedShelfId,
    required this.totalBooksCount,
    required this.allBooks,
    this.isFocused = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            color: isFocused
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
          ),
          // Shelves list
          Expanded(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: shelves.length,
              onReorder: (oldIndex, newIndex) {
                // Don't allow reordering "All" shelf (index 0) or "Unsorted" shelf (index 1)
                if (oldIndex <= 1 || newIndex <= 1) return;

                context.read<LibraryBloc>().add(ReorderShelves(
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                  fromDrag: true,
                ));
              },
              itemBuilder: (context, index) {
                final shelf = shelves[index];
                final isSelected = shelf.id == selectedShelfId;
                final isAllShelf = shelf.id == Shelf.allShelfId;
                final isUnsortedShelf = shelf.id == Shelf.unsortedShelfId;
                final isDefaultShelf = shelf.isDefault;

                // Calculate book count
                int bookCount;
                if (isAllShelf) {
                  bookCount = totalBooksCount;
                } else if (isUnsortedShelf) {
                  // Count books that are not in any user shelf
                  final Set<String> booksInShelves = {};
                  for (final s in shelves) {
                    if (!s.isDefault) {
                      booksInShelves.addAll(s.bookIds);
                    }
                  }
                  bookCount = allBooks.where((book) => !booksInShelves.contains(book.id)).length;
                } else {
                  bookCount = shelf.bookIds.length;
                }

                return _ShelfItem(
                  key: ValueKey(shelf.id),
                  index: index,
                  shelf: shelf,
                  isSelected: isSelected,
                  isDefaultShelf: isDefaultShelf,
                  bookCount: bookCount,
                  onTap: () {
                    context.read<LibraryBloc>().add(SelectShelf(shelf.id));
                  },
                  onDelete: isDefaultShelf
                      ? null
                      : () {
                          _showDeleteDialog(context, shelf);
                        },
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

  void _showCreateShelfDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
              context.read<LibraryBloc>().add(CreateShelf(value.trim()));
              Navigator.of(dialogContext).pop();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                context.read<LibraryBloc>().add(CreateShelf(name));
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(l10n.create),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Shelf shelf) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteShelf),
        content: Text('${l10n.delete} "${shelf.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              context.read<LibraryBloc>().add(DeleteShelf(shelf.id));
              Navigator.of(dialogContext).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}

class _ShelfItem extends StatelessWidget {
  final int index;
  final Shelf shelf;
  final bool isSelected;
  final bool isDefaultShelf;
  final int bookCount;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _ShelfItem({
    super.key,
    required this.index,
    required this.shelf,
    required this.isSelected,
    required this.isDefaultShelf,
    required this.bookCount,
    required this.onTap,
    this.onDelete,
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

        context.read<LibraryBloc>().add(MoveBooksToShelf(
              bookIds: bookIds,
              targetShelfId: shelf.id,
              sourceShelfId: sourceShelfId,
            ));
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;

        return Container(
          decoration: isHovering
              ? BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                )
              : null,
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
      selectedTileColor:
          Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
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
