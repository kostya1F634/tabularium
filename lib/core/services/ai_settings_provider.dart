import 'package:flutter/widgets.dart';
import 'ai_settings_service.dart';

/// Provider widget for AI settings service
class AISettingsProvider extends InheritedNotifier<AISettingsService> {
  const AISettingsProvider({
    super.key,
    required AISettingsService aiSettings,
    required super.child,
  }) : super(notifier: aiSettings);

  static AISettingsService of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<AISettingsProvider>();
    assert(result != null, 'No AISettingsProvider found in context');
    return result!.notifier!;
  }
}
