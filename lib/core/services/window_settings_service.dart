import 'package:flutter/material.dart';
import 'app_settings.dart';
import 'package:window_manager/window_manager.dart';

/// Service for managing window size and position
class WindowSettingsService {
  static const String _windowXKey = 'window_x';
  static const String _windowYKey = 'window_y';
  static const String _windowWidthKey = 'window_width';
  static const String _windowHeightKey = 'window_height';

  final AppSettings _prefs;

  WindowSettingsService(this._prefs);

  /// Initialize window with saved settings or defaults
  Future<void> initializeWindow() async {
    await windowManager.ensureInitialized();

    // Note: Window position/size persistence is disabled on Linux due to
    // issues with window_manager plugin on GTK. The plugin doesn't properly
    // track window position changes on Linux.
    // See: https://github.com/leanflutter/window_manager/issues

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      center: true,
      minimumSize: Size(1280, 600),
      backgroundColor: Color(0xFF000000),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.center(); // Explicitly center window
      await windowManager.focus();
    });
  }

  /// Reset window settings to defaults
  Future<void> resetWindowSettings() async {
    // Window position/size persistence is disabled on Linux
    // This method kept for API compatibility
    await _prefs.remove(_windowXKey);
    await _prefs.remove(_windowYKey);
    await _prefs.remove(_windowWidthKey);
    await _prefs.remove(_windowHeightKey);
  }
}
