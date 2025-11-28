import 'settings_storage.dart';

/// Adapter class that provides SharedPreferences-like API
/// but uses our custom SettingsStorage backend
class AppSettings {
  final SettingsStorage _storage;

  AppSettings._(this._storage);

  static Future<AppSettings> getInstance() async {
    final storage = await SettingsStorage.getInstance();
    return AppSettings._(storage);
  }

  // String operations
  String? getString(String key) => _storage.getString(key);
  Future<bool> setString(String key, String value) async {
    await _storage.setString(key, value);
    return true;
  }

  // Double operations
  double? getDouble(String key) => _storage.getDouble(key);
  Future<bool> setDouble(String key, double value) async {
    await _storage.setDouble(key, value);
    return true;
  }

  // Int operations
  int? getInt(String key) => _storage.getInt(key);
  Future<bool> setInt(String key, int value) async {
    await _storage.setInt(key, value);
    return true;
  }

  // Bool operations
  bool? getBool(String key) => _storage.getBool(key);
  Future<bool> setBool(String key, bool value) async {
    await _storage.setBool(key, value);
    return true;
  }

  // List operations
  List<String>? getStringList(String key) => _storage.getStringList(key);
  Future<bool> setStringList(String key, List<String> value) async {
    await _storage.setStringList(key, value);
    return true;
  }

  // Remove operations
  Future<bool> remove(String key) async {
    await _storage.remove(key);
    return true;
  }

  // Clear all
  Future<bool> clear() async {
    await _storage.clear();
    return true;
  }

  // Check if key exists
  bool containsKey(String key) => _storage.containsKey(key);

  // Get all keys
  Set<String> getKeys() => _storage.getKeys();

  // Reload (no-op for compatibility, we auto-save on each change)
  Future<void> reload() async {}

  // Get settings file path
  String? getSettingsFilePath() => _storage.getSettingsFilePath();
}
