import 'package:flutter/material.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../../../core/widgets/dialog_shortcuts_wrapper.dart';
import '../../domain/entities/shelf.dart';

/// Dialog for selecting a shelf to add books to
class AddToShelfDialog extends StatefulWidget {
  final List<Shelf> shelves;

  const AddToShelfDialog({super.key, required this.shelves});

  @override
  State<AddToShelfDialog> createState() => _AddToShelfDialogState();
}

class _AddToShelfDialogState extends State<AddToShelfDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _createNewShelf(String shelfName) async {
    final l10n = AppLocalizations.of(context)!;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => DialogShortcutsWrapper(
        onEnterKey: () => Navigator.of(dialogContext).pop(true),
        dialog: AlertDialog(
          title: Text(l10n.createShelf),
          content: Text('${l10n.create} "$shelfName"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.create),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      // Return special marker to indicate shelf creation
      Navigator.of(context).pop('create:$shelfName');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Filter out default shelves (All Books, Unsorted)
    final userShelves = widget.shelves.where((s) => !s.isDefault).toList();

    // Filter shelves by search query
    final filteredShelves = _searchQuery.isEmpty
        ? userShelves
        : userShelves.where((shelf) {
            return shelf.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                l10n.selectShelf,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(height: 1),
            // Search field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchShelves,
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
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
                  setState(() {
                    _searchQuery = query;
                  });
                },
                onSubmitted: (query) {
                  // If there are filtered shelves, select the first one
                  if (filteredShelves.isNotEmpty) {
                    Navigator.of(context).pop(filteredShelves.first.id);
                  } else if (query.trim().isNotEmpty) {
                    // If no shelves found, create new shelf with search query
                    _createNewShelf(query.trim());
                  }
                },
                autofocus: true,
              ),
            ),
            // Shelves list
            Expanded(
              child: filteredShelves.isEmpty
                  ? Center(
                      child: Text(
                        _searchQuery.isEmpty
                            ? l10n.noBooks
                            : 'No matching shelves',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredShelves.length,
                      itemBuilder: (context, index) {
                        final shelf = filteredShelves[index];
                        return ListTile(
                          leading: const Icon(Icons.folder),
                          title: Text(shelf.name),
                          subtitle: Text(l10n.bookCount(shelf.bookIds.length)),
                          onTap: () {
                            Navigator.of(context).pop(shelf.id);
                          },
                        );
                      },
                    ),
            ),
            const Divider(height: 1),
            // Actions
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_searchQuery.isNotEmpty && filteredShelves.isEmpty)
                    ElevatedButton.icon(
                      onPressed: () => _createNewShelf(_searchQuery.trim()),
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(l10n.createShelf),
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.cancel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
