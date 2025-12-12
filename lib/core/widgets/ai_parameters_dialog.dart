import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import '../services/ai_settings_service.dart';
import 'dialog_shortcuts_wrapper.dart';

/// Dialog for configuring Ollama API parameters
class AIParametersDialog extends StatefulWidget {
  final int initialNumCtx;
  final int initialNumPredict;
  final double initialRepeatPenalty;
  final int initialTopK;
  final double initialTopP;
  final int initialNumBatch;
  final double initialPresencePenalty;
  final double initialFrequencyPenalty;
  final double initialMinP;
  final int initialSeed;
  final String initialStopSequences;
  final AISettingsService aiSettingsService;

  const AIParametersDialog({
    super.key,
    required this.initialNumCtx,
    required this.initialNumPredict,
    required this.initialRepeatPenalty,
    required this.initialTopK,
    required this.initialTopP,
    required this.initialNumBatch,
    required this.initialPresencePenalty,
    required this.initialFrequencyPenalty,
    required this.initialMinP,
    required this.initialSeed,
    required this.initialStopSequences,
    required this.aiSettingsService,
  });

  @override
  State<AIParametersDialog> createState() => _AIParametersDialogState();
}

class _AIParametersDialogState extends State<AIParametersDialog> {
  late TextEditingController _numCtxController;
  late TextEditingController _numPredictController;
  late TextEditingController _repeatPenaltyController;
  late TextEditingController _topKController;
  late TextEditingController _topPController;
  late TextEditingController _numBatchController;
  late TextEditingController _presencePenaltyController;
  late TextEditingController _frequencyPenaltyController;
  late TextEditingController _minPController;
  late TextEditingController _seedController;
  late TextEditingController _stopSequencesController;

  @override
  void initState() {
    super.initState();
    _numCtxController = TextEditingController(
      text: widget.initialNumCtx.toString(),
    );
    _numPredictController = TextEditingController(
      text: widget.initialNumPredict.toString(),
    );
    _repeatPenaltyController = TextEditingController(
      text: widget.initialRepeatPenalty.toStringAsFixed(1),
    );
    _topKController = TextEditingController(
      text: widget.initialTopK.toString(),
    );
    _topPController = TextEditingController(
      text: widget.initialTopP.toStringAsFixed(1),
    );
    _numBatchController = TextEditingController(
      text: widget.initialNumBatch.toString(),
    );
    _presencePenaltyController = TextEditingController(
      text: widget.initialPresencePenalty.toStringAsFixed(1),
    );
    _frequencyPenaltyController = TextEditingController(
      text: widget.initialFrequencyPenalty.toStringAsFixed(1),
    );
    _minPController = TextEditingController(
      text: widget.initialMinP.toStringAsFixed(1),
    );
    _seedController = TextEditingController(
      text: widget.initialSeed.toString(),
    );
    _stopSequencesController = TextEditingController(
      text: widget.initialStopSequences,
    );
  }

