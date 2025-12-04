import 'package:equatable/equatable.dart';
import 'book.dart';
import 'shelf.dart';

/// Entity representing library configuration stored in .tabularium.conf
class LibraryConfig extends Equatable {
  final String directoryPath;
  final List<Book> books;
  final List<Shelf> shelves;
  final String theme;
  final String language;
  final DateTime lastScanDate;
  final String? lastSelectedShelfId;
  final String? lastFocusedBookId;
  final String? lastSortOption;
  final String? lastFocusArea; // 'shelves' or 'books'

  const LibraryConfig({
    required this.directoryPath,
    required this.books,
    required this.shelves,
    this.theme = 'system',
    this.language = 'en',
    required this.lastScanDate,
    this.lastSelectedShelfId,
    this.lastFocusedBookId,
    this.lastSortOption,
    this.lastFocusArea,
  });

  /// Create empty config
  factory LibraryConfig.empty(String directoryPath) {
    return LibraryConfig(
      directoryPath: directoryPath,
      books: const [],
      shelves: [Shelf.createAll(), Shelf.createUnsorted()],
      lastScanDate: DateTime.now(),
    );
  }

  LibraryConfig copyWith({
    String? directoryPath,
    List<Book>? books,
    List<Shelf>? shelves,
    String? theme,
    String? language,
    DateTime? lastScanDate,
    String? lastSelectedShelfId,
    String? lastFocusedBookId,
    String? lastSortOption,
    String? lastFocusArea,
  }) {
    return LibraryConfig(
      directoryPath: directoryPath ?? this.directoryPath,
      books: books ?? this.books,
      shelves: shelves ?? this.shelves,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      lastScanDate: lastScanDate ?? this.lastScanDate,
      lastSelectedShelfId: lastSelectedShelfId ?? this.lastSelectedShelfId,
      lastFocusedBookId: lastFocusedBookId ?? this.lastFocusedBookId,
      lastSortOption: lastSortOption ?? this.lastSortOption,
      lastFocusArea: lastFocusArea ?? this.lastFocusArea,
    );
  }

  /// Get book by ID
  Book? getBook(String id) {
    try {
      return books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get shelf by ID
  Shelf? getShelf(String id) {
    try {
      return shelves.firstWhere((shelf) => shelf.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all shelf (default shelf)
  Shelf get allShelf {
    return shelves.firstWhere(
      (shelf) => shelf.id == Shelf.allShelfId,
      orElse: () => Shelf.createAll(),
    );
  }

  /// Get unsorted shelf (default shelf)
  Shelf get unsortedShelf {
    return shelves.firstWhere(
      (shelf) => shelf.id == Shelf.unsortedShelfId,
      orElse: () => Shelf.createUnsorted(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'directoryPath': directoryPath,
      'books': books.map((book) => book.toJson()).toList(),
      'shelves': shelves.map((shelf) => shelf.toJson()).toList(),
      'theme': theme,
      'language': language,
      'lastScanDate': lastScanDate.toIso8601String(),
      'lastSelectedShelfId': lastSelectedShelfId,
      'lastFocusedBookId': lastFocusedBookId,
      'lastSortOption': lastSortOption,
      'lastFocusArea': lastFocusArea,
    };
  }

  /// Create from JSON
  factory LibraryConfig.fromJson(Map<String, dynamic> json) {
    final shelves = (json['shelves'] as List)
        .map((shelfJson) => Shelf.fromJson(shelfJson as Map<String, dynamic>))
        .toList();

    // Ensure "Unsorted" shelf exists (for backwards compatibility)
    final hasUnsortedShelf = shelves.any(
      (shelf) => shelf.id == Shelf.unsortedShelfId,
    );
    if (!hasUnsortedShelf) {
      // Insert Unsorted shelf after All shelf (at index 1)
      final allShelfIndex = shelves.indexWhere(
        (shelf) => shelf.id == Shelf.allShelfId,
      );
      if (allShelfIndex >= 0) {
        shelves.insert(allShelfIndex + 1, Shelf.createUnsorted());
      } else {
        // If no All shelf found (shouldn't happen), add at beginning
        shelves.insert(0, Shelf.createUnsorted());
      }
    }

    return LibraryConfig(
      directoryPath: json['directoryPath'] as String,
      books: (json['books'] as List)
          .map((bookJson) => Book.fromJson(bookJson as Map<String, dynamic>))
          .toList(),
      shelves: shelves,
      theme: json['theme'] as String? ?? 'system',
      language: json['language'] as String? ?? 'en',
      lastScanDate: DateTime.parse(json['lastScanDate'] as String),
      lastSelectedShelfId: json['lastSelectedShelfId'] as String?,
      lastFocusedBookId: json['lastFocusedBookId'] as String?,
      lastSortOption: json['lastSortOption'] as String?,
      lastFocusArea: json['lastFocusArea'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    directoryPath,
    books,
    shelves,
    theme,
    language,
    lastScanDate,
    lastSelectedShelfId,
    lastFocusedBookId,
    lastSortOption,
    lastFocusArea,
  ];
}
