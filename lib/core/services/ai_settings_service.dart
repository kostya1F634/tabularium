import 'package:flutter/foundation.dart';
import 'app_settings.dart';

/// Service for managing AI settings (Ollama configuration)
class AISettingsService extends ChangeNotifier {
  static const String _ollamaUrlKey = 'ai_ollama_url';
  static const String _ollamaModelKey = 'ai_ollama_model';
  static const String _generalizationKey = 'ai_generalization';
  static const String _maxPagesKey = 'ai_max_pages';
  static const String _processImagesKey = 'ai_process_images';
  static const String _outputLanguageKey = 'ai_output_language';
  static const String _includeDetailedExamplesKey =
      'ai_include_detailed_examples';
  static const String _includeBookReasoningKey = 'ai_include_book_reasoning';
  static const String _includeExtendedInstructionsKey =
      'ai_include_extended_instructions';
  static const String _useIncrementalSortKey = 'ai_use_incremental_sort';

  // Ollama API parameters
  static const String _numCtxKey = 'ai_num_ctx';
  static const String _numPredictKey = 'ai_num_predict';
  static const String _repeatPenaltyKey = 'ai_repeat_penalty';
  static const String _topKKey = 'ai_top_k';
  static const String _topPKey = 'ai_top_p';
  static const String _numBatchKey = 'ai_num_batch';
  static const String _presencePenaltyKey = 'ai_presence_penalty';
  static const String _frequencyPenaltyKey = 'ai_frequency_penalty';
  static const String _minPKey = 'ai_min_p';
  static const String _seedKey = 'ai_seed';
  static const String _stopSequencesKey = 'ai_stop_sequences';

  final AppSettings _prefs;
  String _ollamaUrl;
  String _ollamaModel;
  double _generalization;
  int _maxPages;
  bool _processImages;
  String _outputLanguage;
  bool _includeDetailedExamples;
  bool _includeBookReasoning;
  bool _includeExtendedInstructions;
  bool _useIncrementalSort;

  // Ollama API parameters
  int _numCtx;
  int _numPredict;
  double _repeatPenalty;
  int _topK;
  double _topP;
  int _numBatch;
  double _presencePenalty;
  double _frequencyPenalty;
  double _minP;
  int _seed;
  String _stopSequences;

  AISettingsService(this._prefs)
    : _ollamaUrl = _prefs.getString(_ollamaUrlKey) ?? 'http://127.0.0.1:11434',
      _ollamaModel = _prefs.getString(_ollamaModelKey) ?? 'deepseek-r1:1.5b',
      _generalization = _prefs.getDouble(_generalizationKey) ?? 0.5,
      _maxPages = _prefs.getInt(_maxPagesKey) ?? 3,
      _processImages = _prefs.getBool(_processImagesKey) ?? false,
      _outputLanguage = _prefs.getString(_outputLanguageKey) ?? 'en',
      _includeDetailedExamples =
          _prefs.getBool(_includeDetailedExamplesKey) ?? true,
      _includeBookReasoning = _prefs.getBool(_includeBookReasoningKey) ?? true,
      _includeExtendedInstructions =
          _prefs.getBool(_includeExtendedInstructionsKey) ?? true,
      _useIncrementalSort = _prefs.getBool(_useIncrementalSortKey) ?? false,
      _numCtx = _prefs.getInt(_numCtxKey) ?? 8192,
      _numPredict = _prefs.getInt(_numPredictKey) ?? 1000,
      _repeatPenalty = _prefs.getDouble(_repeatPenaltyKey) ?? 1.1,
      _topK = _prefs.getInt(_topKKey) ?? 40,
      _topP = _prefs.getDouble(_topPKey) ?? 0.9,
      _numBatch = _prefs.getInt(_numBatchKey) ?? 512,
      _presencePenalty = _prefs.getDouble(_presencePenaltyKey) ?? 0.0,
      _frequencyPenalty = _prefs.getDouble(_frequencyPenaltyKey) ?? 0.0,
      _minP = _prefs.getDouble(_minPKey) ?? 0.0,
      _seed = _prefs.getInt(_seedKey) ?? -1,
      _stopSequences = _prefs.getString(_stopSequencesKey) ?? '';

