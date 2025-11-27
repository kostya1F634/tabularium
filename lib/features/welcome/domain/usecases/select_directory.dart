import '../repositories/directory_repository.dart';

/// Use case for selecting a directory
class SelectDirectory {
  final DirectoryRepository _repository;

  SelectDirectory(this._repository);

  Future<String?> call() async {
    final path = await _repository.pickDirectory();
    if (path != null) {
      await _repository.addRecentDirectory(path);
      await _repository.setLastOpenedDirectory(path);
    }
    return path;
  }
}
