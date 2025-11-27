import '../entities/directory_path.dart';
import '../repositories/directory_repository.dart';

/// Use case for getting list of recent directories
class GetRecentDirectories {
  final DirectoryRepository _repository;

  GetRecentDirectories(this._repository);

  Future<List<DirectoryPath>> call() async {
    return await _repository.getRecentDirectories();
  }
}