  /// Ollama server URL
  String get ollamaUrl => _ollamaUrl;

  /// Ollama model name
  String get ollamaModel => _ollamaModel;

  /// Generalization level (0.0 = maximize splitting, 1.0 = maximize grouping)
  double get generalization => _generalization;

  /// Maximum pages to analyze per book (1-50)
  int get maxPages => _maxPages;

  /// Whether to process book cover images for analysis
  bool get processImages => _processImages;

  /// Output language for AI responses (shelf names, tags, reasoning)
  String get outputLanguage => _outputLanguage;

  /// Include detailed examples in prompts (GOOD/BAD tags examples)
  bool get includeDetailedExamples => _includeDetailedExamples;

  /// Include book reasoning in sorting context
  bool get includeBookReasoning => _includeBookReasoning;

  /// Include extended instructions (validation checklists, detailed explanations)
  bool get includeExtendedInstructions => _includeExtendedInstructions;

  /// Use incremental sorting (one book at a time, more reliable but slower)
  bool get useIncrementalSort => _useIncrementalSort;

  // Ollama API parameters getters

  /// Context window size (number of tokens)
  int get numCtx => _numCtx;

  /// Maximum number of tokens to predict (-1 for unlimited)
  int get numPredict => _numPredict;

  /// Repeat penalty (1.0 = no penalty, higher = more penalty)
  double get repeatPenalty => _repeatPenalty;

  /// Top-K sampling (number of top tokens to consider)
  int get topK => _topK;

  /// Top-P sampling (nucleus sampling threshold)
  double get topP => _topP;

  /// Batch size for prompt processing
  int get numBatch => _numBatch;

  /// Presence penalty (penalizes tokens that already appeared)
  double get presencePenalty => _presencePenalty;

  /// Frequency penalty (penalizes tokens based on frequency)
  double get frequencyPenalty => _frequencyPenalty;

  /// Minimum probability threshold (alternative to top_p)
  double get minP => _minP;

  /// Random seed for reproducibility (-1 for random)
  int get seed => _seed;

  /// Stop sequences (comma-separated)
  String get stopSequences => _stopSequences;

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

  /// Set maximum pages to analyze (1-50)
  Future<void> setMaxPages(int pages) async {
    final clampedPages = pages.clamp(1, 50);
    if (_maxPages == clampedPages) return;
    _maxPages = clampedPages;
    await _prefs.setInt(_maxPagesKey, clampedPages);
    notifyListeners();
  }

  /// Set whether to process book cover images
  Future<void> setProcessImages(bool value) async {
    if (_processImages == value) return;
    _processImages = value;
    await _prefs.setBool(_processImagesKey, value);
    notifyListeners();
  }

  /// Set output language for AI responses
  Future<void> setOutputLanguage(String language) async {
    if (_outputLanguage == language) return;
    _outputLanguage = language;
    await _prefs.setString(_outputLanguageKey, language);
    notifyListeners();
  }

  /// Set whether to include detailed examples in prompts
  Future<void> setIncludeDetailedExamples(bool value) async {
    if (_includeDetailedExamples == value) return;
    _includeDetailedExamples = value;
    await _prefs.setBool(_includeDetailedExamplesKey, value);
    notifyListeners();
  }

  /// Set whether to include book reasoning in sorting context
  Future<void> setIncludeBookReasoning(bool value) async {
    if (_includeBookReasoning == value) return;
    _includeBookReasoning = value;
    await _prefs.setBool(_includeBookReasoningKey, value);
    notifyListeners();
  }

  /// Set whether to include extended instructions
  Future<void> setIncludeExtendedInstructions(bool value) async {
    if (_includeExtendedInstructions == value) return;
    _includeExtendedInstructions = value;
    await _prefs.setBool(_includeExtendedInstructionsKey, value);
    notifyListeners();
  }

