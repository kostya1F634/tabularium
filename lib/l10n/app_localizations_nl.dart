// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Uw Persoonlijke Bibliotheek';

  @override
  String get selectBooksDirectory => 'Map Selecteren';

  @override
  String get recentDirectories => 'Recente';

  @override
  String get favorites => 'Favorieten';

  @override
  String get clearRecent => 'Recente Wissen';

  @override
  String get clearFavorites => 'Favorieten Wissen';

  @override
  String get addToFavorites => 'Aan Favorieten';

  @override
  String get removeFromFavorites => 'Uit Favorieten';

  @override
  String get directoryNotFound => 'Map niet gevonden';

  @override
  String directoryNotFoundMessage(String path) {
    return 'De map \"$path\" bestaat niet meer of is niet toegankelijk. Het is verwijderd uit recente.';
  }

  @override
  String get mainScreen => 'Hoofdscherm';

  @override
  String get selectedDirectory => 'Geselecteerde map:';

  @override
  String get error => 'Fout';

  @override
  String errorMessage(String message) {
    return 'Fout: $message';
  }

  @override
  String get retry => 'Opnieuw';

  @override
  String get loading => 'Laden...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Instellingen';

  @override
  String get language => 'Taal';

  @override
  String get allBooks => 'Alle Boeken';

  @override
  String get unsortedBooks => 'Ongesorteerd';

  @override
  String get shelves => 'Planken';

  @override
  String get createShelf => 'Plank Maken';

  @override
  String get editShelf => 'Plank Bewerken';

  @override
  String get shelfName => 'Planknaam';

  @override
  String get deleteShelf => 'Plank Verwijderen';

  @override
  String get openAllBooks => 'Alles Openen';

  @override
  String get searchBooks => 'Boeken zoeken...';

  @override
  String get searchShelves => 'Planken zoeken...';

  @override
  String get noBooks => 'Geen boeken gevonden';

  @override
  String get noBooksInShelf => 'Plank is leeg';

  @override
  String get scanForNewBooks => 'Nieuwe Scannen';

  @override
  String get scan => 'Scannen';

  @override
  String get initializingLibrary => 'Initialiseren...';

  @override
  String get loadingLibrary => 'Laden...';

  @override
  String get backToWelcome => 'Terug';

  @override
  String get addToShelf => 'Aan Plank Toevoegen';

  @override
  String get removeFromShelf => 'Van Plank Verwijderen';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count boeken',
      one: '1 boek',
      zero: 'Geen boeken',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Annuleren';

  @override
  String get create => 'Maken';

  @override
  String get delete => 'Verwijderen';

  @override
  String get selected => 'geselecteerd';

  @override
  String get openSelected => 'Selectie Openen';

  @override
  String get selectAll => 'Alles Selecteren';

  @override
  String get clearSelection => 'Selectie Wissen';

  @override
  String get deleteFromShelf => 'Van Plank Verwijderen';

  @override
  String get remove => 'Verwijderen';

  @override
  String get open => 'Openen';

  @override
  String get properties => 'Eigenschappen';

  @override
  String get bookProperties => 'Boekeigenschappen';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Bestandspad';

  @override
  String get author => 'Auteur';

  @override
  String get title => 'Titel';

  @override
  String get pageCount => 'Pagina\'s';

  @override
  String get fileSize => 'Bestandsgrootte';

  @override
  String get save => 'Opslaan';

  @override
  String get shortcuts => 'Sneltoetsen';

  @override
  String get keyboardShortcuts => 'Toetsenbordsneltoetsen';

  @override
  String get deleteBook => 'Verwijderen';

  @override
  String get deleteSelected => 'Selectie Verwijderen';

  @override
  String get deleteAll => 'Alles Verwijderen';

  @override
  String get confirmDeleteBook => 'Boek Verwijderen?';

  @override
  String get confirmDeleteBookMessage =>
      'Het bestand wordt permanent verwijderd. Actie onomkeerbaar.';

  @override
  String get confirmDeleteSelected => 'Selectie Verwijderen?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bestanden worden',
      one: 'bestand wordt',
    );
    return '$count $_temp0 permanent verwijderd. Actie onomkeerbaar.';
  }

  @override
  String get confirmDeleteAll => 'Alles Verwijderen?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bestanden',
      one: 'bestand',
    );
    return 'Alle $count $_temp0 van deze plank worden permanent verwijderd. Actie onomkeerbaar.';
  }

  @override
  String get aboutTabularium => 'Over Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Weergave Wisselen';

  @override
  String get theme => 'Thema';

  @override
  String get help => 'Help';

  @override
  String get about => 'Over';

  @override
  String get resetSettings => 'Resetten';

  @override
  String get fontSize => 'Lettergrootte';

  @override
  String get bookScaleGrid => 'Schaal (Raster)';

  @override
  String get bookScaleCabinet => 'Schaal (Kast)';

  @override
  String get add => 'Toevoegen';

  @override
  String get selectShelf => 'Plank Selecteren';

  @override
  String get sortDateAddedNewest => 'Toegevoegd ↓';

  @override
  String get sortDateAddedOldest => 'Toegevoegd ↑';

  @override
  String get sortDateOpenedNewest => 'Geopend ↓';

  @override
  String get sortDateOpenedOldest => 'Geopend ↑';

  @override
  String get sortTitleAZ => 'Titel A-Z';

  @override
  String get sortTitleZA => 'Titel Z-A';
}
