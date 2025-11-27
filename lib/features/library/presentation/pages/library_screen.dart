import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../di/library_dependencies.dart';
import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import '../widgets/library_app_bar.dart';
import '../widgets/shelves_sidebar.dart';
import '../widgets/books_grid.dart';
import '../widgets/library_header.dart';
import '../widgets/book_properties_dialog.dart';

enum FocusArea { shelves, books }

/// Main library screen with sidebar and books grid
class LibraryScreen extends StatelessWidget {
  final String directoryPath;

  const LibraryScreen({
    super.key,
    required this.directoryPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LibraryDependencies().createLibraryBloc()
        ..add(InitializeLibrary(directoryPath)),
      child: const _LibraryScreenContent(),
    );
  }
}

class _LibraryScreenContent extends StatefulWidget {
  const _LibraryScreenContent();

  @override
  State<_LibraryScreenContent> createState() => _LibraryScreenContentState();
}

class _LibraryScreenContentState extends State<_LibraryScreenContent> {
  static const String _sidebarWidthKey = 'sidebar_width';
  static const double _minSidebarWidth = 200.0;
  static const double _maxSidebarWidth = 500.0;
  static const double _defaultSidebarWidth = 250.0;

  double _sidebarWidth = _defaultSidebarWidth;
  bool _isResizing = false;
  FocusArea _currentFocus = FocusArea.shelves;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSidebarWidth();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadSidebarWidth() async {
    final prefs = await SharedPreferences.getInstance();
    final savedWidth = prefs.getDouble(_sidebarWidthKey);
    if (savedWidth != null && mounted) {
      setState(() {
        _sidebarWidth = savedWidth.clamp(_minSidebarWidth, _maxSidebarWidth);
      });
    }
  }

