import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';

import '../../../../core/services/ai_settings_service.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/shelf.dart';
import '../../domain/entities/library_config.dart';
import '../../domain/usecases/ai_analyze_book.dart';
import '../../domain/usecases/ai_sort_library.dart';
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
  final AIAnalyzeBook? _aiAnalyzeBook;
  final AISortLibrary? _aiSortLibrary;
  final AISettingsService _aiSettings;

  LibraryBloc({
    required InitializeLibraryUseCase initializeLibrary,
    required LoadLibraryUseCase loadLibrary,
    required SaveLibraryUseCase saveLibrary,
    required OpenBookUseCase openBook,
    required OpenAllBooksUseCase openAllBooks,
    AIAnalyzeBook? aiAnalyzeBook,
    AISortLibrary? aiSortLibrary,
    required AISettingsService aiSettings,
  }) : _initializeLibrary = initializeLibrary,
       _loadLibrary = loadLibrary,
       _saveLibrary = saveLibrary,
       _openBook = openBook,
       _openAllBooks = openAllBooks,
       _aiAnalyzeBook = aiAnalyzeBook,
       _aiSortLibrary = aiSortLibrary,
       _aiSettings = aiSettings,
       super(const LibraryInitial()) {
    on<InitializeLibrary>(_onInitializeLibrary);
    on<LoadLibrary>(_onLoadLibrary);
    on<SelectShelf>(_onSelectShelf);
    on<CreateShelf>(_onCreateShelf);
    on<DeleteShelf>(_onDeleteShelf);
    on<RenameShelf>(_onRenameShelf);
    on<AddBookToShelf>(_onAddBookToShelf);
    on<AddBooksToShelf>(_onAddBooksToShelf);
    on<RemoveBookFromShelf>(_onRemoveBookFromShelf);
    on<SearchBooks>(_onSearchBooks);
    on<ClearSearch>(_onClearSearch);
    on<SortBooks>(_onSortBooks);
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
    on<DeleteBookPermanently>(_onDeleteBookPermanently);
    on<DeleteSelectedBooksPermanently>(_onDeleteSelectedBooksPermanently);
    on<DeleteAllBooksPermanently>(_onDeleteAllBooksPermanently);
    on<DeleteAllBooksFromShelf>(_onDeleteAllBooksFromShelf);
    on<MoveFocusToBook>(_onMoveFocusToBook);
    on<MoveFocusInDirection>(_onMoveFocusInDirection);
    on<ToggleFocusedBookSelection>(_onToggleFocusedBookSelection);
    on<SaveFocusArea>(_onSaveFocusArea);
    on<AIFullSort>(_onAIFullSort);
    on<AIRenameBooks>(_onAIRenameBooks);
    on<AIAnalyzeSelectedBooks>(_onAIAnalyzeSelectedBooks);
  }

  Future<void> _onAIFullSort(
    AIFullSort event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;
    final currentState = state as LibraryLoaded;

    // Check if AI is configured
    if (_aiAnalyzeBook == null || _aiSortLibrary == null) {
      emit(
        const LibraryError(
          'AI not configured. Please configure AI settings first.',
        ),
      );
      await Future.delayed(const Duration(seconds: 3));
      emit(currentState);
      return;
    }

    try {
      emit(const LibraryAIProcessing('Starting AI analysis...'));

      // Get unsorted books using the proper helper method
      final unsortedBooks = _getBooksForShelf(
        currentState.config,
        Shelf.unsortedShelfId,
      );

      if (unsortedBooks.isEmpty) {
        emit(const LibraryError('No books in Unsorted shelf to analyze'));
        await Future.delayed(const Duration(seconds: 2));
        emit(currentState);
        return;
      }

      // Step 1: Analyze each book
      emit(
        LibraryAIProcessing(
          'Analyzing books...',
          progress: 0,
          total: unsortedBooks.length,
        ),
      );

      final updatedBooks = <Book>[];
      for (var i = 0; i < unsortedBooks.length; i++) {
        final book = unsortedBooks[i];

        try {
          final analysis = await _aiAnalyzeBook!(book);

          // Update book with AI-extracted metadata
          final updatedBook = book.copyWith(
            title: analysis.title ?? book.title,
            author: analysis.author ?? book.author,
            tags: analysis.tags,
          );
          updatedBooks.add(updatedBook);

          emit(
            LibraryAIProcessing(
              'Analyzing books...',
              progress: i + 1,
              total: unsortedBooks.length,
            ),
          );
        } catch (e) {
          print('Error analyzing book ${book.fileName}: $e');
          updatedBooks.add(book); // Keep original if analysis fails
        }
      }

      // Update config with analyzed books
      var newConfig = currentState.config;
      for (final updatedBook in updatedBooks) {
        final bookIndex = newConfig.books.indexWhere(
          (b) => b.id == updatedBook.id,
        );
        if (bookIndex != -1) {
          final newBooks = List<Book>.from(newConfig.books);
          newBooks[bookIndex] = updatedBook;
          newConfig = newConfig.copyWith(books: newBooks);
        }
      }

      // Step 2: Sort library with AI
      emit(const LibraryAIProcessing('Organizing into shelves...'));

      final sortResult = await _aiSortLibrary!(
        books: updatedBooks,
        existingShelves: currentState.config.shelves,
        generalization: _aiSettings.generalization,
      );

      // Step 3: Create new shelves
      var shelves = List<Shelf>.from(newConfig.shelves);
      for (final newShelfName in sortResult.newShelves) {
        final newShelf = Shelf(
          id: _generateShelfId(newShelfName),
          name: newShelfName,
          bookIds: [],
          isDefault: false,
          createdDate: DateTime.now(),
        );
        shelves.add(newShelf);
      }

      // Step 4: Assign books to shelves
      for (final assignment in sortResult.assignments) {
        final book = updatedBooks.firstWhere(
          (b) => b.filePath == assignment.filePath,
          orElse: () => updatedBooks.first,
        );
        final shelfIndex = shelves.indexWhere(
          (s) => s.name == assignment.shelfName,
        );

        // Add book to the target shelf (no need to remove from Unsorted - it's virtual)
        if (shelfIndex != -1 &&
            !shelves[shelfIndex].bookIds.contains(book.id)) {
          final updatedShelf = shelves[shelfIndex].copyWith(
            bookIds: [...shelves[shelfIndex].bookIds, book.id],
          );
          shelves[shelfIndex] = updatedShelf;
        }
      }

      newConfig = newConfig.copyWith(shelves: shelves);

      // Save config
      await _saveLibrary(newConfig);

      // Update displayed books for current shelf
      final booksForShelf = _getBooksForShelf(
        newConfig,
        currentState.selectedShelf.id,
      );
      final updatedDisplayedBooks = _getSortedBooks(
        booksForShelf,
        currentState.sortOption,
        currentState.searchQuery,
      );

      emit(
        currentState.copyWith(
          config: newConfig,
          displayedBooks: updatedDisplayedBooks,
        ),
      );

      // Show success message briefly
      emit(
        LibraryAIProcessing(
          'AI sort complete! ${updatedBooks.length} books analyzed, ${sortResult.newShelves.length} shelves created',
        ),
      );
      await Future.delayed(const Duration(seconds: 3));

      emit(
        currentState.copyWith(
          config: newConfig,
          displayedBooks: updatedDisplayedBooks,
        ),
      );
    } catch (e) {
      emit(LibraryError('AI sort failed: $e'));
      await Future.delayed(const Duration(seconds: 3));
      emit(currentState);
    }
  }

  Future<void> _onAIRenameBooks(
    AIRenameBooks event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;
    final currentState = state as LibraryLoaded;

    // Check if AI is configured
    if (_aiAnalyzeBook == null) {
      emit(
        const LibraryError(
          'AI not configured. Please configure AI settings first.',
        ),
      );
      await Future.delayed(const Duration(seconds: 3));
      emit(currentState);
      return;
    }

    final savedState = currentState;

    try {
      emit(const LibraryAIProcessing('Starting AI analysis...'));

      // Get unsorted books
      final unsortedBooks = _getBooksForShelf(
        currentState.config,
        Shelf.unsortedShelfId,
      );

      if (unsortedBooks.isEmpty) {
        emit(const LibraryError('No books in Unsorted shelf to analyze'));
        await Future.delayed(const Duration(seconds: 2));
        emit(currentState);
        return;
      }

      // Analyze each book
      emit(
        LibraryAIProcessing(
          'Analyzing books...',
          progress: 0,
          total: unsortedBooks.length,
        ),
      );

      var newConfig = currentState.config;

      for (var i = 0; i < unsortedBooks.length; i++) {
        final book = unsortedBooks[i];

        emit(
          LibraryAIProcessing(
            'Analyzing books...',
            progress: i,
            total: unsortedBooks.length,
            currentItem: book.title ?? book.fileName,
          ),
        );

        try {
          final analysis = await _aiAnalyzeBook!(book);

          // Update book with AI-extracted metadata
          final updatedBook = book.copyWith(
            title: analysis.title ?? book.title,
            author: analysis.author ?? book.author,
            tags: analysis.tags,
          );

          // Save book to config
          final bookIndex = newConfig.books.indexWhere(
            (b) => b.id == updatedBook.id,
          );
          if (bookIndex != -1) {
            final newBooks = List<Book>.from(newConfig.books);
            newBooks[bookIndex] = updatedBook;
            newConfig = newConfig.copyWith(books: newBooks);
            await _saveLibrary(newConfig);
          }

          emit(
            LibraryAIProcessing(
              'Analyzing books...',
              progress: i + 1,
              total: unsortedBooks.length,
              currentItem: updatedBook.title ?? updatedBook.fileName,
            ),
          );
        } catch (e) {
          print('Error analyzing book ${book.fileName}: $e');
        }
      }

      // Update displayed books
      final booksForShelf = _getBooksForShelf(
        newConfig,
        currentState.selectedShelf.id,
      );
      final updatedDisplayedBooks = _getSortedBooks(
        booksForShelf,
        currentState.sortOption,
        currentState.searchQuery,
      );

      emit(
        currentState.copyWith(
          config: newConfig,
          displayedBooks: updatedDisplayedBooks,
        ),
      );

      // Show success message
      emit(
        LibraryAIProcessing(
          'Analysis complete! ${unsortedBooks.length} books analyzed',
        ),
      );
      await Future.delayed(const Duration(seconds: 3));

      emit(
        currentState.copyWith(
          config: newConfig,
          displayedBooks: updatedDisplayedBooks,
        ),
      );
    } catch (e) {
      print('AI rename failed: $e');
      emit(LibraryError('AI rename failed: $e'));
      await Future.delayed(const Duration(seconds: 3));
      emit(savedState);
    }
  }

  Future<void> _onAIAnalyzeSelectedBooks(
    AIAnalyzeSelectedBooks event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;
    final currentState = state as LibraryLoaded;

    // Check if AI is configured
    if (_aiAnalyzeBook == null) {
      emit(
        const LibraryError(
          'AI not configured. Please configure AI settings first.',
        ),
      );
      await Future.delayed(const Duration(seconds: 3));
      emit(currentState);
      return;
    }

    final savedState = currentState;

    try {
      emit(const LibraryAIProcessing('Starting AI analysis...'));

      // Get selected books
      final selectedBooks = currentState.config.books
          .where((book) => event.bookIds.contains(book.id))
          .toList();

      if (selectedBooks.isEmpty) {
        emit(const LibraryError('No books selected'));
        await Future.delayed(const Duration(seconds: 2));
        emit(currentState);
        return;
      }

      // Analyze each book
      emit(
        LibraryAIProcessing(
          'Analyzing books...',
          progress: 0,
          total: selectedBooks.length,
        ),
      );

      var newConfig = currentState.config;

      for (var i = 0; i < selectedBooks.length; i++) {
        final book = selectedBooks[i];

        emit(
          LibraryAIProcessing(
            'Analyzing books...',
            progress: i,
            total: selectedBooks.length,
            currentItem: book.title ?? book.fileName,
          ),
        );

        try {
          final analysis = await _aiAnalyzeBook!(book);

          // Update book with AI-extracted metadata
          final updatedBook = book.copyWith(
            title: analysis.title ?? book.title,
            author: analysis.author ?? book.author,
            tags: analysis.tags,
          );

          // Save book to config
          final bookIndex = newConfig.books.indexWhere(
            (b) => b.id == updatedBook.id,
          );
          if (bookIndex != -1) {
            final newBooks = List<Book>.from(newConfig.books);
            newBooks[bookIndex] = updatedBook;
            newConfig = newConfig.copyWith(books: newBooks);
            await _saveLibrary(newConfig);
          }

          emit(
            LibraryAIProcessing(
              'Analyzing books...',
              progress: i + 1,
              total: selectedBooks.length,
              currentItem: updatedBook.title ?? updatedBook.fileName,
            ),
          );
        } catch (e) {
          print('Error analyzing book ${book.fileName}: $e');
        }
      }

      // Update displayed books
      final booksForShelf = _getBooksForShelf(
        newConfig,
        currentState.selectedShelf.id,
      );
      final updatedDisplayedBooks = _getSortedBooks(
        booksForShelf,
        currentState.sortOption,
        currentState.searchQuery,
      );

      emit(
        currentState.copyWith(
          config: newConfig,
          displayedBooks: updatedDisplayedBooks,
        ),
      );

      // Show success message
      emit(
        LibraryAIProcessing(
          'Analysis complete! ${selectedBooks.length} books analyzed',
        ),
      );
      await Future.delayed(const Duration(seconds: 3));

      emit(
        currentState.copyWith(
          config: newConfig,
          displayedBooks: updatedDisplayedBooks,
        ),
      );
    } catch (e) {
      print('AI analysis failed: $e');
      emit(LibraryError('AI analysis failed: $e'));
      await Future.delayed(const Duration(seconds: 3));
      emit(savedState);
    }
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

      // Restore sort option
      final sortOption = _parseSortOption(config.lastSortOption);

      final displayedBooks = _getSortedBooks(
        _getBooksForShelf(config, selectedShelf.id),
        sortOption,
        null,
      );

      emit(
        LibraryLoaded(
          config: config,
          selectedShelf: selectedShelf,
          displayedBooks: displayedBooks,
          focusedBookId: config.lastFocusedBookId,
          sortOption: sortOption,
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

      // Restore sort option
      final sortOption = _parseSortOption(config.lastSortOption);

      final displayedBooks = _getSortedBooks(
        _getBooksForShelf(config, allShelf.id),
        sortOption,
        null,
      );

      emit(
        LibraryLoaded(
          config: config,
          selectedShelf: allShelf,
          displayedBooks: displayedBooks,
          focusedBookId: config.lastFocusedBookId,
          sortOption: sortOption,
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

    // Set focus to first book if available, otherwise clear focus
    final newFocusedBookId = displayedBooks.isNotEmpty
        ? displayedBooks.first.id
        : null;

    emit(
      currentState.copyWith(
        config: updatedConfig,
        selectedShelf: shelf,
        displayedBooks: displayedBooks,
        clearSearch: true,
        selectedBookIds: const {}, // Clear selection when switching shelves
        focusedBookId: newFocusedBookId, // Focus first book or null if no books
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

  Future<void> _onAddBooksToShelf(
    AddBooksToShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final shelf = currentState.config.getShelf(event.shelfId);

    if (shelf == null || shelf.id == Shelf.allShelfId) return;

    final updatedShelf = shelf.addBooks(event.bookIds);
    final updatedShelves = currentState.config.shelves
        .map((s) => s.id == event.shelfId ? updatedShelf : s)
        .toList();

    final updatedConfig = currentState.config.copyWith(shelves: updatedShelves);

    await _saveLibrary(updatedConfig);

    final displayedBooks = _getBooksForShelf(
      updatedConfig,
      currentState.selectedShelf.id,
    );

    // Don't clear selection here - let the caller decide
    emit(
      currentState.copyWith(
        config: updatedConfig,
        displayedBooks: displayedBooks,
        // Keep selection to allow multiple operations
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
          displayedBooks: _getSortedBooks(
            _getBooksForShelf(
              currentState.config,
              currentState.selectedShelf.id,
            ),
            currentState.sortOption,
            null,
          ),
        ),
      );
      return;
    }

    // Get books for current shelf and apply search + sort
    final displayedBooks = _getSortedBooks(
      _getBooksForShelf(currentState.config, currentState.selectedShelf.id),
      currentState.sortOption,
      event.query,
    );

    emit(
      currentState.copyWith(
        searchQuery: event.query,
        displayedBooks: displayedBooks,
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
        displayedBooks: _getSortedBooks(
          _getBooksForShelf(currentState.config, currentState.selectedShelf.id),
          currentState.sortOption,
          null,
        ),
      ),
    );
  }

  Future<void> _onSortBooks(SortBooks event, Emitter<LibraryState> emit) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Save sort option to config
    final updatedConfig = currentState.config.copyWith(
      lastSortOption: event.sortOption.name,
    );
    await _saveLibrary(updatedConfig);

    emit(
      currentState.copyWith(
        config: updatedConfig,
        sortOption: event.sortOption,
        displayedBooks: _getSortedBooks(
          _getBooksForShelf(currentState.config, currentState.selectedShelf.id),
          event.sortOption,
          currentState.searchQuery,
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
      // Re-initialize library to scan for new books with progress callback
      final updatedConfig = await _initializeLibrary(
        currentState.config.directoryPath,
        onProgress: (current, total) {
          emit(LibraryInitializing(currentBook: current, totalBooks: total));
        },
      );

      final displayedBooks = _getSortedBooks(
        _getBooksForShelf(updatedConfig, currentState.selectedShelf.id),
        currentState.sortOption,
        currentState.searchQuery,
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

  /// Sort books based on sort option and search query
  List<Book> _getSortedBooks(
    List<Book> books,
    BookSortOption sortOption,
    String? searchQuery,
  ) {
    // Apply search filter if exists
    var filteredBooks = books;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filteredBooks = books.where((book) {
        return book.displayTitle.toLowerCase().contains(query) ||
            (book.author?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Sort books
    switch (sortOption) {
      case BookSortOption.dateAddedNewest:
        filteredBooks.sort((a, b) => b.addedDate.compareTo(a.addedDate));
        break;
      case BookSortOption.dateAddedOldest:
        filteredBooks.sort((a, b) => a.addedDate.compareTo(b.addedDate));
        break;
      case BookSortOption.dateOpenedNewest:
        filteredBooks.sort((a, b) {
          if (a.lastOpenedDate == null && b.lastOpenedDate == null) return 0;
          if (a.lastOpenedDate == null) return 1;
          if (b.lastOpenedDate == null) return -1;
          return b.lastOpenedDate!.compareTo(a.lastOpenedDate!);
        });
        break;
      case BookSortOption.dateOpenedOldest:
        filteredBooks.sort((a, b) {
          if (a.lastOpenedDate == null && b.lastOpenedDate == null) return 0;
          if (a.lastOpenedDate == null) return 1;
          if (b.lastOpenedDate == null) return -1;
          return a.lastOpenedDate!.compareTo(b.lastOpenedDate!);
        });
        break;
      case BookSortOption.titleAZ:
        filteredBooks.sort(
          (a, b) => a.displayTitle.toLowerCase().compareTo(
            b.displayTitle.toLowerCase(),
          ),
        );
        break;
      case BookSortOption.titleZA:
        filteredBooks.sort(
          (a, b) => b.displayTitle.toLowerCase().compareTo(
            a.displayTitle.toLowerCase(),
          ),
        );
        break;
    }

    return filteredBooks;
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
    print('DEBUG _onClearBookSelection: called');
    if (state is! LibraryLoaded) {
      print('DEBUG _onClearBookSelection: state is not LibraryLoaded');
      return;
    }

    final currentState = state as LibraryLoaded;
    print(
      'DEBUG _onClearBookSelection: clearing ${currentState.selectedBookIds.length} selected books',
    );
    emit(currentState.copyWith(clearSelection: true));
    print('DEBUG _onClearBookSelection: selection cleared');
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

  Future<void> _onDeleteBookPermanently(
    DeleteBookPermanently event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Find the book
    final book = currentState.config.books.firstWhere(
      (b) => b.id == event.bookId,
      orElse: () => throw Exception('Book not found'),
    );

    try {
      // Delete the physical file
      final file = File(book.filePath);
      if (await file.exists()) {
        await file.delete();
      }

      // Delete thumbnail if exists
      if (book.thumbnailPath != null) {
        final thumbnail = File(book.thumbnailPath!);
        if (await thumbnail.exists()) {
          await thumbnail.delete();
        }
      }

      // Remove book from config
      final updatedBooks = currentState.config.books
          .where((b) => b.id != event.bookId)
          .toList();

      // Remove book from all shelves
      final updatedShelves = currentState.config.shelves.map((shelf) {
        return shelf.removeBook(event.bookId);
      }).toList();

      final updatedConfig = currentState.config.copyWith(
        books: updatedBooks,
        shelves: updatedShelves,
      );

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
    } catch (e) {
      // Error handling - could emit an error state
      print('Error deleting book: $e');
    }
  }

  Future<void> _onDeleteSelectedBooksPermanently(
    DeleteSelectedBooksPermanently event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;
    final selectedBookIds = currentState.selectedBookIds.toList();

    if (selectedBookIds.isEmpty) return;

    try {
      // Delete physical files for all selected books
      for (final bookId in selectedBookIds) {
        final book = currentState.config.books.firstWhere(
          (b) => b.id == bookId,
          orElse: () => throw Exception('Book not found'),
        );

        // Delete the file
        final file = File(book.filePath);
        if (await file.exists()) {
          await file.delete();
        }

        // Delete thumbnail if exists
        if (book.thumbnailPath != null) {
          final thumbnail = File(book.thumbnailPath!);
          if (await thumbnail.exists()) {
            await thumbnail.delete();
          }
        }
      }

      // Remove books from config
      final updatedBooks = currentState.config.books
          .where((b) => !selectedBookIds.contains(b.id))
          .toList();

      // Remove books from all shelves
      final updatedShelves = currentState.config.shelves.map((shelf) {
        var updatedShelf = shelf;
        for (final bookId in selectedBookIds) {
          updatedShelf = updatedShelf.removeBook(bookId);
        }
        return updatedShelf;
      }).toList();

      final updatedConfig = currentState.config.copyWith(
        books: updatedBooks,
        shelves: updatedShelves,
      );

      await _saveLibrary(updatedConfig);

      final displayedBooks = _getBooksForShelf(
        updatedConfig,
        currentState.selectedShelf.id,
      );

      emit(
        currentState.copyWith(
          config: updatedConfig,
          displayedBooks: displayedBooks,
          selectedBookIds: const {},
        ),
      );
    } catch (e) {
      print('Error deleting selected books: $e');
    }
  }

  Future<void> _onDeleteAllBooksPermanently(
    DeleteAllBooksPermanently event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    try {
      // Delete all physical files
      for (final book in currentState.config.books) {
        // Delete the file
        final file = File(book.filePath);
        if (await file.exists()) {
          await file.delete();
        }

        // Delete thumbnail if exists
        if (book.thumbnailPath != null) {
          final thumbnail = File(book.thumbnailPath!);
          if (await thumbnail.exists()) {
            await thumbnail.delete();
          }
        }
      }

      // Clear all books and reset shelves
      final updatedShelves = currentState.config.shelves.map((shelf) {
        return shelf.copyWith(bookIds: []);
      }).toList();

      final updatedConfig = currentState.config.copyWith(
        books: [],
        shelves: updatedShelves,
      );

      await _saveLibrary(updatedConfig);

      emit(
        currentState.copyWith(
          config: updatedConfig,
          displayedBooks: [],
          selectedBookIds: const {},
        ),
      );
    } catch (e) {
      print('Error deleting all books: $e');
    }
  }

  Future<void> _onDeleteAllBooksFromShelf(
    DeleteAllBooksFromShelf event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;

    final currentState = state as LibraryLoaded;

    // Get books from the specified shelf
    final booksToDelete = _getBooksForShelf(currentState.config, event.shelfId);

    if (booksToDelete.isEmpty) return;

    try {
      // Delete all physical files from this shelf
      for (final book in booksToDelete) {
        // Delete the file
        final file = File(book.filePath);
        if (await file.exists()) {
          await file.delete();
        }

        // Delete thumbnail if exists
        if (book.thumbnailPath != null) {
          final thumbnail = File(book.thumbnailPath!);
          if (await thumbnail.exists()) {
            await thumbnail.delete();
          }
        }
      }

      // Get IDs of deleted books
      final deletedBookIds = booksToDelete.map((b) => b.id).toSet();

      // Remove books from config
      final updatedBooks = currentState.config.books
          .where((b) => !deletedBookIds.contains(b.id))
          .toList();

      // Remove books from all shelves
      final updatedShelves = currentState.config.shelves.map((shelf) {
        var updatedShelf = shelf;
        for (final bookId in deletedBookIds) {
          updatedShelf = updatedShelf.removeBook(bookId);
        }
        return updatedShelf;
      }).toList();

      final updatedConfig = currentState.config.copyWith(
        books: updatedBooks,
        shelves: updatedShelves,
      );

      await _saveLibrary(updatedConfig);

      final displayedBooks = _getBooksForShelf(
        updatedConfig,
        currentState.selectedShelf.id,
      );

      emit(
        currentState.copyWith(
          config: updatedConfig,
          displayedBooks: displayedBooks,
          selectedBookIds: const {},
        ),
      );
    } catch (e) {
      print('Error deleting books from shelf: $e');
    }
  }

  /// Move focus to specific book
  Future<void> _onMoveFocusToBook(
    MoveFocusToBook event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;
    final currentState = state as LibraryLoaded;

    // Update config with new focused book
    final updatedConfig = currentState.config.copyWith(
      lastFocusedBookId: event.bookId,
    );

    // Emit state immediately for instant UI update
    emit(
      currentState.copyWith(focusedBookId: event.bookId, config: updatedConfig),
    );

    // Save in background (non-blocking)
    await _saveLibrary(updatedConfig);
  }

  /// Move focus in direction (hjkl or arrows)
  Future<void> _onMoveFocusInDirection(
    MoveFocusInDirection event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;
    final currentState = state as LibraryLoaded;

    if (currentState.displayedBooks.isEmpty) return;

    // If no focus yet, focus first book
    if (currentState.focusedBookId == null) {
      await _updateFocusAndSave(
        currentState.displayedBooks.first.id,
        currentState,
        emit,
      );
      return;
    }

    // Find current focused book index
    final currentIndex = currentState.displayedBooks.indexWhere(
      (book) => book.id == currentState.focusedBookId,
    );

    if (currentIndex == -1) {
      // Focused book not found, focus first
      await _updateFocusAndSave(
        currentState.displayedBooks.first.id,
        currentState,
        emit,
      );
      return;
    }

    // Calculate grid parameters (use provided columnsCount or default to 6)
    final columnsCount = event.columnsCount ?? 6;
    final totalBooks = currentState.displayedBooks.length;
    final currentRow = currentIndex ~/ columnsCount;
    final currentCol = currentIndex % columnsCount;

    int? newIndex;

    switch (event.direction) {
      case FocusDirection.left:
        if (currentCol > 0) {
          newIndex = currentIndex - 1;
        }
        break;
      case FocusDirection.right:
        if (currentCol < columnsCount - 1 && currentIndex + 1 < totalBooks) {
          newIndex = currentIndex + 1;
        }
        break;
      case FocusDirection.up:
        if (currentRow > 0) {
          newIndex = currentIndex - columnsCount;
          if (newIndex < 0) newIndex = null;
        }
        break;
      case FocusDirection.down:
        final potentialIndex = currentIndex + columnsCount;
        if (potentialIndex < totalBooks) {
          // Direct move down to same column in next row
          newIndex = potentialIndex;
        } else {
          // No book directly below, but check if next row exists
          final nextRowStartIndex = ((currentRow + 1) * columnsCount);
          if (nextRowStartIndex < totalBooks) {
            // Next row exists, move to last book in that row
            final nextRowEndIndex = ((currentRow + 2) * columnsCount) - 1;
            newIndex = nextRowEndIndex < totalBooks
                ? nextRowEndIndex
                : totalBooks - 1;
          }
        }
        break;
    }

    if (newIndex != null) {
      await _updateFocusAndSave(
        currentState.displayedBooks[newIndex].id,
        currentState,
        emit,
      );
    }
  }

  /// Helper method to update focus and save to config
  Future<void> _updateFocusAndSave(
    String bookId,
    LibraryLoaded currentState,
    Emitter<LibraryState> emit,
  ) async {
    final updatedConfig = currentState.config.copyWith(
      lastFocusedBookId: bookId,
    );
    await _saveLibrary(updatedConfig);

    emit(currentState.copyWith(focusedBookId: bookId, config: updatedConfig));
  }

  /// Toggle selection of focused book
  Future<void> _onToggleFocusedBookSelection(
    ToggleFocusedBookSelection event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is! LibraryLoaded) return;
    final currentState = state as LibraryLoaded;

    if (currentState.focusedBookId == null) return;

    final selectedBookIds = Set<String>.from(currentState.selectedBookIds);
    if (selectedBookIds.contains(currentState.focusedBookId)) {
      selectedBookIds.remove(currentState.focusedBookId);
    } else {
      selectedBookIds.add(currentState.focusedBookId!);
    }

    emit(currentState.copyWith(selectedBookIds: selectedBookIds));
  }

  /// Save current focus area
  Future<void> _onSaveFocusArea(
    SaveFocusArea event,
    Emitter<LibraryState> emit,
  ) async {
    final currentState = state;
    if (currentState is! LibraryLoaded) return;

    final updatedConfig = currentState.config.copyWith(
      lastFocusArea: event.focusArea,
    );

    await _saveLibrary(updatedConfig);
    emit(currentState.copyWith(config: updatedConfig));
  }

  /// Parse sort option from string
  BookSortOption _parseSortOption(String? sortOptionString) {
    if (sortOptionString == null) return BookSortOption.dateAddedNewest;
    try {
      return BookSortOption.values.firstWhere(
        (e) => e.name == sortOptionString,
      );
    } catch (_) {
      return BookSortOption.dateAddedNewest;
    }
  }
}
