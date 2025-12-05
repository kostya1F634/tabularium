// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Dit Personlige Bibliotek';

  @override
  String get selectBooksDirectory => 'Vælg Bogmappe';

  @override
  String get recentDirectories => 'Seneste';

  @override
  String get favorites => 'Favoritter';

  @override
  String get clearRecent => 'Ryd Seneste';

  @override
  String get clearFavorites => 'Ryd Favoritter';

  @override
  String get addToFavorites => 'Tilføj til Favoritter';

  @override
  String get removeFromFavorites => 'Fjern fra Favoritter';

  @override
  String get directoryNotFound => 'Mappe ikke fundet';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Mappen \"$path\" findes ikke eller er utilgængelig. Den er fjernet fra seneste.';
  }

  @override
  String get mainScreen => 'Hovedskærm';

  @override
  String get selectedDirectory => 'Valgt mappe:';

  @override
  String get error => 'Fejl';

  @override
  String errorMessage(String message) {
    return 'Fejl: $message';
  }

  @override
  String get retry => 'Prøv Igen';

  @override
  String get loading => 'Indlæser...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Indstillinger';

  @override
  String get language => 'Sprog';

  @override
  String get allBooks => 'Alle Bøger';

  @override
  String get unsortedBooks => 'Usorteret';

  @override
  String get shelves => 'Hylder';

  @override
  String get createShelf => 'Opret Hylde';

  @override
  String get editShelf => 'Rediger Hylde';

  @override
  String get shelfName => 'Hyldenavn';

  @override
  String get deleteShelf => 'Slet Hylde';

  @override
  String get openAllBooks => 'Åbn Alle';

  @override
  String get searchBooks => 'Søg bøger...';

  @override
  String get searchShelves => 'Søg hylder...';

  @override
  String get noBooks => 'Ingen bøger fundet';

  @override
  String get noBooksInShelf => 'Hylde er tom';

  @override
  String get scanForNewBooks => 'Scan Nye Bøger';

  @override
  String get scan => 'Scan';

  @override
  String get initializingLibrary => 'Initialiserer...';

  @override
  String get loadingLibrary => 'Indlæser...';

  @override
  String get backToWelcome => 'Tilbage';

  @override
  String get addToShelf => 'Tilføj til Hylde';

  @override
  String get removeFromShelf => 'Fjern fra Hylde';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bøger',
      one: '1 bog',
      zero: 'Ingen bøger',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Annuller';

  @override
  String get create => 'Opret';

  @override
  String get delete => 'Slet';

  @override
  String get selected => 'valgt';

  @override
  String get openSelected => 'Åbn Valgte';

  @override
  String get selectAll => 'Vælg Alle';

  @override
  String get clearSelection => 'Ryd Valg';

  @override
  String get deleteFromShelf => 'Slet fra Hylde';

  @override
  String get remove => 'Fjern';

  @override
  String get open => 'Åbn';

  @override
  String get properties => 'Egenskaber';

  @override
  String get bookProperties => 'Bogegenskaber';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Filsti';

  @override
  String get author => 'Forfatter';

  @override
  String get title => 'Titel';

  @override
  String get pageCount => 'Sider';

  @override
  String get fileSize => 'Filstørrelse';

  @override
  String get save => 'Gem';

  @override
  String get shortcuts => 'Genveje';

  @override
  String get keyboardShortcuts => 'Tastaturgenveje';

  @override
  String get deleteBook => 'Slet';

  @override
  String get deleteSelected => 'Slet Valgte';

  @override
  String get deleteAll => 'Slet Alle';

  @override
  String get confirmDeleteBook => 'Slet Bog?';

  @override
  String get confirmDeleteBookMessage =>
      'Filen slettes permanent. Handling kan ikke fortrydes.';

  @override
  String get confirmDeleteSelected => 'Slet Valgte?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer slettes',
      one: 'fil slettes',
    );
    return '$count $_temp0 permanent. Handling kan ikke fortrydes.';
  }

  @override
  String get confirmDeleteAll => 'Slet Alle?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
    );
    return 'Alle $count $_temp0 fra denne hylde slettes permanent. Handling kan ikke fortrydes.';
  }

  @override
  String get aboutTabularium => 'Om Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Skift Visning';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Hjælp';

  @override
  String get about => 'Om';

  @override
  String get resetSettings => 'Nulstil';

  @override
  String get fontSize => 'Skriftstørrelse';

  @override
  String get bookScaleGrid => 'Skala (Gitter)';

  @override
  String get bookScaleCabinet => 'Skala (Skab)';

  @override
  String get add => 'Tilføj';

  @override
  String get selectShelf => 'Vælg Hylde';

  @override
  String get sortDateAddedNewest => 'Tilføjet ↓';

  @override
  String get sortDateAddedOldest => 'Tilføjet ↑';

  @override
  String get sortDateOpenedNewest => 'Åbnet ↓';

  @override
  String get sortDateOpenedOldest => 'Åbnet ↑';

  @override
  String get sortTitleAZ => 'Titel A-Z';

  @override
  String get sortTitleZA => 'Titel Z-A';
}
