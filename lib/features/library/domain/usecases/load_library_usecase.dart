import '../entities/library_config.dart';
import '../repositories/library_repository.dart';

/// Use case for loading existing library configuration
class LoadLibraryUseCase {
  final LibraryRepository _repository;

  LoadLibraryUseCase(this._repository);

  Future<LibraryConfig?> call(String directoryPath) async {
    return await _repository.loadLibrary(directoryPath);
  }
}