  @override
  void dispose() {
    _numCtxController.dispose();
    _numPredictController.dispose();
    _repeatPenaltyController.dispose();
    _topKController.dispose();
    _topPController.dispose();
    _numBatchController.dispose();
    _presencePenaltyController.dispose();
    _frequencyPenaltyController.dispose();
    _minPController.dispose();
    _seedController.dispose();
    _stopSequencesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final numCtx = int.tryParse(_numCtxController.text) ?? 8192;
    final numPredict = int.tryParse(_numPredictController.text) ?? 1000;
    final repeatPenalty = double.tryParse(_repeatPenaltyController.text) ?? 1.1;
    final topK = int.tryParse(_topKController.text) ?? 40;
    final topP = double.tryParse(_topPController.text) ?? 0.9;
    final numBatch = int.tryParse(_numBatchController.text) ?? 512;
    final presencePenalty =
        double.tryParse(_presencePenaltyController.text) ?? 0.0;
    final frequencyPenalty =
        double.tryParse(_frequencyPenaltyController.text) ?? 0.0;
    final minP = double.tryParse(_minPController.text) ?? 0.0;
    final seed = int.tryParse(_seedController.text) ?? -1;
    final stopSequences = _stopSequencesController.text;

    await widget.aiSettingsService.setNumCtx(numCtx);
    await widget.aiSettingsService.setNumPredict(numPredict);
    await widget.aiSettingsService.setRepeatPenalty(repeatPenalty);
    await widget.aiSettingsService.setTopK(topK);
    await widget.aiSettingsService.setTopP(topP);
    await widget.aiSettingsService.setNumBatch(numBatch);
    await widget.aiSettingsService.setPresencePenalty(presencePenalty);
    await widget.aiSettingsService.setFrequencyPenalty(frequencyPenalty);
    await widget.aiSettingsService.setMinP(minP);
    await widget.aiSettingsService.setSeed(seed);
    await widget.aiSettingsService.setStopSequences(stopSequences);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _resetDefaults() {
    setState(() {
      _numCtxController.text = '8192';
      _numPredictController.text = '1000';
      _repeatPenaltyController.text = '1.1';
      _topKController.text = '40';
      _topPController.text = '0.9';
      _numBatchController.text = '512';
      _presencePenaltyController.text = '0.0';
      _frequencyPenaltyController.text = '0.0';
      _minPController.text = '0.0';
      _seedController.text = '-1';
      _stopSequencesController.text = '';
    });
  }

  Widget _buildParameterField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String helperText,
    required String effectText,
    required TextInputType keyboardType,
    required List<TextInputFormatter> inputFormatters,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            helperText: helperText,
            helperMaxLines: 3,
            border: const OutlineInputBorder(),
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
        ),
        const SizedBox(height: 4),
        Text(
          effectText,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DialogShortcutsWrapper(
      onEnterKey: _save,
      dialog: AlertDialog(
        title: Text(l10n.ollamaParameters),
        content: SizedBox(
          width: 1200,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Three-column layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Column 1: Context & Output
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.contextParameters,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _numCtxController,
                            label: l10n.numCtx,
                            hint: '8192',
                            helperText: l10n.numCtxHint,
                            effectText: l10n.numCtxEffect,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = int.tryParse(newValue.text);
                                if (value == null ||
                                    value < 2048 ||
                                    value > 32768) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _numPredictController,
                            label: l10n.numPredict,
                            hint: '1000',
                            helperText: l10n.numPredictHint,
                            effectText: l10n.numPredictEffect,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^-?\d*'),
                              ),
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty ||
                                    newValue.text == '-') {
                                  return newValue;
                                }
                                final value = int.tryParse(newValue.text);
                                if (value == null) return oldValue;
                                if (value == -1) return newValue;
                                if (value < 128 || value > 4096) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _numBatchController,
                            label: l10n.numBatch,
                            hint: '512',
                            helperText: l10n.numBatchHint,
                            effectText: l10n.numBatchEffect,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = int.tryParse(newValue.text);
                                if (value == null ||
                                    value < 32 ||
                                    value > 1024) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),

                    // Column 2: Sampling & Creativity
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.samplingParameters,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _topKController,
                            label: l10n.topK,
                            hint: '40',
                            helperText: l10n.topKHint,
                            effectText: l10n.topKEffect,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = int.tryParse(newValue.text);
                                if (value == null || value < 1 || value > 100) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _topPController,
                            label: l10n.topP,
                            hint: '0.9',
                            helperText: l10n.topPHint,
                            effectText: l10n.topPEffect,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'),
                              ),
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = double.tryParse(newValue.text);
                                if (value == null || value < 0.0 || value > 1.0)
                                  return oldValue;
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _minPController,
                            label: l10n.minP,
                            hint: '0.0',
                            helperText: l10n.minPHint,
                            effectText: l10n.minPEffect,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'),
                              ),
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = double.tryParse(newValue.text);
                                if (value == null ||
                                    value < 0.0 ||
                                    value > 1.0) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _seedController,
                            label: l10n.seed,
                            hint: '-1',
                            helperText: l10n.seedHint,
                            effectText: l10n.seedEffect,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^-?\d*'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),

                    // Column 3: Penalties & Control
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.penaltyParameters,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _repeatPenaltyController,
                            label: l10n.repeatPenalty,
                            hint: '1.1',
                            helperText: l10n.repeatPenaltyHint,
                            effectText: l10n.repeatPenaltyEffect,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'),
                              ),
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = double.tryParse(newValue.text);
                                if (value == null ||
                                    value < 0.0 ||
                                    value > 2.0) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _presencePenaltyController,
                            label: l10n.presencePenalty,
                            hint: '0.0',
                            helperText: l10n.presencePenaltyHint,
                            effectText: l10n.presencePenaltyEffect,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'),
                              ),
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = double.tryParse(newValue.text);
                                if (value == null ||
                                    value < 0.0 ||
                                    value > 2.0) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _frequencyPenaltyController,
                            label: l10n.frequencyPenalty,
                            hint: '0.0',
                            helperText: l10n.frequencyPenaltyHint,
                            effectText: l10n.frequencyPenaltyEffect,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'),
                              ),
                              TextInputFormatter.withFunction((
                                oldValue,
                                newValue,
                              ) {
                                if (newValue.text.isEmpty) return newValue;
                                final value = double.tryParse(newValue.text);
                                if (value == null ||
                                    value < 0.0 ||
                                    value > 2.0) {
                                  return oldValue;
                                }
                                return newValue;
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildParameterField(
                            controller: _stopSequencesController,
                            label: l10n.stopSequences,
                            hint: r'\n\n\n,```,---',
                            helperText: l10n.stopSequencesHint,
                            effectText: l10n.stopSequencesEffect,
                            keyboardType: TextInputType.text,
                            inputFormatters: [],
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Reset button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _resetDefaults,
                    icon: const Icon(Icons.restore),
                    label: Text(l10n.resetDefaults),
                  ),
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
