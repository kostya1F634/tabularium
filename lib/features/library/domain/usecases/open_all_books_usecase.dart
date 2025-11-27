import '../entities/book.dart';
import '../repositories/library_repository.dart';

/// Use case for opening all books in the library
class OpenAllBooksUseCase {
  final LibraryRepository _repository;

  OpenAllBooksUseCase(this._repository);

  Future<void> call(List<Book> books) async {
    return await _repository.openAllBooks(books);
  }
}
