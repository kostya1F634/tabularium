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
class BooksGrid extends StatefulWidget {
  final List<Book> books;
  final List<Shelf> shelves;
  final String? focusedBookId;
  final void Function(String? Function())? onRegisterCenterBookCallback;

  const BooksGrid({
    super.key,
    required this.books,
    required this.shelves,
    this.focusedBookId,
    this.onRegisterCenterBookCallback,
  });

  @override
  State<BooksGrid> createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {
  final Map<String, GlobalKey> _bookKeys = {};
  final ScrollController _scrollController = ScrollController();
  String? _lastScrolledBookId;

  @override
  void initState() {
    super.initState();
    // Register callback for getting center visible book
    widget.onRegisterCenterBookCallback?.call(getCenterVisibleBookId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BooksGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Scroll to focused book when focus changes or when initially set
    if (widget.focusedBookId != null &&
        widget.focusedBookId != _lastScrolledBookId) {
      _lastScrolledBookId = widget.focusedBookId;
      // Schedule scroll with multiple attempts to ensure widget is rendered
      _scrollToFocusedBookWithRetry();
    }
  }

  void _scrollToFocusedBookWithRetry({int attempt = 0}) {
    if (!mounted || widget.focusedBookId == null) return;

    final bookIndex = widget.books.indexWhere(
      (b) => b.id == widget.focusedBookId,
    );
    if (bookIndex == -1) return;

    // Try using ensureVisible with key first
    final key = _bookKeys[widget.focusedBookId];
    if (key?.currentContext != null) {
      try {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          alignment: 0.5,
          alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
        );
        return;
      } catch (e) {
        // Key exists but context not ready
      }
    }

    // Fallback: calculate position by finding actual rendered book positions
    // This is more reliable than calculating from grid parameters
    if (_scrollController.hasClients && attempt < 5) {
      // Try to find any rendered book to get actual row height
      double? actualRowHeight;
      int? actualColumns;

      // Sample a few rendered books to determine actual layout
      for (int i = 0; i < widget.books.length && i < 20; i++) {
        final key = _bookKeys[widget.books[i].id];
        final bookContext = key?.currentContext;
        if (bookContext != null) {
          try {
            final bookRenderBox = bookContext.findRenderObject() as RenderBox?;
            if (bookRenderBox != null && actualRowHeight == null) {
              actualRowHeight =
                  bookRenderBox.size.height + 16.0; // height + mainAxisSpacing
              break;
            }
          } catch (e) {
            continue;
          }
        }
      }

      // Get columns from viewport width
      final uiSettings = UISettingsProvider.of(context);
      final bookScale = uiSettings.bookScale;
      final maxCrossAxisExtent = 200 * bookScale;
      final renderBox = context.findRenderObject() as RenderBox?;
      final viewportWidth = renderBox?.size.width ?? 800.0;
      final padding = 16.0;
      final availableWidth = viewportWidth - (padding * 2);
      actualColumns = (availableWidth / maxCrossAxisExtent).ceil().clamp(
        1,
        100,
      );

      if (actualRowHeight != null && actualColumns != null) {
        final row = bookIndex ~/ actualColumns;

        // Calculate position based on actual measured row height
        final rowTopOffset = padding + (row * actualRowHeight);
        final itemHeight =
            actualRowHeight - 16.0; // Remove spacing to get pure item height
        final bookCenterOffset = rowTopOffset + (itemHeight / 2);

        final viewportHeight = _scrollController.position.viewportDimension;
        final targetOffset = (bookCenterOffset - (viewportHeight / 2)).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );

        try {
          _scrollController.animateTo(
            targetOffset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
          return; // Success
        } catch (e) {
          // Fall through to retry
        }
      }

      // Retry if we couldn't measure actual layout yet
      Future.delayed(Duration(milliseconds: 100 * (attempt + 1)), () {
        _scrollToFocusedBookWithRetry(attempt: attempt + 1);
      });
    }
  }

  /// Get the book ID that is currently in the center of the visible area
  String? getCenterVisibleBookId() {
    if (widget.books.isEmpty || !_scrollController.hasClients) {
      return null;
    }

    try {
      // Get scroll position and viewport dimensions
      final scrollOffset = _scrollController.offset;
      final viewportHeight = _scrollController.position.viewportDimension;
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) return null;

      // Calculate viewport center in global coordinates
      final viewportCenterY = scrollOffset + (viewportHeight / 2);
      final viewportCenterX = renderBox.size.width / 2;

      // Find the book closest to the center
      String? closestBookId;
      double closestDistance = double.infinity;

      for (final book in widget.books) {
        final key = _bookKeys[book.id];
        final bookContext = key?.currentContext;
        if (bookContext == null) continue;

        try {
          final bookRenderBox = bookContext.findRenderObject() as RenderBox?;
          if (bookRenderBox == null) continue;

          // Get book position relative to the scrollable
          final bookPosition = bookRenderBox.localToGlobal(Offset.zero);
          final scrollablePosition = renderBox.localToGlobal(Offset.zero);

          final bookRelativeY =
              bookPosition.dy - scrollablePosition.dy + scrollOffset;
          final bookRelativeX = bookPosition.dx - scrollablePosition.dx;

          final bookCenterY = bookRelativeY + (bookRenderBox.size.height / 2);
          final bookCenterX = bookRelativeX + (bookRenderBox.size.width / 2);

          // Calculate distance from viewport center
          final distanceY = (bookCenterY - viewportCenterY).abs();
          final distanceX = (bookCenterX - viewportCenterX).abs();
          final distance = distanceY + distanceX; // Manhattan distance

          if (distance < closestDistance) {
            closestDistance = distance;
            closestBookId = book.id;
          }
        } catch (e) {
          continue;
        }
      }

      return closestBookId;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final uiSettings = UISettingsProvider.of(context);

    if (widget.books.isEmpty) {
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
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200 * bookScale,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: widget.books.length,
          itemBuilder: (context, index) {
            final book = widget.books[index];

            // Get or create key for this book
            if (!_bookKeys.containsKey(book.id)) {
              _bookKeys[book.id] = GlobalKey();
            }

            return Container(
              key: _bookKeys[book.id],
              child: _BookCard(
                book: book,
                shelves: widget.shelves,
                bookScale: bookScale,
                isFocused: book.id == widget.focusedBookId,
              ),
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
              ? state.selectedBookIds.toList()
              : [book.id];

          print(
            'DEBUG books_grid: hasSelection=${state.hasSelection}, booksToAdd=${booksToAdd.length}, IDs=$booksToAdd',
          );

          // Show shelf selection dialog
          final result = await showDialog<String>(
            context: context,
            builder: (context) =>
                AddToShelfDialog(shelves: state.config.shelves),
          );

          if (result != null && context.mounted) {
            print('DEBUG books_grid: Dialog result=$result');
            String shelfId;

            // Check if user wants to create a new shelf
            if (result.startsWith('create:')) {
              final shelfName = result.substring(7); // Remove 'create:' prefix
              print('DEBUG books_grid: Creating new shelf: $shelfName');

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
                print('DEBUG books_grid: New shelf ID=$shelfId');
              } else {
                print('DEBUG books_grid: State not loaded, canceling');
                return; // State is not loaded, cancel operation
              }
            } else {
              shelfId = result;
            }

            // Add books to selected or newly created shelf
            print(
              'DEBUG books_grid: Adding ${booksToAdd.length} books to shelf $shelfId',
            );
            bloc.add(AddBooksToShelf(bookIds: booksToAdd, shelfId: shelfId));

            // Clear selection after adding
            if (state.hasSelection && context.mounted) {
              print('DEBUG books_grid: Clearing selection');
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
