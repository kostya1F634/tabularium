import 'package:equatable/equatable.dart';
import '../../domain/entities/book.dart';

/// Base class for library events
abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize library for a directory
class InitializeLibrary extends LibraryEvent {
  final String directoryPath;

  const InitializeLibrary(this.directoryPath);

  @override
  List<Object?> get props => [directoryPath];
}

/// Event to load existing library
class LoadLibrary extends LibraryEvent {
  final String directoryPath;

  const LoadLibrary(this.directoryPath);

  @override
  List<Object?> get props => [directoryPath];
}

/// Event to select a shelf
class SelectShelf extends LibraryEvent {
  final String shelfId;

  const SelectShelf(this.shelfId);

  @override
  List<Object?> get props => [shelfId];
}

/// Event to create a new shelf
class CreateShelf extends LibraryEvent {
  final String name;

  const CreateShelf(this.name);

  @override
  List<Object?> get props => [name];
}

/// Event to delete a shelf
class DeleteShelf extends LibraryEvent {
  final String shelfId;

  const DeleteShelf(this.shelfId);

  @override
  List<Object?> get props => [shelfId];
}

/// Event to rename a shelf
class RenameShelf extends LibraryEvent {
  final String shelfId;
  final String newName;

  const RenameShelf({required this.shelfId, required this.newName});

  @override
  List<Object?> get props => [shelfId, newName];
}

/// Event to add book to shelf
class AddBookToShelf extends LibraryEvent {
  final String bookId;
  final String shelfId;

  const AddBookToShelf({required this.bookId, required this.shelfId});

  @override
  List<Object?> get props => [bookId, shelfId];
}

/// Event to remove book from shelf
class RemoveBookFromShelf extends LibraryEvent {
  final String bookId;
  final String shelfId;

  const RemoveBookFromShelf({required this.bookId, required this.shelfId});

  @override
  List<Object?> get props => [bookId, shelfId];
}

/// Event to search books
class SearchBooks extends LibraryEvent {
  final String query;

  const SearchBooks(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event to clear search
class ClearSearch extends LibraryEvent {
  const ClearSearch();
}

/// Event to open a book
class OpenBook extends LibraryEvent {
  final Book book;

  const OpenBook(this.book);

  @override
  List<Object?> get props => [book];
}

/// Event to open all books in current view
class OpenAllBooks extends LibraryEvent {
  const OpenAllBooks();
}

/// Event to scan for new books
class ScanForNewBooks extends LibraryEvent {
  const ScanForNewBooks();
}

/// Event to toggle book selection
class ToggleBookSelection extends LibraryEvent {
  final String bookId;

  const ToggleBookSelection(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

/// Event to select all books
class SelectAllBooks extends LibraryEvent {
  const SelectAllBooks();
}

/// Event to clear selection
class ClearBookSelection extends LibraryEvent {
  const ClearBookSelection();
}

/// Event to move/copy selected books to shelf
class MoveBooksToShelf extends LibraryEvent {
  final List<String> bookIds;
  final String targetShelfId;
  final String sourceShelfId;

  const MoveBooksToShelf({
    required this.bookIds,
    required this.targetShelfId,
    required this.sourceShelfId,
  });

  @override
  List<Object?> get props => [bookIds, targetShelfId, sourceShelfId];
}

/// Event to delete selected books from shelf
class DeleteSelectedBooks extends LibraryEvent {
  const DeleteSelectedBooks();
}

/// Event to update book alias
class UpdateBookAlias extends LibraryEvent {
  final String bookId;
  final String? alias;

  const UpdateBookAlias({required this.bookId, required this.alias});

  @override
  List<Object?> get props => [bookId, alias];
}

/// Event to delete book from shelf
class DeleteBookFromShelf extends LibraryEvent {
  final String bookId;
  final String shelfId;

  const DeleteBookFromShelf({required this.bookId, required this.shelfId});

  @override
  List<Object?> get props => [bookId, shelfId];
}

/// Event to reorder shelves
class ReorderShelves extends LibraryEvent {
  final int oldIndex;
  final int newIndex;
  final bool fromDrag;

  const ReorderShelves({
    required this.oldIndex,
    required this.newIndex,
    this.fromDrag = false,
  });

  @override
  List<Object?> get props => [oldIndex, newIndex, fromDrag];
}
