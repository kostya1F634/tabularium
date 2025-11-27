import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/directory_path.dart';
import '../../domain/repositories/directory_repository.dart';
import '../datasources/file_picker_datasource.dart';

/// Implementation of repository for working with directories
class DirectoryRepositoryImpl implements DirectoryRepository {
  static const String _recentDirsKey = 'recent_directories';
  static const String _recentDirsTimestampsKey = 'recent_directories_timestamps';
  static const String _lastOpenedDirKey = 'last_opened_directory';
  static const int _maxRecentDirs = 10;

  final SharedPreferences _prefs;
  final FilePickerDataSource _filePicker;

  DirectoryRepositoryImpl({
    required SharedPreferences prefs,
    required FilePickerDataSource filePicker,
  })  : _prefs = prefs,
        _filePicker = filePicker;

  @override
  Future<List<DirectoryPath>> getRecentDirectories() async {
    final paths = _prefs.getStringList(_recentDirsKey) ?? [];
    final timestamps = _prefs.getStringList(_recentDirsTimestampsKey) ?? [];

    if (paths.isEmpty) {
      return [];
    }

    // If timestamps are missing or fewer than paths, use current time
    final now = DateTime.now();
    final result = <DirectoryPath>[];

    for (int i = 0; i < paths.length; i++) {
      final timestamp = i < timestamps.length
          ? DateTime.tryParse(timestamps[i]) ?? now
          : now;
      result.add(DirectoryPath(
        path: paths[i],
        lastAccessed: timestamp,
      ));
    }

    return result;
  }

  @override
  Future<void> addRecentDirectory(String path) async {
    List<String> recentDirs = _prefs.getStringList(_recentDirsKey) ?? [];
    List<String> timestamps = _prefs.getStringList(_recentDirsTimestampsKey) ?? [];

    // Remove duplicates if path already exists
    final existingIndex = recentDirs.indexOf(path);
    if (existingIndex != -1) {
      recentDirs.removeAt(existingIndex);
      if (existingIndex < timestamps.length) {
        timestamps.removeAt(existingIndex);
      }
    }

    // Add to the beginning of the list
    final now = DateTime.now();
    recentDirs.insert(0, path);
    timestamps.insert(0, now.toIso8601String());

    // Limit list size
    if (recentDirs.length > _maxRecentDirs) {
      recentDirs = recentDirs.sublist(0, _maxRecentDirs);
      timestamps = timestamps.sublist(0, _maxRecentDirs);
    }

    await _prefs.setStringList(_recentDirsKey, recentDirs);
    await _prefs.setStringList(_recentDirsTimestampsKey, timestamps);
  }

  @override
  Future<void> clearRecentDirectories() async {
    await _prefs.remove(_recentDirsKey);
    await _prefs.remove(_recentDirsTimestampsKey);
  }

  @override
  Future<String?> pickDirectory() async {
    return await _filePicker.pickDirectory();
  }

  @override
  Future<String?> getLastOpenedDirectory() async {
    return _prefs.getString(_lastOpenedDirKey);
  }

  @override
  Future<void> setLastOpenedDirectory(String path) async {
    await _prefs.setString(_lastOpenedDirKey, path);
  }
}
