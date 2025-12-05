// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Osobista Biblioteka';

  @override
  String get selectBooksDirectory => 'Wybierz Folder';

  @override
  String get recentDirectories => 'Ostatnie';

  @override
  String get favorites => 'Ulubione';

  @override
  String get clearRecent => 'Wyczyść Ostatnie';

  @override
  String get clearFavorites => 'Wyczyść Ulubione';

  @override
  String get addToFavorites => 'Dodaj do Ulubionych';

  @override
  String get removeFromFavorites => 'Usuń z Ulubionych';

  @override
  String get directoryNotFound => 'Folder nie znaleziony';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Folder \"$path\" nie istnieje lub jest niedostępny. Został usunięty z ostatnich.';
  }

  @override
  String get mainScreen => 'Ekran Główny';

  @override
  String get selectedDirectory => 'Wybrany folder:';

  @override
  String get error => 'Błąd';

  @override
  String errorMessage(String message) {
    return 'Błąd: $message';
  }

  @override
  String get retry => 'Spróbuj Ponownie';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Ustawienia';

  @override
  String get language => 'Język';

  @override
  String get allBooks => 'Wszystkie Książki';

  @override
  String get unsortedBooks => 'Nieposortowane';

  @override
  String get shelves => 'Półki';

  @override
  String get createShelf => 'Utwórz Półkę';

  @override
  String get editShelf => 'Edytuj Półkę';

  @override
  String get shelfName => 'Nazwa Półki';

  @override
  String get deleteShelf => 'Usuń Półkę';

  @override
  String get openAllBooks => 'Otwórz Wszystkie';

  @override
  String get searchBooks => 'Szukaj książek...';

  @override
  String get searchShelves => 'Szukaj półek...';

  @override
  String get noBooks => 'Nie znaleziono książek';

  @override
  String get noBooksInShelf => 'Półka jest pusta';

  @override
  String get scanForNewBooks => 'Skanuj Nowe';

  @override
  String get scan => 'Skanuj';

  @override
  String get initializingLibrary => 'Inicjalizacja...';

  @override
  String get loadingLibrary => 'Ładowanie...';

  @override
  String get backToWelcome => 'Powrót';

  @override
  String get addToShelf => 'Dodaj do Półki';

  @override
  String get removeFromShelf => 'Usuń z Półki';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count książek',
      few: '$count książki',
      one: '1 książka',
      zero: 'Brak książek',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Anuluj';

  @override
  String get create => 'Utwórz';

  @override
  String get delete => 'Usuń';

  @override
  String get selected => 'zaznaczono';

  @override
  String get openSelected => 'Otwórz Zaznaczone';

  @override
  String get selectAll => 'Zaznacz Wszystkie';

  @override
  String get clearSelection => 'Wyczyść Zaznaczenie';

  @override
  String get deleteFromShelf => 'Usuń z Półki';

  @override
  String get remove => 'Usuń';

  @override
  String get open => 'Otwórz';

  @override
  String get properties => 'Właściwości';

  @override
  String get bookProperties => 'Właściwości Książki';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Ścieżka Pliku';

  @override
  String get author => 'Autor';

  @override
  String get title => 'Tytuł';

  @override
  String get pageCount => 'Strony';

  @override
  String get fileSize => 'Rozmiar Pliku';

  @override
  String get save => 'Zapisz';

  @override
  String get shortcuts => 'Skróty';

  @override
  String get keyboardShortcuts => 'Skróty Klawiszowe';

  @override
  String get deleteBook => 'Usuń';

  @override
  String get deleteSelected => 'Usuń Zaznaczone';

  @override
  String get deleteAll => 'Usuń Wszystkie';

  @override
  String get confirmDeleteBook => 'Usunąć Książkę?';

  @override
  String get confirmDeleteBookMessage =>
      'Plik zostanie trwale usunięty. Akcja nieodwracalna.';

  @override
  String get confirmDeleteSelected => 'Usunąć Zaznaczone?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików zostanie',
      few: 'pliki zostaną',
      one: 'plik zostanie',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'usuniętych',
      few: 'usunięte',
      one: 'usunięty',
    );
    return '$count $_temp0 trwale $_temp1. Akcja nieodwracalna.';
  }

  @override
  String get confirmDeleteAll => 'Usunąć Wszystkie?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików',
      few: 'pliki',
      one: 'plik',
    );
    return 'Wszystkie $count $_temp0 z tej półki zostaną trwale usunięte. Akcja nieodwracalna.';
  }

  @override
  String get aboutTabularium => 'O Programie';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Przełącz Widok';

  @override
  String get theme => 'Motyw';

  @override
  String get help => 'Pomoc';

  @override
  String get about => 'O Programie';

  @override
  String get resetSettings => 'Resetuj';

  @override
  String get fontSize => 'Rozmiar Czcionki';

  @override
  String get bookScaleGrid => 'Skala (Siatka)';

  @override
  String get bookScaleCabinet => 'Skala (Szafa)';

  @override
  String get add => 'Dodaj';

  @override
  String get selectShelf => 'Wybierz Półkę';

  @override
  String get sortDateAddedNewest => 'Dodano ↓';

  @override
  String get sortDateAddedOldest => 'Dodano ↑';

  @override
  String get sortDateOpenedNewest => 'Otwarto ↓';

  @override
  String get sortDateOpenedOldest => 'Otwarto ↑';

  @override
  String get sortTitleAZ => 'Tytuł A-Z';

  @override
  String get sortTitleZA => 'Tytuł Z-A';
}
