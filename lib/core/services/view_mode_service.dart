import 'package:shared_preferences/shared_preferences.dart';

import '../../features/library/presentation/pages/library_view_wrapper.dart';

/// Service to persist and retrieve the last used view mode
class ViewModeService {
  static const String _viewModeKey = 'view_mode';
  final SharedPreferences _prefs;

  ViewModeService(this._prefs);

  /// Get the last used view mode
  LibraryViewMode getViewMode() {
    final modeString = _prefs.getString(_viewModeKey);
    if (modeString == 'cabinet') {
      return LibraryViewMode.cabinet;
    }
    return LibraryViewMode.grid;
  }

  /// Save the current view mode
  Future<void> setViewMode(LibraryViewMode mode) async {
    final modeString = mode == LibraryViewMode.cabinet ? 'cabinet' : 'grid';
    await _prefs.setString(_viewModeKey, modeString);
  }

  /// Reset to default view mode
  Future<void> resetViewMode() async {
    await _prefs.remove(_viewModeKey);
  }
}
