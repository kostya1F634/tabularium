import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import '../../domain/entities/library_config.dart';

/// Abstraction for managing library configuration file
abstract class ConfigDataSource {
  /// Load config from .tabularium.conf file
  Future<LibraryConfig?> loadConfig(String directoryPath);

  /// Save config to .tabularium.conf file
  Future<void> saveConfig(LibraryConfig config);

  /// Check if config file exists
  Future<bool> configExists(String directoryPath);

  /// Get config file path
  String getConfigPath(String directoryPath);
}

/// Implementation of config data source
class ConfigDataSourceImpl implements ConfigDataSource {
  static const String configFileName = '.tabularium.conf';

  @override
  Future<LibraryConfig?> loadConfig(String directoryPath) async {
    final configPath = getConfigPath(directoryPath);
    final configFile = File(configPath);

    if (!await configFile.exists()) {
      return null;
    }

    try {
      final jsonString = await configFile.readAsString();
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return LibraryConfig.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Error loading config from $configPath: $e');
    }
  }

  @override
  Future<void> saveConfig(LibraryConfig config) async {
    final configPath = getConfigPath(config.directoryPath);
    final configFile = File(configPath);

    try {
      final jsonMap = config.toJson();
      final jsonString = const JsonEncoder.withIndent('  ').convert(jsonMap);
      await configFile.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Error saving config to $configPath: $e');
    }
  }

  @override
  Future<bool> configExists(String directoryPath) async {
    final configPath = getConfigPath(directoryPath);
    return await File(configPath).exists();
  }

  @override
  String getConfigPath(String directoryPath) {
    return path.join(directoryPath, configFileName);
  }
}
