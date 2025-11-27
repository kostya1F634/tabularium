import '../entities/library_config.dart';
import '../repositories/library_repository.dart';

/// Use case for saving library configuration
class SaveLibraryUseCase {
  final LibraryRepository _repository;

  SaveLibraryUseCase(this._repository);

  Future<void> call(LibraryConfig config) async {
    return await _repository.saveLibrary(config);
  }
}
