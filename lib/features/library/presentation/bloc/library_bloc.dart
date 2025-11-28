import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../../domain/entities/book.dart';
import '../../domain/entities/shelf.dart';
import '../../domain/entities/library_config.dart';
import '../../domain/usecases/initialize_library_usecase.dart';
import '../../domain/usecases/load_library_usecase.dart';
import '../../domain/usecases/save_library_usecase.dart';
import '../../domain/usecases/open_book_usecase.dart';
import '../../domain/usecases/open_all_books_usecase.dart';
import 'library_event.dart';
import 'library_state.dart';

/// BLoC for managing library state
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final InitializeLibraryUseCase _initializeLibrary;
  final LoadLibraryUseCase _loadLibrary;
  final SaveLibraryUseCase _saveLibrary;
  final OpenBookUseCase _openBook;
  final OpenAllBooksUseCase _openAllBooks;

  LibraryBloc({
    required InitializeLibraryUseCase initializeLibrary,
    required LoadLibraryUseCase loadLibrary,
    required SaveLibraryUseCase saveLibrary,
    required OpenBookUseCase openBook,
    required OpenAllBooksUseCase openAllBooks,
  }) : _initializeLibrary = initializeLibrary,
       _loadLibrary = loadLibrary,
       _saveLibrary = saveLibrary,
       _openBook = openBook,
       _openAllBooks = openAllBooks,
       super(const LibraryInitial()) {
    on<InitializeLibrary>(_onInitializeLibrary);
    on<LoadLibrary>(_onLoadLibrary);
    on<SelectShelf>(_onSelectShelf);
    on<CreateShelf>(_onCreateShelf);
    on<DeleteShelf>(_onDeleteShelf);
    on<RenameShelf>(_onRenameShelf);
    on<AddBookToShelf>(_onAddBookToShelf);
    on<RemoveBookFromShelf>(_onRemoveBookFromShelf);
    on<SearchBooks>(_onSearchBooks);
    on<ClearSearch>(_onClearSearch);
    on<OpenBook>(_onOpenBook);
    on<OpenAllBooks>(_onOpenAllBooks);
    on<ScanForNewBooks>(_onScanForNewBooks);
    on<ToggleBookSelection>(_onToggleBookSelection);
    on<SelectAllBooks>(_onSelectAllBooks);
    on<ClearBookSelection>(_onClearBookSelection);
    on<MoveBooksToShelf>(_onMoveBooksToShelf);
    on<DeleteSelectedBooks>(_onDeleteSelectedBooks);
    on<UpdateBookAlias>(_onUpdateBookAlias);
    on<DeleteBookFromShelf>(_onDeleteBookFromShelf);
    on<ReorderShelves>(_onReorderShelves);
  }

  Future<void> _onInitializeLibrary(
    InitializeLibrary event,
    Emitter<LibraryState> emit,
  ) async {
    try {
      emit(const LibraryLoading());

      final config = await _initializeLibrary(
        event.directoryPath,
        onProgress: (current, total) {
          emit(LibraryInitializing(currentBook: current, totalBooks: total));
        },
      );

      // Try to load last selected shelf, fall back to "All" if not found
      final selectedShelf = config.lastSelectedShelfId != null
          ? config.getShelf(config.lastSelectedShelfId!) ?? config.allShelf
          : config.allShelf;

      final displayedBooks = _getBooksForShelf(config, selectedShelf.id);

      emit(
        LibraryLoaded(
          config: config,
          selectedShelf: selectedShelf,
          displayedBooks: displayedBooks,
        ),
      );
    } catch (e) {
      emit(LibraryError('Failed to initialize library: $e'));
    }
  }

  Future<void> _onLoadLibrary(
    LoadLibrary event,
    Emitter<LibraryState> emit,
  ) async {
    try {
      emit(const LibraryLoading());

      final config = await _loadLibrary(event.directoryPath);
      if (config == null) {
        emit(const LibraryError('Library not found'));
        return;
      }

      final allShelf = config.allShelf;
      final displayedBooks = _getBooksForShelf(config, allShelf.id);

      emit(
        LibraryLoaded(
          config: config,
          selectedShelf: allShelf,
          displayedBooks: displayedBooks,
        ),
      );
    } catch (e) {
      emit(LibraryError('Failed to load library: $e'));
    }
  }

  Future<void> _onSelectShelf(
    SelectShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final shelf = currentState.config.getShelf(event.shelfId);

    if (shelf == null) return;

    final displayedBooks = _getBooksForShelf(currentState.config, shelf.id);

    // Save last selected shelf to config
    final updatedConfig = currentState.config.copyWith(
      lastSelectedShelfId: event.shelfId,
    );
    await _saveLibrary(updatedConfig);

    emit(
      currentState.copyWith(
        config: updatedConfig,
        selectedShelf: shelf,
        displayedBooks: displayedBooks,
        clearSearch: true,
        selectedBookIds: const {}, // Clear selection when switching shelves
      ),
    );
  }

  Future<void> _onCreateShelf(
    CreateShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Generate unique ID for new shelf
    final shelfId = _generateShelfId(event.name);

    final newShelf = Shelf(
      id: shelfId,
      name: event.name,
      bookIds: const [],
      createdDate: DateTime.now(),
    );

    final updatedConfig = currentState.config.copyWith(
      shelves: [...currentState.config.shelves, newShelf],
    );

    await _saveLibrary(updatedConfig);

    emit(currentState.copyWith(config: updatedConfig));
  }

  Future<void> _onDeleteShelf(
    DeleteShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Can't delete the "All" shelf
    if (event.shelfId == Shelf.allShelfId) return;

    final updatedShelves = currentState.config.shelves
        .where((shelf) => shelf.id != event.shelfId)
        .toList();

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);

    await _saveLibrary(updatedConfig);

    // If deleted shelf was selected, select "All" shelf
    final selectedShelf = currentState.selectedShelf.id == event.shelfId
        ? updatedConfig.allShelf
        : currentState.selectedShelf;

    final displayedBooks = _getBooksForShelf(updatedConfig, selectedShelf.id);

    emit(
      currentState.copyWith(
        config: updatedConfig,
        selectedShelf: selectedShelf,
        displayedBooks: displayedBooks,
      ),
    );
  }

  Future<void> _onRenameShelf(
    RenameShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Can't rename default shelves
    final shelf = currentState.config.shelves.firstWhere(
      (s) => s.id == event.shelfId,
      orElse: () => Shelf.createAll(),
    );

    if (shelf.isDefault) return;

    final updatedShelves = currentState.config.shelves.map((s) {
      if (s.id == event.shelfId) {
        return Shelf(
          id: s.id,
          name: event.newName,
          bookIds: s.bookIds,
          isDefault: s.isDefault,
          createdDate: s.createdDate,
        );
      }
      return s;
    }).toList();

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);
    await _saveLibrary(updatedConfig);

    // Update selected shelf if it was renamed
    final selectedShelf = currentState.selectedShelf.id == event.shelfId
        ? updatedShelves.firstWhere((s) => s.id == event.shelfId)
        : currentState.selectedShelf;

    emit(
      currentState.copyWith(
        config: updatedConfig,
        selectedShelf: selectedShelf,
      ),
    );
  }

  Future<void> _onAddBookToShelf(
    AddBookToShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final shelf = currentState.config.getShelf(event.shelfId);

    if (shelf == null || shelf.id == Shelf.allShelfId) return;

    final updatedShelf = shelf.addBook(event.bookId);
    final updatedShelves = currentState.config.shelves
        .map((s) => s.id == event.shelfId ? updatedShelf : s)
        .toList();

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);

    await _saveLibrary(updatedConfig);

    final displayedBooks = _getBooksForShelf(
      updatedConfig,
      currentState.selectedShelf.id,
    );

    emit(
      currentState.copyWith(
        config: updatedConfig,
        displayedBooks: displayedBooks,
      ),
    );
  }

  Future<void> _onRemoveBookFromShelf(
    RemoveBookFromShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final shelf = currentState.config.getShelf(event.shelfId);

    if (shelf == null || shelf.id == Shelf.allShelfId) return;

    final updatedShelf = shelf.removeBook(event.bookId);
    final updatedShelves = currentState.config.shelves
        .map((s) => s.id == event.shelfId ? updatedShelf : s)
        .toList();

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);

    await _saveLibrary(updatedConfig);

    final displayedBooks = _getBooksForShelf(
      updatedConfig,
      currentState.selectedShelf.id,
    );

    emit(
      currentState.copyWith(
        config: updatedConfig,
        displayedBooks: displayedBooks,
      ),
    );
  }

  Future<void> _onSearchBooks(
    SearchBooks event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    if (event.query.isEmpty) {
      emit(
        currentState.copyWith(
          clearSearch: true,
          displayedBooks: _getBooksForShelf(
            currentState.config,
            currentState.selectedShelf.id,
          ),
        ),
      );
      return;
    }

    // Get books for current shelf
    final shelfBooks = _getBooksForShelf(
      currentState.config,
      currentState.selectedShelf.id,
    );

    // Filter books by search query
    final query = event.query.toLowerCase();
    final filteredBooks = shelfBooks.where((book) {
      return book.displayTitle.toLowerCase().contains(query) ||
          (book.author?.toLowerCase().contains(query) ?? false) ||
          book.fileName.toLowerCase().contains(query);
    }).toList();

    emit(
      currentState.copyWith(
        searchQuery: event.query,
        displayedBooks: filteredBooks,
      ),
    );
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    emit(
      currentState.copyWith(
        clearSearch: true,
        displayedBooks: _getBooksForShelf(
          currentState.config,
          currentState.selectedShelf.id,
        ),
      ),
    );
  }

  Future<void> _onOpenBook(OpenBook event, Emitter<LibraryState> emit) async {
    try {
      await _openBook(event.book);

      // Update last opened date
      if (state is LibraryLoaded) {
        final currentState = state as LibraryLoaded;
        final updatedBook = event.book.copyWith(lastOpenedDate: DateTime.now());
        final updatedBooks = currentState.config.books
            .map((b) => b.id == updatedBook.id ? updatedBook : b)
            .toList();

        final updatedConfig = currentState.config.copyWith(books: updatedBooks);
        await _saveLibrary(updatedConfig);

        final displayedBooks = _getBooksForShelf(
          updatedConfig,
          currentState.selectedShelf.id,
        );

        emit(
          currentState.copyWith(
            config: updatedConfig,
            displayedBooks: displayedBooks,
          ),
        );
      }
    } catch (e) {
      // Don't emit error for book opening failures
      print('Error opening book: $e');
    }
  }

  Future<void> _onOpenAllBooks(
    OpenAllBooks event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    try {
      // If there are selected books, open only selected ones, otherwise open all displayed
      final booksToOpen = currentState.hasSelection
          ? currentState.selectedBooks
          : currentState.displayedBooks;
      await _openAllBooks(booksToOpen);
    } catch (e) {
      print('Error opening books: $e');
    }
  }

  Future<void> _onScanForNewBooks(
    ScanForNewBooks event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    try {
      // Re-initialize library to scan for new books
      final updatedConfig = await _initializeLibrary(
        currentState.config.directoryPath,
      );

      final displayedBooks = _getBooksForShelf(
        updatedConfig,
        currentState.selectedShelf.id,
      );

      emit(
        currentState.copyWith(
          config: updatedConfig,
          displayedBooks: displayedBooks,
        ),
      );
    } catch (e) {
      print('Error scanning for new books: $e');
    }
  }

  /// Get books for a specific shelf
  List<Book> _getBooksForShelf(LibraryConfig config, String shelfId) {
    if (shelfId == Shelf.allShelfId) {
      return config.books;
    }

    if (shelfId == Shelf.unsortedShelfId) {
      // Get all book IDs that are in user shelves (not default shelves)
      final Set<String> booksInShelves = {};
      for (final shelf in config.shelves) {
        if (!shelf.isDefault) {
          booksInShelves.addAll(shelf.bookIds);
        }
      }
      // Return books that are not in any user shelf
      return config.books
          .where((book) => !booksInShelves.contains(book.id))
          .toList();
    }

    final shelf = config.getShelf(shelfId);
    if (shelf == null) return [];

    return config.books
        .where((book) => shelf.bookIds.contains(book.id))
        .toList();
  }

  /// Generate unique shelf ID
  String _generateShelfId(String name) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return md5
        .convert(utf8.encode('$name$timestamp'))
        .toString()
        .substring(0, 8);
  }

  Future<void> _onToggleBookSelection(
    ToggleBookSelection event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final newSelection = Set<String>.from(currentState.selectedBookIds);

    if (newSelection.contains(event.bookId)) {
      newSelection.remove(event.bookId);
    } else {
      newSelection.add(event.bookId);
    }

    emit(currentState.copyWith(selectedBookIds: newSelection));
  }

  Future<void> _onSelectAllBooks(
    SelectAllBooks event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final allBookIds = currentState.displayedBooks
        .map((book) => book.id)
        .toSet();

    emit(currentState.copyWith(selectedBookIds: allBookIds));
  }

  Future<void> _onClearBookSelection(
    ClearBookSelection event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    emit(currentState.copyWith(clearSelection: true));
  }

  Future<void> _onMoveBooksToShelf(
    MoveBooksToShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final isFromAllShelf = event.sourceShelfId == Shelf.allShelfId;

    // Get target shelf
    final targetShelf = currentState.config.getShelf(event.targetShelfId);
    if (targetShelf == null || targetShelf.id == Shelf.allShelfId) return;

    // Add books to target shelf (copy from All, move from custom)
    final updatedTargetShelf = event.bookIds.fold<Shelf>(
      targetShelf,
      (shelf, bookId) =>
          shelf.bookIds.contains(bookId) ? shelf : shelf.addBook(bookId),
    );

    var updatedShelves = currentState.config.shelves
        .map((s) => s.id == event.targetShelfId ? updatedTargetShelf : s)
        .toList();

    // If moving from custom shelf (not All), remove from source
    if (!isFromAllShelf) {
      updatedShelves = updatedShelves.map((shelf) {
        if (shelf.id == event.sourceShelfId) {
          return event.bookIds.fold<Shelf>(
            shelf,
            (s, bookId) => s.removeBook(bookId),
          );
        }
        return shelf;
      }).toList();
    }

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);
    await _saveLibrary(updatedConfig);

    final displayedBooks = _getBooksForShelf(
      updatedConfig,
      currentState.selectedShelf.id,
    );

    emit(
      currentState.copyWith(
        config: updatedConfig,
        displayedBooks: displayedBooks,
        clearSelection: true,
      ),
    );
  }

  Future<void> _onDeleteSelectedBooks(
    DeleteSelectedBooks event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Can't delete from "All" shelf
    if (currentState.selectedShelf.id == Shelf.allShelfId) return;

    // Remove selected books from current shelf
    final updatedShelf = currentState.selectedBookIds.fold<Shelf>(
      currentState.selectedShelf,
      (shelf, bookId) => shelf.removeBook(bookId),
    );

    final updatedShelves = currentState.config.shelves
        .map((s) => s.id == currentState.selectedShelf.id ? updatedShelf : s)
        .toList();

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);
    await _saveLibrary(updatedConfig);

    final displayedBooks = _getBooksForShelf(
      updatedConfig,
      currentState.selectedShelf.id,
    );

    emit(
      currentState.copyWith(
        config: updatedConfig,
        displayedBooks: displayedBooks,
        clearSelection: true,
      ),
    );
  }

  Future<void> _onUpdateBookAlias(
    UpdateBookAlias event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Update book with new alias
    final updatedBooks = currentState.config.books.map((book) {
      if (book.id == event.bookId) {
        return event.alias == null || event.alias!.isEmpty
            ? book.copyWith(clearAlias: true)
            : book.copyWith(alias: event.alias);
      }
      return book;
    }).toList();

    final updatedConfig = currentState.config.copyWith(books: updatedBooks);
    await _saveLibrary(updatedConfig);

    final displayedBooks = _getBooksForShelf(
      updatedConfig,
      currentState.selectedShelf.id,
    );

    emit(
      currentState.copyWith(
        config: updatedConfig,
        displayedBooks: displayedBooks,
      ),
    );
  }

  Future<void> _onDeleteBookFromShelf(
    DeleteBookFromShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Cannot delete from "All" shelf
    if (event.shelfId == Shelf.allShelfId) return;

    // Remove book from shelf
    final updatedShelves = currentState.config.shelves.map((shelf) {
      if (shelf.id == event.shelfId) {
        return shelf.removeBook(event.bookId);
      }
      return shelf;
    }).toList();

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);
    await _saveLibrary(updatedConfig);

    final displayedBooks = _getBooksForShelf(
      updatedConfig,
      currentState.selectedShelf.id,
    );

    emit(
      currentState.copyWith(
        config: updatedConfig,
        displayedBooks: displayedBooks,
      ),
    );
  }

  Future<void> _onReorderShelves(
    ReorderShelves event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final shelves = List<Shelf>.from(currentState.config.shelves);

    int oldIndex = event.oldIndex;
    int newIndex = event.newIndex;

    // Only adjust indices if this came from drag-and-drop
    // ReorderableListView provides adjusted indices, but keyboard doesn't
    if (event.fromDrag && newIndex > oldIndex) {
      newIndex -= 1;
    }

    if (oldIndex == newIndex) {
      return;
    }

    // Remove the shelf from old position and insert at new position
    final shelf = shelves.removeAt(oldIndex);
    shelves.insert(newIndex, shelf);

    final updatedConfig = currentState.config.copyWith(shelves: shelves);
    await _saveLibrary(updatedConfig);

    emit(currentState.copyWith(config: updatedConfig));
  }
}
