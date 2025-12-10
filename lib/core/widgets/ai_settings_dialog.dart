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
  final AISettingsService aiSettingsService;

  const AISettingsDialog({
    super.key,
    required this.initialUrl,
    required this.initialModel,
    required this.initialGeneralization,
    required this.initialMaxPages,
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
  String? _connectionStatus;
  bool _testing = false;

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
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ollama URL
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: l10n.ollamaUrl,
                  hintText: 'http://127.0.0.1:11434',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Ollama Model
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
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) return newValue;
                    final value = int.tryParse(newValue.text);
                    if (value == null || value > 100) return oldValue;
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
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) return newValue;
                    final value = int.tryParse(newValue.text);
                    if (value == null || value < 1 || value > 50)
                      return oldValue;
                    return newValue;
                  }),
                ],
              ),
            ],
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
