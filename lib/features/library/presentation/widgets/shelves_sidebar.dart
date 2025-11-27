import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

/// Sidebar showing list of shelves
class ShelfsSidebar extends StatelessWidget {
  final List<Shelf> shelves;
  final String selectedShelfId;
  final int totalBooksCount;

  const ShelfsSidebar({
    super.key,
    required this.shelves,
    required this.selectedShelfId,
    required this.totalBooksCount,
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
          const Divider(height: 1),
          // Shelves list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: shelves.length,
              itemBuilder: (context, index) {
                final shelf = shelves[index];
                final isSelected = shelf.id == selectedShelfId;
                final isAllShelf = shelf.id == Shelf.allShelfId;

                return _ShelfItem(
                  shelf: shelf,
                  isSelected: isSelected,
                  isAllShelf: isAllShelf,
                  bookCount: isAllShelf ? totalBooksCount : shelf.bookIds.length,
                  onTap: () {
                    context.read<LibraryBloc>().add(SelectShelf(shelf.id));
                  },
                  onDelete: isAllShelf
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
  final Shelf shelf;
  final bool isSelected;
  final bool isAllShelf;
  final int bookCount;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _ShelfItem({
    required this.shelf,
    required this.isSelected,
    required this.isAllShelf,
    required this.bookCount,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) {
        // Don't accept drops on "All" shelf
        return !isAllShelf;
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
    return ListTile(
      leading: Icon(
        isAllShelf ? Icons.library_books : Icons.bookmark,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        isAllShelf ? l10n.allBooks : shelf.name,
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
      trailing: onDelete != null
          ? IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: onDelete,
              tooltip: l10n.deleteShelf,
            )
          : null,
    );
  }
}
