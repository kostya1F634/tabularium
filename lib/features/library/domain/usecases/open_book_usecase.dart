import '../entities/book.dart';
import '../repositories/library_repository.dart';

/// Use case for opening a book with system default viewer
class OpenBookUseCase {
  final LibraryRepository _repository;

  OpenBookUseCase(this._repository);

  Future<void> call(Book book) async {
    return await _repository.openBook(book.filePath);
  }
}
