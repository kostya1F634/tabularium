import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/app_settings.dart';
import '../../../../core/services/ui_settings_provider.dart';
import '../../../../core/services/ai_settings_provider.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../../../core/widgets/dialog_shortcuts_wrapper.dart';
import '../../../../core/widgets/ai_progress_dialog.dart';
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
import '../widgets/add_to_shelf_dialog.dart';
import 'library_view_wrapper.dart';

enum FocusArea { shelves, books }

/// Main library screen with sidebar and books grid
class LibraryScreen extends StatelessWidget {
  final String directoryPath;

  const LibraryScreen({super.key, required this.directoryPath});

  @override
  Widget build(BuildContext context) {
    final aiSettings = AISettingsProvider.of(context);

    return BlocProvider(
      create: (_) =>
          LibraryDependencies(aiSettingsService: aiSettings).createLibraryBloc()
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
  double _booksAreaWidth = 800.0; // Will be updated via LayoutBuilder
  String? Function()? _getCenterVisibleBookId;
  void Function()? _requestSearchFocus; // Callback to focus books search field
  bool Function()?
  _isSearchFocused; // Callback to check if books search has focus
  void Function()?
  _requestShelfSearchFocus; // Callback to focus shelf search field
  bool Function()?
  _isShelfSearchFocused; // Callback to check if shelf search has focus
  List<Shelf> _filteredShelves = []; // Shelves after applying search filter
  bool _hasRestoredFocus = false; // Track if focus was restored from config
  bool _isAIDialogShown = false; // Track if AI progress dialog is shown

  @override
  void initState() {
    super.initState();
    _loadSidebarWidth();
    // Focus will be requested when library loads (in BlocListener)

    // Listen to UI settings changes and restore focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uiSettings = UISettingsProvider.of(context);
      uiSettings.addListener(_onUISettingsChanged);
    });
  }

