import '../entities/library_config.dart';
import '../repositories/library_repository.dart';

/// Use case for initializing library in a directory
class InitializeLibraryUseCase {
  final LibraryRepository _repository;

  InitializeLibraryUseCase(this._repository);

  Future<LibraryConfig> call(
    String directoryPath, {
    LibraryInitializationProgress? onProgress,
  }) async {
    return await _repository.initializeLibrary(
      directoryPath,
      onProgress: onProgress,
    );
  }
}
