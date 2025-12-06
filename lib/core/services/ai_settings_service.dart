import 'package:flutter/foundation.dart';
import 'app_settings.dart';

/// Service for managing AI settings (Ollama configuration)
class AISettingsService extends ChangeNotifier {
  static const String _ollamaUrlKey = 'ai_ollama_url';
  static const String _ollamaModelKey = 'ai_ollama_model';
  static const String _generalizationKey = 'ai_generalization';

  final AppSettings _prefs;
  String _ollamaUrl;
  String _ollamaModel;
  double _generalization;

  AISettingsService(this._prefs)
    : _ollamaUrl = _prefs.getString(_ollamaUrlKey) ?? 'http://127.0.0.1:11434',
      _ollamaModel = _prefs.getString(_ollamaModelKey) ?? 'deepseek-r1:1.5b',
      _generalization = _prefs.getDouble(_generalizationKey) ?? 0.5;

  /// Ollama server URL
  String get ollamaUrl => _ollamaUrl;

  /// Ollama model name
  String get ollamaModel => _ollamaModel;

  /// Generalization level (0.0 = maximize splitting, 1.0 = maximize grouping)
  double get generalization => _generalization;

  /// Check if AI is configured
  bool get isConfigured => _ollamaUrl.isNotEmpty && _ollamaModel.isNotEmpty;

  /// Set Ollama URL
  Future<void> setOllamaUrl(String url) async {
    if (_ollamaUrl == url) return;
    _ollamaUrl = url;
    await _prefs.setString(_ollamaUrlKey, url);
    notifyListeners();
  }

  /// Set Ollama model
  Future<void> setOllamaModel(String model) async {
    if (_ollamaModel == model) return;
    _ollamaModel = model;
    await _prefs.setString(_ollamaModelKey, model);
    notifyListeners();
  }

  /// Set generalization level
  Future<void> setGeneralization(double value) async {
    if (_generalization == value) return;
    _generalization = value;
    await _prefs.setDouble(_generalizationKey, value);
    notifyListeners();
  }
}
