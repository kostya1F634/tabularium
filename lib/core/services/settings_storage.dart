import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Cross-platform settings storage using JSON file
/// Stores settings in:
/// - Linux: ~/.config/tabularium/settings.json
/// - Windows: %APPDATA%\tabularium\settings.json
/// - macOS: ~/Library/Application Support/tabularium/settings.json
class SettingsStorage {
  static SettingsStorage? _instance;
  File? _settingsFile;
  Map<String, dynamic> _cache = {};

  SettingsStorage._();

  static Future<SettingsStorage> getInstance() async {
    if (_instance == null) {
      _instance = SettingsStorage._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    final directory = await _getConfigDirectory();
    _settingsFile = File(path.join(directory.path, 'settings.json'));

    // Create directory if it doesn't exist
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Load existing settings
    if (await _settingsFile!.exists()) {
      try {
        final contents = await _settingsFile!.readAsString();
        _cache = json.decode(contents) as Map<String, dynamic>;
      } catch (e) {
        print('Error loading settings: $e');
        _cache = {};
      }
    }
  }

  Future<Directory> _getConfigDirectory() async {
    if (Platform.isLinux) {
      // Linux: ~/.config/tabularium
      final home = Platform.environment['HOME'];
      if (home == null) {
        throw Exception('HOME environment variable not set');
      }
      return Directory(path.join(home, '.config', 'tabularium'));
    } else if (Platform.isWindows) {
      // Windows: %APPDATA%\tabularium
      final appData = Platform.environment['APPDATA'];
      if (appData == null) {
        throw Exception('APPDATA environment variable not set');
      }
      return Directory(path.join(appData, 'tabularium'));
    } else if (Platform.isMacOS) {
      // macOS: ~/Library/Application Support/tabularium
      final supportDir = await getApplicationSupportDirectory();
      return Directory(path.join(supportDir.path, 'tabularium'));
    } else {
      // Fallback to application support directory
      final supportDir = await getApplicationSupportDirectory();
      return Directory(path.join(supportDir.path, 'tabularium'));
    }
  }

  Future<void> _save() async {
    try {
      final contents = json.encode(_cache);
      await _settingsFile!.writeAsString(contents);
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  // String operations
  String? getString(String key) {
    return _cache[key] as String?;
  }

  Future<void> setString(String key, String value) async {
    _cache[key] = value;
    await _save();
  }

  // Double operations
  double? getDouble(String key) {
    final value = _cache[key];
    if (value is int) return value.toDouble();
    return value as double?;
  }

  Future<void> setDouble(String key, double value) async {
    _cache[key] = value;
    await _save();
  }

  // Int operations
  int? getInt(String key) {
    return _cache[key] as int?;
  }

  Future<void> setInt(String key, int value) async {
    _cache[key] = value;
    await _save();
  }

  // Bool operations
  bool? getBool(String key) {
    return _cache[key] as bool?;
  }

  Future<void> setBool(String key, bool value) async {
    _cache[key] = value;
    await _save();
  }

  // List operations
  List<String>? getStringList(String key) {
    final value = _cache[key];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return null;
  }

  Future<void> setStringList(String key, List<String> value) async {
    _cache[key] = value;
    await _save();
  }

  // Remove operations
  Future<void> remove(String key) async {
    _cache.remove(key);
    await _save();
  }

  // Clear all
  Future<void> clear() async {
    _cache.clear();
    await _save();
  }

  // Check if key exists
  bool containsKey(String key) {
    return _cache.containsKey(key);
  }

  // Get all keys
  Set<String> getKeys() {
    return _cache.keys.toSet();
  }

  // Get settings file path (for debugging)
  String? getSettingsFilePath() {
    return _settingsFile?.path;
  }
}
