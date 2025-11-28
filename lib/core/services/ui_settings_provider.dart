import 'package:flutter/widgets.dart';
import 'ui_settings_service.dart';

/// InheritedWidget for providing UISettingsService
class UISettingsProvider extends InheritedWidget {
  final UISettingsService uiSettingsService;

  const UISettingsProvider({
    super.key,
    required this.uiSettingsService,
    required super.child,
  });

  static UISettingsService of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<UISettingsProvider>();
    assert(provider != null, 'No UISettingsProvider found in context');
    return provider!.uiSettingsService;
  }

  @override
  bool updateShouldNotify(UISettingsProvider oldWidget) {
    return uiSettingsService != oldWidget.uiSettingsService;
  }
}
