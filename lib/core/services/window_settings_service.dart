import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

/// Service for managing window size and position
class WindowSettingsService {
  static const String _windowXKey = 'window_x';
  static const String _windowYKey = 'window_y';
  static const String _windowWidthKey = 'window_width';
  static const String _windowHeightKey = 'window_height';

  final SharedPreferences _prefs;

  WindowSettingsService(this._prefs);

  /// Initialize window with saved settings or defaults
  Future<void> initializeWindow() async {
    await windowManager.ensureInitialized();

    final windowX = _prefs.getDouble(_windowXKey);
    final windowY = _prefs.getDouble(_windowYKey);
    final windowWidth = _prefs.getDouble(_windowWidthKey) ?? 1280.0;
    final windowHeight = _prefs.getDouble(_windowHeightKey) ?? 720.0;

    WindowOptions windowOptions = WindowOptions(
      size: Size(windowWidth, windowHeight),
      center: windowX == null || windowY == null,
      minimumSize: const Size(1280, 600),
      backgroundColor: const Color(0xFF000000),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      if (windowX != null && windowY != null) {
        await windowManager.setPosition(Offset(windowX, windowY));
      }
      await windowManager.show();
      await windowManager.focus();
    });

    // Listen to window move/resize events
    windowManager.addListener(_WindowListener(_prefs));
  }

  /// Reset window settings to defaults
  Future<void> resetWindowSettings() async {
    await _prefs.remove(_windowXKey);
    await _prefs.remove(_windowYKey);
    await _prefs.remove(_windowWidthKey);
    await _prefs.remove(_windowHeightKey);
  }
}

class _WindowListener extends WindowListener {
  final SharedPreferences _prefs;

  _WindowListener(this._prefs);

  @override
  void onWindowMoved() async {
    final position = await windowManager.getPosition();
    await _prefs.setDouble(WindowSettingsService._windowXKey, position.dx);
    await _prefs.setDouble(WindowSettingsService._windowYKey, position.dy);
  }

  @override
  void onWindowResized() async {
    final size = await windowManager.getSize();
    await _prefs.setDouble(WindowSettingsService._windowWidthKey, size.width);
    await _prefs.setDouble(WindowSettingsService._windowHeightKey, size.height);
  }
}
