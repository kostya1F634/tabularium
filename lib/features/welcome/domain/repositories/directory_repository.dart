import '../entities/directory_path.dart';

/// Abstract repository for working with directories
abstract class DirectoryRepository {
  /// Get list of recent directories
  Future<List<DirectoryPath>> getRecentDirectories();

  /// Add directory to recent list
  Future<void> addRecentDirectory(String path);

  /// Clear recent directories list
  Future<void> clearRecentDirectories();

  /// Remove specific directory from recent list
  Future<void> removeRecentDirectory(String path);

  /// Get list of favorite directories
  Future<List<DirectoryPath>> getFavoriteDirectories();

  /// Add directory to favorites list
  Future<void> addFavoriteDirectory(String path);

  /// Remove directory from favorites list
  Future<void> removeFavoriteDirectory(String path);

  /// Clear favorite directories list
  Future<void> clearFavoriteDirectories();

  /// Pick directory using system dialog
  Future<String?> pickDirectory();

  /// Get last opened directory
  Future<String?> getLastOpenedDirectory();

  /// Set last opened directory
  Future<void> setLastOpenedDirectory(String path);
}