  @override
  void dispose() {
    // Remove listener if it was added
    try {
      final uiSettings = UISettingsProvider.of(context);
      uiSettings.removeListener(_onUISettingsChanged);
    } catch (_) {
      // Context might not be available
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _onUISettingsChanged() {
    print('[DEBUG] UI settings changed, will restore focus');
    // When UI settings change (like bookScale), restore focus after rebuild
    // Use double postFrameCallback to ensure widgets are fully rebuilt
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          print(
            '[DEBUG] Before requestFocus: hasFocus=${_focusNode.hasFocus}, canRequestFocus=${_focusNode.canRequestFocus}',
          );
          // Unfocus any other widgets first
          FocusScope.of(context).unfocus();
          // Then request focus for our FocusNode using FocusScope
          Future.delayed(const Duration(milliseconds: 50), () {
            if (mounted) {
              FocusScope.of(context).requestFocus(_focusNode);
              print(
                '[DEBUG] After requestFocus: hasFocus=${_focusNode.hasFocus}',
              );
            }
          });
        } else {
          print('[DEBUG] Widget disposed, cannot restore focus');
        }
      });
    });
  }

  Future<void> _loadSidebarWidth() async {
    final prefs = await AppSettings.getInstance();
    final savedWidth = prefs.getDouble(_sidebarWidthKey);
    if (savedWidth != null && mounted) {
      setState(() {
        _sidebarWidth = savedWidth.clamp(_minSidebarWidth, _maxSidebarWidth);
      });
    }
  }

  Future<void> _saveSidebarWidth(double width) async {
    final prefs = await AppSettings.getInstance();
    await prefs.setDouble(_sidebarWidthKey, width);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _sidebarWidth = (_sidebarWidth + details.delta.dx).clamp(
        _minSidebarWidth,
        _maxSidebarWidth,
      );
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

    // Handle Ctrl+W to toggle between library and welcome screen
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyW) {
      _toggleWelcomeScreen(context, state.config.directoryPath);
      return KeyEventResult.handled;
    }

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

    // Handle Ctrl+1 to Ctrl+0 for quick shelf selection (first 10 shelves)
    final digitKeys = [
      LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.digit2,
      LogicalKeyboardKey.digit3,
      LogicalKeyboardKey.digit4,
      LogicalKeyboardKey.digit5,
      LogicalKeyboardKey.digit6,
      LogicalKeyboardKey.digit7,
      LogicalKeyboardKey.digit8,
      LogicalKeyboardKey.digit9,
      LogicalKeyboardKey.digit0,
    ];

    if (isCtrlPressed) {
      for (int i = 0; i < digitKeys.length; i++) {
        if (event.logicalKey == digitKeys[i]) {
          final shelfIndex = i == 9 ? 9 : i; // Ctrl+0 maps to index 9
          if (shelfIndex < _filteredShelves.length) {
            final shelf = _filteredShelves[shelfIndex];
            bloc.add(SelectShelf(shelf.id));
          }
          return KeyEventResult.handled;
        }
      }
    }

    // Handle Ctrl+E for edit/properties
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyE) {
      if (_currentFocus == FocusArea.shelves) {
        // Edit shelf name
        _showEditShelfDialog(context, bloc, state.selectedShelf);
      } else {
        // Show book properties for focused book (or first selected if has selection)
        String? bookId;
        if (state.hasSelection) {
          bookId = state.selectedBookIds.first;
        } else if (state.focusedBookId != null) {
          bookId = state.focusedBookId;
        }

        if (bookId != null) {
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

    // Handle Ctrl+T for toggling view mode
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyT) {
      // Toggle view mode
      final provider = context
          .findAncestorWidgetOfExactType<ViewModeProviderWidget>();
      provider?.onToggle();
      return KeyEventResult.handled;
    }

    // Handle Ctrl+A for Add to shelf
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyA) {
      // Show add to shelf dialog for selected books, focused book, or all books
      if (state.displayedBooks.isNotEmpty) {
        final hadSelection = state.hasSelection;
        final Set<String> booksToAdd;
        if (hadSelection) {
          booksToAdd = state.selectedBookIds;
          print(
            'DEBUG: Adding ${booksToAdd.length} selected books: $booksToAdd',
          );
        } else if (state.focusedBookId != null) {
          booksToAdd = {state.focusedBookId!};
          print('DEBUG: Adding focused book: $booksToAdd');
        } else {
          booksToAdd = state.displayedBooks.map((b) => b.id).toSet();
          print('DEBUG: Adding all ${booksToAdd.length} books');
        }

        showDialog<String>(
          context: context,
          builder: (context) => AddToShelfDialog(shelves: state.config.shelves),
        ).then((result) {
          if (result != null && context.mounted) {
            print('DEBUG: Dialog result: $result');
            if (result.startsWith('create:')) {
              final shelfName = result.substring(7);
              print('DEBUG: Creating new shelf: $shelfName');
              bloc.add(CreateShelf(shelfName));
              Future.delayed(const Duration(milliseconds: 100), () {
                final updatedState = bloc.state;
                if (updatedState is LibraryLoaded) {
                  final newShelf = updatedState.config.shelves.lastWhere(
                    (shelf) => shelf.name == shelfName && !shelf.isDefault,
                  );
                  print(
                    'DEBUG: New shelf ID: ${newShelf.id}, adding ${booksToAdd.length} books',
                  );
                  bloc.add(
                    AddBooksToShelf(
                      bookIds: booksToAdd.toList(),
                      shelfId: newShelf.id,
                    ),
                  );
                  print('DEBUG library_screen: hadSelection=$hadSelection');
                  if (hadSelection) {
                    // Wait for AddBooksToShelf to complete
                    Future.delayed(const Duration(milliseconds: 50), () {
                      print(
                        'DEBUG library_screen: Clearing selection after add',
                      );
                      bloc.add(const ClearBookSelection());
                    });
                  } else {
                    print(
                      'DEBUG library_screen: NOT clearing - hadSelection was false',
                    );
                  }
                }
              });
            } else {
              print(
                'DEBUG: Adding ${booksToAdd.length} books to shelf: $result',
              );
              bloc.add(
                AddBooksToShelf(bookIds: booksToAdd.toList(), shelfId: result),
              );
              print(
                'DEBUG library_screen (existing shelf): hadSelection=$hadSelection',
              );
              if (hadSelection) {
                // Wait for AddBooksToShelf to complete
                Future.delayed(const Duration(milliseconds: 50), () {
                  print('DEBUG library_screen: Clearing selection after add');
                  bloc.add(const ClearBookSelection());
                });
              } else {
                print(
                  'DEBUG library_screen: NOT clearing - hadSelection was false',
                );
              }
            }
          }
        });
      }
      return KeyEventResult.handled;
    }

    // Handle Ctrl+F to focus on center visible book
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyF) {
      if (state.displayedBooks.isNotEmpty) {
        setState(() => _currentFocus = FocusArea.books);

        // Get center visible book from BooksGrid
        final centerBookId = _getCenterVisibleBookId?.call();
        if (centerBookId != null) {
          bloc.add(MoveFocusToBook(centerBookId));
        } else {
          // Fallback to middle of collection if grid not ready
          final centerIndex = (state.displayedBooks.length / 2).floor();
          bloc.add(MoveFocusToBook(state.displayedBooks[centerIndex].id));
        }
      }
      return KeyEventResult.handled;
    }

    // Handle Ctrl+U to jump to first shelf/book
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyU) {
      if (_currentFocus == FocusArea.shelves) {
        // Jump to first shelf
        if (state.config.shelves.isNotEmpty) {
          bloc.add(SelectShelf(state.config.shelves.first.id));
        }
      } else {
        // Jump to first book
        if (state.displayedBooks.isNotEmpty) {
          bloc.add(MoveFocusToBook(state.displayedBooks.first.id));
        }
      }
      return KeyEventResult.handled;
    }

    // Handle Ctrl+I to jump to last shelf/book
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyI) {
      if (_currentFocus == FocusArea.shelves) {
        // Jump to last shelf
        if (state.config.shelves.isNotEmpty) {
          bloc.add(SelectShelf(state.config.shelves.last.id));
        }
      } else {
        // Jump to last book
        if (state.displayedBooks.isNotEmpty) {
          bloc.add(MoveFocusToBook(state.displayedBooks.last.id));
        }
      }
      return KeyEventResult.handled;
    }

    // Handle / or . to focus on search or return from search
    if (event.logicalKey == LogicalKeyboardKey.slash ||
        event.logicalKey == LogicalKeyboardKey.period) {
      if (_currentFocus == FocusArea.shelves) {
        // In shelves area: focus shelf search
        final shelfSearchHasFocus = _isShelfSearchFocused?.call() ?? false;

        if (shelfSearchHasFocus) {
          // Shelf search already focused: unfocus and return to shelves
          FocusScope.of(context).unfocus();
          _focusNode.requestFocus();
        } else {
          // Focus shelf search field
          _requestShelfSearchFocus?.call();
        }
        return KeyEventResult.handled;
      } else if (_currentFocus == FocusArea.books) {
        // In books area: focus books search
        final searchHasFocus = _isSearchFocused?.call() ?? false;

        if (searchHasFocus) {
          // Books search already focused: unfocus and return to books
          FocusScope.of(context).unfocus();
          _focusNode.requestFocus();
        } else {
          // Focus books search field
          _requestSearchFocus?.call();
        }
        return KeyEventResult.handled;
      }

      return KeyEventResult.ignored;
    }

    // Handle focus switching with Tab
    if (event.logicalKey == LogicalKeyboardKey.tab) {
      // Don't handle Tab if any search field has focus
      final searchHasFocus = _isSearchFocused?.call() ?? false;
      final shelfSearchHasFocus = _isShelfSearchFocused?.call() ?? false;
      if (searchHasFocus || shelfSearchHasFocus) {
        return KeyEventResult.ignored;
      }

      if (_currentFocus == FocusArea.shelves) {
        if (state.displayedBooks.isEmpty) {
          // No books to focus on
          return KeyEventResult.handled;
        }

        // Determine which book to focus
        String bookIdToFocus;
        final focusedBookExists =
            state.focusedBookId != null &&
            state.displayedBooks.any((b) => b.id == state.focusedBookId);

        if (focusedBookExists) {
          // Re-focus the same book to trigger scroll and visual update
          bookIdToFocus = state.focusedBookId!;
        } else {
          // Focus first book if current focused book doesn't exist
          bookIdToFocus = state.displayedBooks.first.id;
        }

        // Always trigger MoveFocusToBook to ensure visual focus appears
        bloc.add(MoveFocusToBook(bookIdToFocus));

        // Switch focus area
        setState(() => _currentFocus = FocusArea.books);
        bloc.add(const SaveFocusArea('books'));
      } else {
        setState(() => _currentFocus = FocusArea.shelves);
        bloc.add(const SaveFocusArea('shelves'));
      }
      return KeyEventResult.handled;
    }

    if (_currentFocus == FocusArea.shelves) {
      return _handleShelvesKeyEvent(event, bloc, state, isCtrlPressed);
    } else {
      return _handleBooksKeyEvent(event, bloc, state);
    }
  }

  KeyEventResult _handleShelvesKeyEvent(
    KeyEvent event,
    LibraryBloc bloc,
    LibraryLoaded state,
    bool isCtrlPressed,
  ) {
    // Use filtered shelves for navigation (respects search)
    final shelves = _filteredShelves.isNotEmpty
        ? _filteredShelves
        : state.config.shelves;
    final currentIndex = shelves.indexWhere(
      (s) => s.id == state.selectedShelf.id,
    );
    if (currentIndex == -1) return KeyEventResult.ignored;

    // Navigation (Up/Down or K/J)
    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.keyK) {
      if (isCtrlPressed) {
        // Move shelf up (must be at least at index 3, and move to at least index 2)
        // This ensures "All" (0) and "Unsorted" (1) stay in place
        if (currentIndex >= 3) {
          final newIndex = currentIndex - 1;
          if (newIndex >= 2) {
            bloc.add(
              ReorderShelves(oldIndex: currentIndex, newIndex: newIndex),
            );
            // Scrolling will happen automatically in ShelfsSidebar.didUpdateWidget
          }
        }
      } else if (currentIndex > 0) {
        // Navigate up
        bloc.add(SelectShelf(shelves[currentIndex - 1].id));
      }
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.keyJ) {
      if (isCtrlPressed) {
        // Move shelf down (must be at least at index 2, and not be the last shelf)
        if (currentIndex >= 2) {
          final newIndex = currentIndex + 1;
          if (newIndex < shelves.length) {
            bloc.add(
              ReorderShelves(oldIndex: currentIndex, newIndex: newIndex),
            );
            // Scrolling will happen automatically in ShelfsSidebar.didUpdateWidget
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

  int _calculateColumnsCount(double bookScale) {
    // Calculate columns based on grid parameters from BooksGrid
    // This mimics SliverGridDelegateWithMaxCrossAxisExtent logic
    final maxCrossAxisExtent = 200 * bookScale;
    final crossAxisSpacing = 16.0;
    final padding = 32.0; // 16 on each side
    final availableWidth = _booksAreaWidth - padding;

    // Flutter's actual logic from SliverGridDelegateWithMaxCrossAxisExtent:
    // crossAxisCount = (crossAxisExtent / (maxCrossAxisExtent + crossAxisSpacing)).ceil()
    // Source: https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/rendering/sliver_grid.dart
    final columns = (availableWidth / (maxCrossAxisExtent + crossAxisSpacing))
        .ceil();

    return columns.clamp(1, 100);
  }

  KeyEventResult _handleBooksKeyEvent(
    KeyEvent event,
    LibraryBloc bloc,
    LibraryLoaded state,
  ) {
    final uiSettings = UISettingsProvider.of(context);
    final columnsCount = _calculateColumnsCount(uiSettings.bookScale);

    // Navigation with hjkl or arrows
    if (event.logicalKey == LogicalKeyboardKey.keyH ||
        event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      bloc.add(
        MoveFocusInDirection(FocusDirection.left, columnsCount: columnsCount),
      );
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyJ ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      bloc.add(
        MoveFocusInDirection(FocusDirection.down, columnsCount: columnsCount),
      );
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyK ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      bloc.add(
        MoveFocusInDirection(FocusDirection.up, columnsCount: columnsCount),
      );
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyL ||
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      bloc.add(
        MoveFocusInDirection(FocusDirection.right, columnsCount: columnsCount),
      );
      return KeyEventResult.handled;
    }

    // Enter to open focused book
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (state.focusedBookId != null) {
        final focusedBook = state.displayedBooks.firstWhere(
          (book) => book.id == state.focusedBookId,
          orElse: () => state.displayedBooks.first,
        );
        bloc.add(OpenBook(focusedBook));
      }
      return KeyEventResult.handled;
    }

    // Space to toggle selection of focused book
    if (event.logicalKey == LogicalKeyboardKey.space) {
      bloc.add(const ToggleFocusedBookSelection());
      return KeyEventResult.handled;
    }

    // Delete book from shelf
    if (event.logicalKey == LogicalKeyboardKey.delete) {
      final isDefaultShelf = state.selectedShelf.isDefault;
      if (!isDefaultShelf &&
          state.hasSelection &&
          state.selectedBookIds.isNotEmpty) {
        bloc.add(const DeleteSelectedBooks());
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _toggleWelcomeScreen(
    BuildContext context,
    String currentDirectoryPath,
  ) async {
    // Save current directory to temp storage so we can return to it with Ctrl+W
    final prefs = await AppSettings.getInstance();
    await prefs.setString('temp_previous_directory', currentDirectoryPath);
    // Clear last opened directory so app starts on welcome screen on next launch
    await prefs.remove('last_opened_directory');
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  void _showCreateShelfDialog(BuildContext context, LibraryBloc bloc) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    void createShelf() {
      final name = controller.text.trim();
      if (name.isNotEmpty) {
        bloc.add(CreateShelf(name));
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

  void _showEditShelfDialog(
    BuildContext context,
    LibraryBloc bloc,
    Shelf shelf,
  ) {
    final l10n = AppLocalizations.of(context)!;

    // Don't allow editing default shelves
    if (shelf.isDefault) return;

    final controller = TextEditingController(text: shelf.name);

    void saveShelf() {
      final name = controller.text.trim();
      if (name.isNotEmpty && name != shelf.name) {
        bloc.add(RenameShelf(shelfId: shelf.id, newName: name));
        Navigator.of(context).pop();
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) => DialogShortcutsWrapper(
        onEnterKey: saveShelf,
        dialog: AlertDialog(
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
                saveShelf();
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(onPressed: saveShelf, child: Text(l10n.save)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        appBar: const LibraryAppBar(),
        body: BlocListener<LibraryBloc, LibraryState>(
          listener: (context, state) {
            // Show/hide AI progress dialog
            if (state is LibraryAIProcessing) {
              if (!_isAIDialogShown) {
                _isAIDialogShown = true;
                final bloc = context.read<LibraryBloc>();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => BlocProvider.value(
                    value: bloc,
                    child: const AIProgressDialog(),
                  ),
                );
              }
            } else if (_isAIDialogShown) {
              _isAIDialogShown = false;
              Navigator.of(context, rootNavigator: true).pop();
            }

            // Restore focus area when library loads (only once)
            if (state is LibraryLoaded && !_hasRestoredFocus) {
              _hasRestoredFocus = true;
              final lastFocusArea = state.config.lastFocusArea;
              if (lastFocusArea == 'books' && state.displayedBooks.isNotEmpty) {
                setState(() => _currentFocus = FocusArea.books);
              } else if (lastFocusArea == 'shelves' || lastFocusArea == null) {
                setState(() => _currentFocus = FocusArea.shelves);
              }

              // Request focus after library is loaded and widgets are built
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && !_focusNode.hasFocus) {
                  _focusNode.requestFocus();
                }
              });
            }
          },
          child: BlocBuilder<LibraryBloc, LibraryState>(
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
                        LinearProgressIndicator(value: progress, minHeight: 8),
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
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            // Clear last opened directory so app starts on welcome screen next time
                            final prefs = await AppSettings.getInstance();
                            await prefs.remove('last_opened_directory');
                            if (context.mounted) {
                              Navigator.of(context).pushReplacementNamed('/');
                            }
                          },
                          child: Text(l10n.backToWelcome),
                        ),
                      ],
                    ),
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
                        onFilteredShelvesChanged: (filtered) {
                          setState(() {
                            _filteredShelves = filtered;
                          });
                        },
                        onRegisterShelfSearchFocusCallback: (callback) {
                          _requestShelfSearchFocus = callback;
                        },
                        onRegisterCheckShelfSearchFocusCallback: (callback) {
                          _isShelfSearchFocused = callback;
                        },
                        onRequestFocus: () {
                          if (mounted) {
                            _focusNode.requestFocus();
                          }
                        },
                        onSwitchToShelvesArea: () {
                          if (mounted && _currentFocus != FocusArea.shelves) {
                            setState(() => _currentFocus = FocusArea.shelves);
                            context.read<LibraryBloc>().add(
                              const SaveFocusArea('shelves'),
                            );
                          }
                        },
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
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.2)
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
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Update books area width for column calculation
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_booksAreaWidth != constraints.maxWidth) {
                              setState(() {
                                _booksAreaWidth = constraints.maxWidth;
                              });
                            }
                          });

                          return Column(
                            children: [
                              // Header with action buttons
                              LibraryHeader(
                                selectedShelf: state.selectedShelf,
                                bookCount: state.displayedBooks.length,
                                isFocused: _currentFocus == FocusArea.books,
                                onRegisterFocusCallback: (callback) {
                                  _requestSearchFocus = callback;
                                },
                                onRegisterCheckFocusCallback: (callback) {
                                  _isSearchFocused = callback;
                                },
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
                                  focusedBookId: state.focusedBookId,
                                  showFocus: _currentFocus == FocusArea.books,
                                  onRegisterCenterBookCallback: (callback) {
                                    _getCenterVisibleBookId = callback;
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
