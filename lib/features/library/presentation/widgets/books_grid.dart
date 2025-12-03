import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../../../core/services/ui_settings_provider.dart';
import '../../../../core/widgets/dialog_shortcuts_wrapper.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import 'book_properties_dialog.dart';
import 'add_to_shelf_dialog.dart';

/// Grid view displaying books with covers and titles
class BooksGrid extends StatelessWidget {
  final List<Book> books;
  final List<Shelf> shelves;
  final String? focusedBookId;

  const BooksGrid({
    super.key,
    required this.books,
    required this.shelves,
    this.focusedBookId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final uiSettings = UISettingsProvider.of(context);

    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noBooks,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListenableBuilder(
      listenable: uiSettings,
      builder: (context, child) {
        final bookScale = uiSettings.bookScale;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200 * bookScale,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return _BookCard(
              book: book,
              shelves: shelves,
              bookScale: bookScale,
              isFocused: book.id == focusedBookId,
            );
          },
        );
      },
    );
  }
}

class _BookCard extends StatelessWidget {
  final Book book;
  final List<Shelf> shelves;
  final double bookScale;
  final bool isFocused;

  const _BookCard({
    required this.book,
    required this.shelves,
    required this.bookScale,
    this.isFocused = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is! LibraryLoaded) {
          return const SizedBox.shrink();
        }

        final isSelected = state.selectedBookIds.contains(book.id);
        final currentShelfId = state.selectedShelf.id;

        return Draggable<Map<String, dynamic>>(
          data: {
            'bookIds': state.selectedBookIds.isNotEmpty && isSelected
                ? state.selectedBookIds.toList()
                : [book.id],
            'sourceShelfId': currentShelfId,
          },
          feedback: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 150,
              height: 200,
              child: Opacity(
                opacity: 0.8,
                child: _buildCardContent(context, isSelected),
              ),
            ),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: _buildCardContent(context, isSelected),
          ),
          child: _buildCardContent(context, isSelected),
        );
      },
    );
  }

  Widget _buildCardContent(BuildContext context, bool isSelected) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: isSelected || isFocused ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 3)
            : BorderSide.none,
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              context.read<LibraryBloc>().add(ToggleBookSelection(book.id));
            },
            onSecondaryTapDown: (details) {
              _showContextMenu(context, details.globalPosition);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Book cover/thumbnail
                Expanded(child: _BookCover(thumbnailPath: book.thumbnailPath)),
                // Book title
                Padding(
                  padding: EdgeInsets.all(8 * bookScale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.displayTitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize:
                              (Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize ??
                                  14) *
                              bookScale,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (book.author != null) ...[
                        SizedBox(height: 4 * bookScale),
                        Text(
                          book.author!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontSize:
                                    (Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.fontSize ??
                                        12) *
                                    bookScale,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Selection overlay
          if (isSelected)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // Focus border overlay (on top of everything)
          if (isFocused)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showContextMenu(BuildContext context, Offset position) async {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LibraryBloc>();
    final state = bloc.state;

    if (state is! LibraryLoaded) return;

    final isAllShelf = state.selectedShelf.id == Shelf.allShelfId;
    final isUnsortedShelf = state.selectedShelf.id == Shelf.unsortedShelfId;
    final isDefaultShelf = isAllShelf || isUnsortedShelf;

    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + 1,
        position.dy + 1,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'open',
          child: Row(
            children: [
              const Icon(Icons.open_in_new, size: 18),
              const SizedBox(width: 8),
              Text(l10n.open),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'add',
          child: Row(
            children: [
              const Icon(Icons.add_circle_outline, size: 18),
              const SizedBox(width: 8),
              Text(l10n.add),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'properties',
          child: Row(
            children: [
              const Icon(Icons.info_outline, size: 18),
              const SizedBox(width: 8),
              Text(l10n.properties),
            ],
          ),
        ),
        if (!isDefaultShelf)
          PopupMenuItem<String>(
            value: 'remove',
            child: Row(
              children: [
                Icon(
                  Icons.remove_circle_outline,
                  size: 18,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.remove,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: 18,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.deleteBook,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
      ],
    );

    if (result != null && context.mounted) {
      switch (result) {
        case 'open':
          bloc.add(OpenBook(book));
          break;
        case 'remove':
          bloc.add(
            DeleteBookFromShelf(
              bookId: book.id,
              shelfId: state.selectedShelf.id,
            ),
          );
          break;
        case 'add':
          // Determine which books to add: if selection exists, add selected books; otherwise, add clicked book
          final booksToAdd = state.hasSelection
              ? state.selectedBookIds
              : [book.id];

          // Show shelf selection dialog
          final result = await showDialog<String>(
            context: context,
            builder: (context) =>
                AddToShelfDialog(shelves: state.config.shelves),
          );

          if (result != null && context.mounted) {
            String shelfId;

            // Check if user wants to create a new shelf
            if (result.startsWith('create:')) {
              final shelfName = result.substring(7); // Remove 'create:' prefix

              // Create new shelf
              bloc.add(CreateShelf(shelfName));

              // Wait for the new shelf to be created
              await Future.delayed(const Duration(milliseconds: 100));

              // Get the newly created shelf ID
              final updatedState = bloc.state;
              if (updatedState is LibraryLoaded) {
                final newShelf = updatedState.config.shelves.lastWhere(
                  (shelf) => shelf.name == shelfName && !shelf.isDefault,
                );
                shelfId = newShelf.id;
              } else {
                return; // State is not loaded, cancel operation
              }
            } else {
              shelfId = result;
            }

            // Add books to selected or newly created shelf
            for (final bookId in booksToAdd) {
              bloc.add(AddBookToShelf(bookId: bookId, shelfId: shelfId));
            }

            // Clear selection after adding
            if (state.hasSelection && context.mounted) {
              bloc.add(const ClearBookSelection());
            }
          }
          break;
        case 'delete':
          // Show confirmation dialog
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (dialogContext) => DialogShortcutsWrapper(
              onEnterKey: () => Navigator.of(dialogContext).pop(true),
              dialog: AlertDialog(
                title: Text(l10n.confirmDeleteBook),
                content: Text(l10n.confirmDeleteBookMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: Text(l10n.cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
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
            bloc.add(DeleteBookPermanently(book.id));
          }
          break;
        case 'properties':
          showDialog(
            context: context,
            builder: (dialogContext) => BlocProvider.value(
              value: bloc,
              child: BookPropertiesDialog(book: book),
            ),
          );
          break;
      }
    }
  }
}

class _BookCover extends StatelessWidget {
  final String? thumbnailPath;

  const _BookCover({this.thumbnailPath});

  @override
  Widget build(BuildContext context) {
    if (thumbnailPath != null && File(thumbnailPath!).existsSync()) {
      return Image.file(
        File(thumbnailPath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _PlaceholderCover();
        },
      );
    }

    return _PlaceholderCover();
  }
}

class _PlaceholderCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.menu_book,
          size: 64,
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withOpacity(0.3),
        ),
      ),
    );
  }
}
