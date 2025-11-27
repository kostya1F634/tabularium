import '../entities/directory_path.dart';

/// Abstract repository for working with directories
abstract class DirectoryRepository {
  /// Get list of recent directories
  Future<List<DirectoryPath>> getRecentDirectories();

  /// Add directory to recent list
  Future<void> addRecentDirectory(String path);

  /// Clear recent directories list
  Future<void> clearRecentDirectories();

  /// Pick directory using system dialog
  Future<String?> pickDirectory();

  /// Get last opened directory
  Future<String?> getLastOpenedDirectory();

  /// Set last opened directory
  Future<void> setLastOpenedDirectory(String path);
}
