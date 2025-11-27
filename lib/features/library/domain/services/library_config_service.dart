import '../entities/library_config.dart';
import '../entities/book.dart';
import '../entities/shelf.dart';

/// Service for managing library configuration operations
class LibraryConfigService {
  /// Check if library needs initialization
  /// Returns true if config doesn't exist or needs update
  bool needsInitialization(LibraryConfig? config) {
    return config == null;
  }

  /// Check if library needs rescan
  /// Returns true if enough time has passed since last scan
  bool needsRescan(LibraryConfig config, {Duration threshold = const Duration(hours: 1)}) {
    final timeSinceLastScan = DateTime.now().difference(config.lastScanDate);
    return timeSinceLastScan > threshold;
  }

  /// Update "All" shelf with current book IDs
  LibraryConfig updateAllShelf(LibraryConfig config) {
    final allBookIds = config.books.map((book) => book.id).toList();
    final updatedShelves = config.shelves.map((shelf) {
      if (shelf.id == Shelf.allShelfId) {
        return shelf.copyWith(bookIds: allBookIds);
      }
      return shelf;
    }).toList();

    return config.copyWith(shelves: updatedShelves);
  }

  /// Remove books that no longer exist from config
  LibraryConfig removeNonExistentBooks(
    LibraryConfig config,
    List<String> existingFilePaths,
  ) {
    final existingPathsSet = existingFilePaths.toSet();
    final updatedBooks = config.books
        .where((book) => existingPathsSet.contains(book.filePath))
        .toList();

    // Get IDs of removed books
    final removedBookIds = config.books
        .where((book) => !existingPathsSet.contains(book.filePath))
        .map((book) => book.id)
        .toSet();

    // Remove deleted books from all shelves
    final updatedShelves = config.shelves.map((shelf) {
      final filteredBookIds = shelf.bookIds
          .where((id) => !removedBookIds.contains(id))
          .toList();
      return shelf.copyWith(bookIds: filteredBookIds);
    }).toList();

    return config.copyWith(
      books: updatedBooks,
      shelves: updatedShelves,
    );
  }

  /// Merge new books with existing ones
  LibraryConfig mergeBooks(LibraryConfig config, List<Book> newBooks) {
    final existingBookPaths = config.books.map((b) => b.filePath).toSet();
    final booksToAdd = newBooks
        .where((book) => !existingBookPaths.contains(book.filePath))
        .toList();

    if (booksToAdd.isEmpty) {
      return config;
    }

    return config.copyWith(
      books: [...config.books, ...booksToAdd],
      lastScanDate: DateTime.now(),
    );
  }

  /// Get books for a specific shelf
  List<Book> getBooksForShelf(LibraryConfig config, String shelfId) {
    if (shelfId == Shelf.allShelfId) {
      return config.books;
    }

    final shelf = config.getShelf(shelfId);
    if (shelf == null) {
      return [];
    }

    return config.books
        .where((book) => shelf.bookIds.contains(book.id))
        .toList();
  }

  /// Create a new shelf and add it to config
  LibraryConfig addShelf(LibraryConfig config, Shelf newShelf) {
    // Check if shelf with same ID already exists
    final shelfExists = config.shelves.any((s) => s.id == newShelf.id);
    if (shelfExists) {
      return config;
    }

    return config.copyWith(
      shelves: [...config.shelves, newShelf],
    );
  }

  /// Remove a shelf from config
  LibraryConfig removeShelf(LibraryConfig config, String shelfId) {
    // Don't allow removing the "All" shelf
    if (shelfId == Shelf.allShelfId) {
      return config;
    }

    final updatedShelves = config.shelves
        .where((shelf) => shelf.id != shelfId)
        .toList();

    return config.copyWith(shelves: updatedShelves);
  }

  /// Add book to shelf
  LibraryConfig addBookToShelf(
    LibraryConfig config,
    String bookId,
    String shelfId,
  ) {
    // Don't allow modifying the "All" shelf
    if (shelfId == Shelf.allShelfId) {
      return config;
    }

    final updatedShelves = config.shelves.map((shelf) {
      if (shelf.id == shelfId) {
        return shelf.addBook(bookId);
      }
      return shelf;
    }).toList();

    return config.copyWith(shelves: updatedShelves);
  }

  /// Remove book from shelf
  LibraryConfig removeBookFromShelf(
    LibraryConfig config,
    String bookId,
    String shelfId,
  ) {
    // Don't allow modifying the "All" shelf
    if (shelfId == Shelf.allShelfId) {
      return config;
    }

    final updatedShelves = config.shelves.map((shelf) {
      if (shelf.id == shelfId) {
        return shelf.removeBook(bookId);
      }
      return shelf;
    }).toList();

    return config.copyWith(shelves: updatedShelves);
  }

  /// Update book's last opened date
  LibraryConfig updateBookLastOpened(LibraryConfig config, String bookId) {
    final updatedBooks = config.books.map((book) {
      if (book.id == bookId) {
        return book.copyWith(lastOpenedDate: DateTime.now());
      }
      return book;
    }).toList();

    return config.copyWith(books: updatedBooks);
  }
}
