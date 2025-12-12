import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import '../services/ai_settings_service.dart';
import '../services/ollama_client.dart';
import 'dialog_shortcuts_wrapper.dart';

/// Dialog for AI settings configuration
class AISettingsDialog extends StatefulWidget {
  final String initialUrl;
  final String initialModel;
  final double initialGeneralization;
  final int initialMaxPages;
  final bool initialProcessImages;
  final String initialOutputLanguage;
  final bool initialIncludeDetailedExamples;
  final bool initialIncludeBookReasoning;
  final bool initialIncludeExtendedInstructions;
  final bool initialUseIncrementalSort;
  final AISettingsService aiSettingsService;

  const AISettingsDialog({
    super.key,
    required this.initialUrl,
    required this.initialModel,
    required this.initialGeneralization,
    required this.initialMaxPages,
    required this.initialProcessImages,
    required this.initialOutputLanguage,
    required this.initialIncludeDetailedExamples,
    required this.initialIncludeBookReasoning,
    required this.initialIncludeExtendedInstructions,
    required this.initialUseIncrementalSort,
    required this.aiSettingsService,
  });

  @override
  State<AISettingsDialog> createState() => _AISettingsDialogState();
}

class _AISettingsDialogState extends State<AISettingsDialog> {
  late TextEditingController _urlController;
  late TextEditingController _modelController;
  late TextEditingController _generalizationController;
  late TextEditingController _maxPagesController;
  late bool _processImages;
  late String _outputLanguage;
  late bool _includeDetailedExamples;
  late bool _includeBookReasoning;
  late bool _includeExtendedInstructions;
  late bool _useIncrementalSort;
  String? _connectionStatus;
  bool _testing = false;
  bool _testingLanguage = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.initialUrl);
    _modelController = TextEditingController(text: widget.initialModel);
    _generalizationController = TextEditingController(
      text: (widget.initialGeneralization * 100).round().toString(),
    );
    _maxPagesController = TextEditingController(
      text: widget.initialMaxPages.toString(),
    );
    _processImages = widget.initialProcessImages;
    _outputLanguage = widget.initialOutputLanguage;
    _includeDetailedExamples = widget.initialIncludeDetailedExamples;
    _includeBookReasoning = widget.initialIncludeBookReasoning;
    _includeExtendedInstructions = widget.initialIncludeExtendedInstructions;
    _useIncrementalSort = widget.initialUseIncrementalSort;
  }

  @override
  void dispose() {
    _urlController.dispose();
    _modelController.dispose();
    _generalizationController.dispose();
    _maxPagesController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    setState(() {
      _testing = true;
      _connectionStatus = null;
    });

    final client = OllamaClient(
      baseUrl: _urlController.text,
      model: _modelController.text,
    );

    final success = await client.testConnection();
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _testing = false;
      _connectionStatus = success
          ? l10n.connectionSuccess
          : l10n.connectionFailed;
    });
  }

  Future<void> _testLanguage() async {
    setState(() {
      _testingLanguage = true;
    });

    final client = OllamaClient(
      baseUrl: _urlController.text,
      model: _modelController.text,
    );

    final languageNames = {'en': 'English', 'ru': 'Russian'};

    final languageName = languageNames[_outputLanguage] ?? _outputLanguage;

    try {
      final response = await client.generate(
        prompt:
            'Please write 2-3 sentences about your capabilities in $languageName language. Respond ONLY in $languageName.',
        temperature: 0.7,
      );

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.languageTestResult),
            content: SingleChildScrollView(child: Text(response)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.ok),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.error),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.ok),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _testingLanguage = false;
        });
      }
    }
  }

  Future<void> _save() async {
    // Parse generalization (0-100) to 0.0-1.0
    final generalizationValue =
        int.tryParse(_generalizationController.text) ?? 50;
    final generalization = (generalizationValue.clamp(0, 100) / 100.0);

    // Parse max pages (1-50)
    final maxPages = int.tryParse(_maxPagesController.text) ?? 3;

    await widget.aiSettingsService.setOllamaUrl(_urlController.text);
    await widget.aiSettingsService.setOllamaModel(_modelController.text);
    await widget.aiSettingsService.setGeneralization(generalization);
    await widget.aiSettingsService.setMaxPages(maxPages);
    await widget.aiSettingsService.setProcessImages(_processImages);
    await widget.aiSettingsService.setOutputLanguage(_outputLanguage);
    await widget.aiSettingsService.setIncludeDetailedExamples(
      _includeDetailedExamples,
    );
    await widget.aiSettingsService.setIncludeBookReasoning(
      _includeBookReasoning,
    );
    await widget.aiSettingsService.setIncludeExtendedInstructions(
      _includeExtendedInstructions,
    );
    await widget.aiSettingsService.setUseIncrementalSort(_useIncrementalSort);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DialogShortcutsWrapper(
      onEnterKey: _save,
      dialog: AlertDialog(
        title: Text(l10n.aiSettings),
        content: SizedBox(
          width: 800,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Connection settings (full width)
                TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    labelText: l10n.ollamaUrl,
                    hintText: 'http://127.0.0.1:11434',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _modelController,
                  decoration: InputDecoration(
                    labelText: l10n.ollamaModel,
                    hintText: 'deepseek-r1:1.5b',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Test connection button
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _testing ? null : _testConnection,
                      icon: _testing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.cable, size: 18),
                      label: Text(l10n.testConnection),
                    ),
                    if (_connectionStatus != null) ...[
                      const SizedBox(width: 16),
                      Text(
                        _connectionStatus!,
                        style: TextStyle(
                          color: _connectionStatus == l10n.connectionSuccess
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),

                // Two columns layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Generalization (0-100)
                          TextField(
                            controller: _generalizationController,
                            decoration: InputDecoration(
                              labelText: l10n.generalization,
                              hintText: '50',
                              helperText: l10n.generalizationHint,
                              border: const OutlineInputBorder(),
                              suffixText: '%',
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = int.tryParse(newValue.text);
                                if (value == null || value > 100)
                                  return oldValue;
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Max pages (1-50)
                          TextField(
                            controller: _maxPagesController,
                            decoration: InputDecoration(
                              labelText: l10n.maxPages,
                              hintText: '3',
                              helperText: l10n.maxPagesHint,
                              border: const OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = int.tryParse(newValue.text);
                                if (value == null || value < 1 || value > 50)
                                  return oldValue;
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Process Images checkbox
                          CheckboxListTile(
                            value: _processImages,
                            onChanged: (value) {
                              setState(() {
                                _processImages = value ?? false;
                              });
                            },
                            title: Text(l10n.processImages),
                            subtitle: Text(
                              l10n.processImagesHint,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Right column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Output Language dropdown
                          DropdownButtonFormField<String>(
                            value: _outputLanguage,
                            decoration: InputDecoration(
                              labelText: l10n.outputLanguage,
                              helperText: l10n.outputLanguageHint,
                              border: const OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'ru',
                                child: Text('Русский'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _outputLanguage = value;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),

                          // Test Language button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _testingLanguage
                                  ? null
                                  : _testLanguage,
                              icon: _testingLanguage
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.translate),
                              label: Text(l10n.testLanguage),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Token Optimization section
                Text(
                  'Token Optimization',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Include Detailed Examples checkbox
                CheckboxListTile(
                  value: _includeDetailedExamples,
                  onChanged: (value) {
                    setState(() {
                      _includeDetailedExamples = value ?? true;
                    });
                  },
                  title: Text(l10n.includeDetailedExamples),
                  subtitle: Text(
                    l10n.includeDetailedExamplesHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),

                // Include Book Reasoning checkbox
                CheckboxListTile(
                  value: _includeBookReasoning,
                  onChanged: (value) {
                    setState(() {
                      _includeBookReasoning = value ?? true;
                    });
                  },
                  title: Text(l10n.includeBookReasoning),
                  subtitle: Text(
                    l10n.includeBookReasoningHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),

                // Include Extended Instructions checkbox
                CheckboxListTile(
                  value: _includeExtendedInstructions,
                  onChanged: (value) {
                    setState(() {
                      _includeExtendedInstructions = value ?? true;
                    });
                  },
                  title: Text(l10n.includeExtendedInstructions),
                  subtitle: Text(
                    l10n.includeExtendedInstructionsHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),

                // Use Incremental Sort checkbox
                CheckboxListTile(
                  value: _useIncrementalSort,
                  onChanged: (value) {
                    setState(() {
                      _useIncrementalSort = value ?? false;
                    });
                  },
                  title: Text(l10n.useIncrementalSort),
                  subtitle: Text(
                    l10n.useIncrementalSortHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(onPressed: _save, child: Text(l10n.save)),
        ],
      ),
    );
  }
}