  /// Set whether to use incremental sorting
  Future<void> setUseIncrementalSort(bool value) async {
    if (_useIncrementalSort == value) return;
    _useIncrementalSort = value;
    await _prefs.setBool(_useIncrementalSortKey, value);
    notifyListeners();
  }

  // Ollama API parameters setters

  /// Set context window size (2048-32768)
  Future<void> setNumCtx(int value) async {
    final clampedValue = value.clamp(2048, 32768);
    if (_numCtx == clampedValue) return;
    _numCtx = clampedValue;
    await _prefs.setInt(_numCtxKey, clampedValue);
    notifyListeners();
  }

  /// Set maximum prediction tokens (128-4096, -1 for unlimited)
  Future<void> setNumPredict(int value) async {
    final clampedValue = value == -1 ? -1 : value.clamp(128, 4096);
    if (_numPredict == clampedValue) return;
    _numPredict = clampedValue;
    await _prefs.setInt(_numPredictKey, clampedValue);
    notifyListeners();
  }

  /// Set repeat penalty (0.0-2.0)
  Future<void> setRepeatPenalty(double value) async {
    final clampedValue = value.clamp(0.0, 2.0);
    if (_repeatPenalty == clampedValue) return;
    _repeatPenalty = clampedValue;
    await _prefs.setDouble(_repeatPenaltyKey, clampedValue);
    notifyListeners();
  }

  /// Set top-K value (1-100)
  Future<void> setTopK(int value) async {
    final clampedValue = value.clamp(1, 100);
    if (_topK == clampedValue) return;
    _topK = clampedValue;
    await _prefs.setInt(_topKKey, clampedValue);
    notifyListeners();
  }

  /// Set top-P value (0.0-1.0)
  Future<void> setTopP(double value) async {
    final clampedValue = value.clamp(0.0, 1.0);
    if (_topP == clampedValue) return;
    _topP = clampedValue;
    await _prefs.setDouble(_topPKey, clampedValue);
    notifyListeners();
  }

  /// Set batch size (32-1024)
  Future<void> setNumBatch(int value) async {
    final clampedValue = value.clamp(32, 1024);
    if (_numBatch == clampedValue) return;
    _numBatch = clampedValue;
    await _prefs.setInt(_numBatchKey, clampedValue);
    notifyListeners();
  }

  /// Set presence penalty (0.0-2.0)
  Future<void> setPresencePenalty(double value) async {
    final clampedValue = value.clamp(0.0, 2.0);
    if (_presencePenalty == clampedValue) return;
    _presencePenalty = clampedValue;
    await _prefs.setDouble(_presencePenaltyKey, clampedValue);
    notifyListeners();
  }

  /// Set frequency penalty (0.0-2.0)
  Future<void> setFrequencyPenalty(double value) async {
    final clampedValue = value.clamp(0.0, 2.0);
    if (_frequencyPenalty == clampedValue) return;
    _frequencyPenalty = clampedValue;
    await _prefs.setDouble(_frequencyPenaltyKey, clampedValue);
    notifyListeners();
  }

  /// Set min-p value (0.0-1.0)
  Future<void> setMinP(double value) async {
    final clampedValue = value.clamp(0.0, 1.0);
    if (_minP == clampedValue) return;
    _minP = clampedValue;
    await _prefs.setDouble(_minPKey, clampedValue);
    notifyListeners();
  }

  /// Set random seed (-1 for random)
  Future<void> setSeed(int value) async {
    if (_seed == value) return;
    _seed = value;
    await _prefs.setInt(_seedKey, value);
    notifyListeners();
  }

  /// Set stop sequences (comma-separated string)
  Future<void> setStopSequences(String value) async {
    if (_stopSequences == value) return;
    _stopSequences = value;
    await _prefs.setString(_stopSequencesKey, value);
    notifyListeners();
  }
}