  Future<void> _saveSidebarWidth(double width) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_sidebarWidthKey, width);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _sidebarWidth = (_sidebarWidth + details.delta.dx).clamp(_minSidebarWidth, _maxSidebarWidth);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      _isResizing = false;
    });
    _saveSidebarWidth(_sidebarWidth);
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      _isResizing = true;
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final bloc = context.read<LibraryBloc>();
    final state = bloc.state;
    if (state is! LibraryLoaded) return KeyEventResult.ignored;

    final isCtrlPressed = HardwareKeyboard.instance.isControlPressed;

    // Handle Ctrl+N for creating new shelf (works regardless of focus)
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyN) {
      _showCreateShelfDialog(context, bloc);
      return KeyEventResult.handled;
    }

    // Handle Ctrl+O for opening books (works regardless of focus)
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyO) {
      bloc.add(const OpenAllBooks());
      return KeyEventResult.handled;
    }

    // Handle Ctrl+S for selecting all books (works regardless of focus)
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyS) {
      bloc.add(const SelectAllBooks());
      return KeyEventResult.handled;
    }

    // Handle Ctrl+D for clearing selection (works regardless of focus)
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyD) {
      bloc.add(const ClearBookSelection());
      return KeyEventResult.handled;
    }

    // Handle Ctrl+E for edit/properties
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyE) {
      if (_currentFocus == FocusArea.shelves) {
        // Edit shelf name
        _showEditShelfDialog(context, bloc, state.selectedShelf);
      } else {
        // Show book properties if exactly one book is selected
        if (state.selectedBookIds.length == 1) {
          final bookId = state.selectedBookIds.first;
          final book = state.config.books.firstWhere((b) => b.id == bookId);
          showDialog(
            context: context,
            builder: (dialogContext) => BlocProvider.value(
              value: bloc,
              child: BookPropertiesDialog(book: book),
            ),
          );
        }
      }
      return KeyEventResult.handled;
    }

    // Handle focus switching with Left/Right arrows or H/L (only without Ctrl)
    if (!isCtrlPressed) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft || event.logicalKey == LogicalKeyboardKey.keyH) {
        setState(() => _currentFocus = FocusArea.shelves);
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowRight || event.logicalKey == LogicalKeyboardKey.keyL) {
        setState(() => _currentFocus = FocusArea.books);
        return KeyEventResult.handled;
      }
    }

    if (_currentFocus == FocusArea.shelves) {
      return _handleShelvesKeyEvent(event, bloc, state, isCtrlPressed);
    } else {
      return _handleBooksKeyEvent(event, bloc, state);
    }
  }

  KeyEventResult _handleShelvesKeyEvent(KeyEvent event, LibraryBloc bloc, LibraryLoaded state, bool isCtrlPressed) {
    final shelves = state.config.shelves;
    final currentIndex = shelves.indexWhere((s) => s.id == state.selectedShelf.id);
    if (currentIndex == -1) return KeyEventResult.ignored;

    // Navigation (Up/Down or K/J)
    if (event.logicalKey == LogicalKeyboardKey.arrowUp || event.logicalKey == LogicalKeyboardKey.keyK) {
      if (isCtrlPressed) {
        // Move shelf up (must be at least at index 3, and move to at least index 2)
        // This ensures "All" (0) and "Unsorted" (1) stay in place
        if (currentIndex >= 3) {
          final newIndex = currentIndex - 1;
          if (newIndex >= 2) {
            bloc.add(ReorderShelves(oldIndex: currentIndex, newIndex: newIndex));
          }
        }
      } else if (currentIndex > 0) {
        // Navigate up
        bloc.add(SelectShelf(shelves[currentIndex - 1].id));
      }
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown || event.logicalKey == LogicalKeyboardKey.keyJ) {
      if (isCtrlPressed) {
        // Move shelf down (must be at least at index 2, and not be the last shelf)
        if (currentIndex >= 2) {
          final newIndex = currentIndex + 1;
          if (newIndex < shelves.length) {
            bloc.add(ReorderShelves(oldIndex: currentIndex, newIndex: newIndex));
          }
        }
      } else if (currentIndex < shelves.length - 1) {
        // Navigate down
        bloc.add(SelectShelf(shelves[currentIndex + 1].id));
      }
      return KeyEventResult.handled;
    }

    // Delete shelf
    if (event.logicalKey == LogicalKeyboardKey.delete) {
      final shelf = state.selectedShelf;
      if (!shelf.isDefault) {
        bloc.add(DeleteShelf(shelf.id));
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  KeyEventResult _handleBooksKeyEvent(KeyEvent event, LibraryBloc bloc, LibraryLoaded state) {
    // Delete book from shelf
    if (event.logicalKey == LogicalKeyboardKey.delete) {
      final isDefaultShelf = state.selectedShelf.isDefault;
      if (!isDefaultShelf && state.hasSelection && state.selectedBookIds.isNotEmpty) {
        bloc.add(const DeleteSelectedBooks());
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _showCreateShelfDialog(BuildContext context, LibraryBloc bloc) {
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
              bloc.add(CreateShelf(value.trim()));
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
                bloc.add(CreateShelf(name));
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(l10n.create),
          ),
        ],
      ),
    );
  }

  void _showEditShelfDialog(BuildContext context, LibraryBloc bloc, Shelf shelf) {
    final l10n = AppLocalizations.of(context)!;

    // Don't allow editing default shelves
    if (shelf.isDefault) return;

    final controller = TextEditingController(text: shelf.name);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.editShelf),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.shelfName,
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty && value.trim() != shelf.name) {
              bloc.add(RenameShelf(shelfId: shelf.id, newName: value.trim()));
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
              if (name.isNotEmpty && name != shelf.name) {
                bloc.add(RenameShelf(shelfId: shelf.id, newName: name));
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        appBar: const LibraryAppBar(),
        body: BlocBuilder<LibraryBloc, LibraryState>(
          builder: (context, state) {
          if (state is LibraryLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    l10n.initializingLibrary,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          if (state is LibraryInitializing) {
            final progress = state.currentBook / state.totalBooks;
            return Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.initializingLibrary,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 32),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${state.currentBook} / ${state.totalBooks}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is LibraryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
                    child: Text(l10n.backToWelcome),
                  ),
                ],
              ),
            );
          }

          if (state is LibraryLoaded) {
            return Row(
              children: [
                // Left sidebar with shelves
                SizedBox(
                  width: _sidebarWidth,
                  child: ShelfsSidebar(
                    shelves: state.config.shelves,
                    selectedShelfId: state.selectedShelf.id,
                    totalBooksCount: state.config.books.length,
                    allBooks: state.config.books,
                    isFocused: _currentFocus == FocusArea.shelves,
                  ),
                ),
                // Resize handle
                MouseRegion(
                  cursor: SystemMouseCursors.resizeColumn,
                  child: GestureDetector(
                    onHorizontalDragStart: _onHorizontalDragStart,
                    onHorizontalDragUpdate: _onHorizontalDragUpdate,
                    onHorizontalDragEnd: _onHorizontalDragEnd,
                    child: Container(
                      width: 8,
                      color: _isResizing
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                          : Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // Main content area
                Expanded(
                  child: Column(
                    children: [
                      // Header with action buttons
                      LibraryHeader(
                        selectedShelf: state.selectedShelf,
                        bookCount: state.displayedBooks.length,
                        isFocused: _currentFocus == FocusArea.books,
                      ),
                      Container(
                        height: 3,
                        color: _currentFocus == FocusArea.books
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).dividerColor,
                      ),
                      // Books grid
                      Expanded(
                        child: BooksGrid(
                          books: state.displayedBooks,
                          shelves: state.config.shelves,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      ),
    );
  }
}
