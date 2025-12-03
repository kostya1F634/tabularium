import 'package:equatable/equatable.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/shelf.dart';
import '../../domain/entities/library_config.dart';
import 'library_event.dart';

/// Base class for library states
abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class LibraryInitial extends LibraryState {
  const LibraryInitial();
}

/// Loading state
class LibraryLoading extends LibraryState {
  const LibraryLoading();
}

/// Initializing state with progress
class LibraryInitializing extends LibraryState {
  final int currentBook;
  final int totalBooks;

  const LibraryInitializing({
    required this.currentBook,
    required this.totalBooks,
  });

  @override
  List<Object?> get props => [currentBook, totalBooks];
}

/// Loaded state with library data
class LibraryLoaded extends LibraryState {
  final LibraryConfig config;
  final Shelf selectedShelf;
  final String? searchQuery;
  final BookSortOption sortOption;
  final List<Book> displayedBooks;
  final Set<String> selectedBookIds;
  final String? focusedBookId;

  const LibraryLoaded({
    required this.config,
    required this.selectedShelf,
    this.searchQuery,
    this.sortOption = BookSortOption.dateAddedNewest,
    required this.displayedBooks,
    this.selectedBookIds = const {},
    this.focusedBookId,
  });

  @override
  List<Object?> get props => [
    config,
    selectedShelf,
    searchQuery,
    sortOption,
    displayedBooks,
    selectedBookIds,
    focusedBookId,
  ];

  bool get hasSelection => selectedBookIds.isNotEmpty;

  List<Book> get selectedBooks {
    return displayedBooks
        .where((book) => selectedBookIds.contains(book.id))
        .toList();
  }

  LibraryLoaded copyWith({
    LibraryConfig? config,
    Shelf? selectedShelf,
    String? searchQuery,
    bool clearSearch = false,
    BookSortOption? sortOption,
    List<Book>? displayedBooks,
    Set<String>? selectedBookIds,
    bool clearSelection = false,
    String? focusedBookId,
    bool clearFocus = false,
  }) {
    return LibraryLoaded(
      config: config ?? this.config,
      selectedShelf: selectedShelf ?? this.selectedShelf,
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      sortOption: sortOption ?? this.sortOption,
      displayedBooks: displayedBooks ?? this.displayedBooks,
      selectedBookIds: clearSelection
          ? {}
          : (selectedBookIds ?? this.selectedBookIds),
      focusedBookId: clearFocus ? null : (focusedBookId ?? this.focusedBookId),
    );
  }
}

/// Error state
class LibraryError extends LibraryState {
  final String message;

  const LibraryError(this.message);

  @override
  List<Object?> get props => [message];
}
