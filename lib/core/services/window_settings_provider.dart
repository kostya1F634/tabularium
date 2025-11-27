import 'package:flutter/widgets.dart';
import 'window_settings_service.dart';

/// InheritedWidget for providing WindowSettingsService
class WindowSettingsProvider extends InheritedWidget {
  final WindowSettingsService windowSettingsService;

  const WindowSettingsProvider({
    super.key,
    required this.windowSettingsService,
    required super.child,
  });

  static WindowSettingsService of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<WindowSettingsProvider>();
    assert(provider != null, 'No WindowSettingsProvider found in context');
    return provider!.windowSettingsService;
  }

  @override
  bool updateShouldNotify(WindowSettingsProvider oldWidget) {
    return windowSettingsService != oldWidget.windowSettingsService;
  }
}
