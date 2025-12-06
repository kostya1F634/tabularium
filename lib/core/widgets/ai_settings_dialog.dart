import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../services/ai_settings_service.dart';
import '../services/ollama_client.dart';
import 'dialog_shortcuts_wrapper.dart';

/// Dialog for AI settings configuration
class AISettingsDialog extends StatefulWidget {
  final String initialUrl;
  final String initialModel;
  final double initialGeneralization;
  final AISettingsService aiSettingsService;

  const AISettingsDialog({
    super.key,
    required this.initialUrl,
    required this.initialModel,
    required this.initialGeneralization,
    required this.aiSettingsService,
  });

  @override
  State<AISettingsDialog> createState() => _AISettingsDialogState();
}

class _AISettingsDialogState extends State<AISettingsDialog> {
  late TextEditingController _urlController;
  late TextEditingController _modelController;
  late double _generalization;
  String? _connectionStatus;
  bool _testing = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.initialUrl);
    _modelController = TextEditingController(text: widget.initialModel);
    _generalization = widget.initialGeneralization;
  }

  @override
  void dispose() {
    _urlController.dispose();
    _modelController.dispose();
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
    await widget.aiSettingsService.setOllamaUrl(_urlController.text);
    await widget.aiSettingsService.setOllamaModel(_modelController.text);
    await widget.aiSettingsService.setGeneralization(_generalization);

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

              // Generalization slider
              Text(
                l10n.generalization,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Slider(
                value: _generalization,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: _generalization.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    _generalization = value;
                  });
                },
              ),
              Text(
                l10n.generalizationHint,
                style: Theme.of(context).textTheme.bodySmall,
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
