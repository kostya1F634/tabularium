// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Ihre Persönliche Bibliothek';

  @override
  String get selectBooksDirectory => 'Ordner Auswählen';

  @override
  String get recentDirectories => 'Zuletzt Verwendet';

  @override
  String get favorites => 'Favoriten';

  @override
  String get clearRecent => 'Zuletzt Löschen';

  @override
  String get clearFavorites => 'Favoriten Löschen';

  @override
  String get addToFavorites => 'Zu Favoriten';

  @override
  String get removeFromFavorites => 'Aus Favoriten';

  @override
  String get directoryNotFound => 'Ordner nicht gefunden';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Der Ordner \"$path\" existiert nicht mehr oder ist nicht zugänglich. Er wurde aus den zuletzt verwendeten entfernt.';
  }

  @override
  String get mainScreen => 'Hauptbildschirm';

  @override
  String get selectedDirectory => 'Ausgewählter Ordner:';

  @override
  String get error => 'Fehler';

  @override
  String errorMessage(String message) {
    return 'Fehler: $message';
  }

  @override
  String get retry => 'Wiederholen';

  @override
  String get loading => 'Laden...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get allBooks => 'Alle Bücher';

  @override
  String get unsortedBooks => 'Unsortiert';

  @override
  String get shelves => 'Regale';

  @override
  String get createShelf => 'Regal Erstellen';

  @override
  String get editShelf => 'Regal Bearbeiten';

  @override
  String get shelfName => 'Regalname';

  @override
  String get deleteShelf => 'Regal Löschen';

  @override
  String get openAllBooks => 'Alle Öffnen';

  @override
  String get searchBooks => 'Bücher suchen...';

  @override
  String get searchShelves => 'Regale suchen...';

  @override
  String get noBooks => 'Keine Bücher gefunden';

  @override
  String get noBooksInShelf => 'Regal ist leer';

  @override
  String get scanForNewBooks => 'Neue Scannen';

  @override
  String get scan => 'Scannen';

  @override
  String get initializingLibrary => 'Initialisierung...';

  @override
  String get loadingLibrary => 'Laden...';

  @override
  String get backToWelcome => 'Zurück';

  @override
  String get addToShelf => 'Zu Regal Hinzufügen';

  @override
  String get removeFromShelf => 'Aus Regal Entfernen';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bücher',
      one: '1 Buch',
      zero: 'Keine Bücher',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get create => 'Erstellen';

  @override
  String get delete => 'Löschen';

  @override
  String get selected => 'ausgewählt';

  @override
  String get openSelected => 'Auswahl Öffnen';

  @override
  String get selectAll => 'Alles Auswählen';

  @override
  String get clearSelection => 'Auswahl Aufheben';

  @override
  String get deleteFromShelf => 'Aus Regal Löschen';

  @override
  String get remove => 'Entfernen';

  @override
  String get open => 'Öffnen';

  @override
  String get properties => 'Eigenschaften';

  @override
  String get bookProperties => 'Bucheigenschaften';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Dateipfad';

  @override
  String get author => 'Autor';

  @override
  String get title => 'Titel';

  @override
  String get pageCount => 'Seiten';

  @override
  String get fileSize => 'Dateigröße';

  @override
  String get save => 'Speichern';

  @override
  String get shortcuts => 'Tastenkürzel';

  @override
  String get keyboardShortcuts => 'Tastaturkürzel';

  @override
  String get deleteBook => 'Löschen';

  @override
  String get deleteSelected => 'Auswahl Löschen';

  @override
  String get deleteAll => 'Alles Löschen';

  @override
  String get confirmDeleteBook => 'Buch Löschen?';

  @override
  String get confirmDeleteBookMessage =>
      'Die Datei wird dauerhaft gelöscht. Aktion unwiderruflich.';

  @override
  String get confirmDeleteSelected => 'Auswahl Löschen?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien werden',
      one: 'Datei wird',
    );
    return '$count $_temp0 dauerhaft gelöscht. Aktion unwiderruflich.';
  }

  @override
  String get confirmDeleteAll => 'Alles Löschen?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien',
      one: 'Datei',
    );
    return 'Alle $count $_temp0 dieses Regals werden dauerhaft gelöscht. Aktion unwiderruflich.';
  }

  @override
  String get aboutTabularium => 'Über Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Ansicht Wechseln';

  @override
  String get theme => 'Design';

  @override
  String get help => 'Hilfe';

  @override
  String get about => 'Über';

  @override
  String get resetSettings => 'Zurücksetzen';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get bookScaleGrid => 'Skalierung (Raster)';

  @override
  String get bookScaleCabinet => 'Skalierung (Regal)';

  @override
  String get add => 'Hinzufügen';

  @override
  String get selectShelf => 'Regal Auswählen';

  @override
  String get sortDateAddedNewest => 'Hinzugefügt ↓';

  @override
  String get sortDateAddedOldest => 'Hinzugefügt ↑';

  @override
  String get sortDateOpenedNewest => 'Geöffnet ↓';

  @override
  String get sortDateOpenedOldest => 'Geöffnet ↑';

  @override
  String get sortTitleAZ => 'Titel A-Z';

  @override
  String get sortTitleZA => 'Titel Z-A';

  @override
  String get searchThemes => 'Themen suchen...';

  @override
  String get sizeSmall => 'Klein';

  @override
  String get sizeMedium => 'Mittel';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Groß';

  @override
  String get sizeExtraLarge => 'Sehr groß';

  @override
  String get sizeTiny => 'Sehr klein';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Allgemein';

  @override
  String get shortcutsNavigationShelves => 'Navigation - Regale';

  @override
  String get shortcutsNavigationBooks => 'Navigation - Bücher';

  @override
  String get shortcutsShelves => 'Regale';

  @override
  String get shortcutsBooks => 'Bücher';

  @override
  String get shortcutToggleScreen =>
      'Zwischen Bibliothek und Startbildschirm wechseln';

  @override
  String get shortcutCreateShelf => 'Neues Regal erstellen';

  @override
  String get shortcutOpenBooks => 'Bücher öffnen (alle oder ausgewählte)';

  @override
  String get shortcutSelectAll => 'Alle Bücher auswählen';

  @override
  String get shortcutClearSelection => 'Auswahl aufheben';

  @override
  String get shortcutQuickShelf => 'Schnellauswahl Regal (erste 10)';

  @override
  String get shortcutEdit => 'Regal bearbeiten / Bucheigenschaften';

  @override
  String get shortcutToggleView => 'Ansichtsmodus wechseln (Raster/Regal)';

  @override
  String get shortcutAddToShelf =>
      'Bücher zu Regal hinzufügen (ausgewählt/fokussiert/alle)';

  @override
  String get shortcutFocusCenter => 'Mittleres sichtbares Buch fokussieren';

  @override
  String get shortcutJumpFirst => 'Zum ersten Regal/Buch springen';

  @override
  String get shortcutJumpLast => 'Zum letzten Regal/Buch springen';

  @override
  String get shortcutFocusSearch => 'Suchfeld fokussieren/aufheben';

  @override
  String get shortcutSwitchFocus =>
      'Fokus zwischen Regalen und Büchern wechseln';

  @override
  String get shortcutMoveDown => 'Nach unten bewegen';

  @override
  String get shortcutMoveUp => 'Nach oben bewegen';

  @override
  String get shortcutMoveLeft => 'Nach links bewegen';

  @override
  String get shortcutMoveRight => 'Nach rechts bewegen';

  @override
  String get shortcutMoveShelfDown => 'Regal nach unten bewegen';

  @override
  String get shortcutMoveShelfUp => 'Regal nach oben bewegen';

  @override
  String get shortcutDeleteShelf => 'Regal löschen';

  @override
  String get shortcutOpenFocused => 'Fokussiertes Buch öffnen';

  @override
  String get shortcutToggleSelection =>
      'Auswahl des fokussierten Buchs umschalten';

  @override
  String get shortcutRemoveFromShelf =>
      'Ausgewählte Bücher aus Regal entfernen';
}
