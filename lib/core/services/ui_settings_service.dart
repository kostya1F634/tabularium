import 'package:flutter/foundation.dart';
import 'app_settings.dart';
import '../../l10n/app_localizations.dart';

/// Service for managing UI settings like font size and book scale
class UISettingsService extends ChangeNotifier {
  static const String _fontSizeKey = 'ui_font_size';
  static const String _bookScaleKey = 'ui_book_scale';
  static const String _bookScaleCabinetKey = 'ui_book_scale_cabinet';

  final AppSettings _prefs;
  double _fontSize;
  double _bookScale;
  double _bookScaleCabinet;

  UISettingsService(this._prefs)
    : _fontSize = _prefs.getDouble(_fontSizeKey) ?? 1.0,
      _bookScale = _prefs.getDouble(_bookScaleKey) ?? 1.0,
      _bookScaleCabinet = _prefs.getDouble(_bookScaleCabinetKey) ?? 1.0;

  /// Current font size multiplier (0.8 to 1.5)
  double get fontSize => _fontSize;

  /// Current book scale multiplier for grid mode (0.7 to 1.5)
  double get bookScale => _bookScale;

  /// Current book scale multiplier for cabinet mode (0.7 to 1.5)
  double get bookScaleCabinet => _bookScaleCabinet;

  /// Set font size multiplier
  Future<void> setFontSize(double size) async {
    if (_fontSize == size) return;
    _fontSize = size;
    await _prefs.setDouble(_fontSizeKey, size);
    notifyListeners();
  }

  /// Set book scale multiplier for grid mode
  Future<void> setBookScale(double scale) async {
    if (_bookScale == scale) return;
    _bookScale = scale;
    await _prefs.setDouble(_bookScaleKey, scale);
    notifyListeners();
  }

  /// Set book scale multiplier for cabinet mode
  Future<void> setBookScaleCabinet(double scale) async {
    if (_bookScaleCabinet == scale) return;
    _bookScaleCabinet = scale;
    await _prefs.setDouble(_bookScaleCabinetKey, scale);
    notifyListeners();
  }

  /// Get font size label
  static String getFontSizeLabel(AppLocalizations l10n, double size) {
    if (size <= 0.8) return l10n.sizeSmall;
    if (size <= 0.9) return l10n.sizeMedium;
    if (size <= 1.0) return l10n.sizeNormal;
    if (size <= 1.2) return l10n.sizeLarge;
    return l10n.sizeExtraLarge;
  }

  /// Get book scale label
  static String getBookScaleLabel(AppLocalizations l10n, double scale) {
    if (scale <= 0.7) return l10n.sizeTiny;
    if (scale <= 0.85) return l10n.sizeSmall;
    if (scale <= 1.0) return l10n.sizeNormal;
    if (scale <= 1.25) return l10n.sizeLarge;
    if (scale <= 1.5) return l10n.sizeExtraLarge;
    return l10n.sizeXXL;
  }
}
