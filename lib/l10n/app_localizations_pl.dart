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

  @override
  String get searchThemes => 'Szukaj motywów...';

  @override
  String get sizeSmall => 'Mały';

  @override
  String get sizeMedium => 'Średni';

  @override
  String get sizeNormal => 'Normalny';

  @override
  String get sizeLarge => 'Duży';

  @override
  String get sizeExtraLarge => 'Bardzo duży';

  @override
  String get sizeTiny => 'Malutki';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Ogólne';

  @override
  String get shortcutsNavigationShelves => 'Nawigacja - Półki';

  @override
  String get shortcutsNavigationBooks => 'Nawigacja - Książki';

  @override
  String get shortcutsShelves => 'Półki';

  @override
  String get shortcutsBooks => 'Książki';

  @override
  String get shortcutToggleScreen =>
      'Przełącz między biblioteką a ekranem powitalnym';

  @override
  String get shortcutCreateShelf => 'Utwórz nową półkę';

  @override
  String get shortcutOpenBooks => 'Otwórz książki (wszystkie lub zaznaczone)';

  @override
  String get shortcutSelectAll => 'Zaznacz wszystkie';

  @override
  String get shortcutClearSelection => 'Wyczyść zaznaczenie';

  @override
  String get shortcutQuickShelf => 'Szybki wybór półki (pierwsze 10)';

  @override
  String get shortcutEdit => 'Edytuj półkę / Właściwości książki';

  @override
  String get shortcutToggleView => 'Przełącz tryb widoku (Siatka/Szafa)';

  @override
  String get shortcutAddToShelf =>
      'Dodaj książki do półki (zaznaczone/fokus/wszystkie)';

  @override
  String get shortcutFocusCenter => 'Fokus na centralną widoczną książkę';

  @override
  String get shortcutJumpFirst => 'Skocz do pierwszej półki/książki';

  @override
  String get shortcutJumpLast => 'Skocz do ostatniej półki/książki';

  @override
  String get shortcutFocusSearch => 'Fokus/defokus pole wyszukiwania';

  @override
  String get shortcutSwitchFocus => 'Przełącz fokus między półkami a książkami';

  @override
  String get shortcutMoveDown => 'Przesuń w dół';

  @override
  String get shortcutMoveUp => 'Przesuń w górę';

  @override
  String get shortcutMoveLeft => 'Przesuń w lewo';

  @override
  String get shortcutMoveRight => 'Przesuń w prawo';

  @override
  String get shortcutMoveShelfDown => 'Przesuń półkę w dół';

  @override
  String get shortcutMoveShelfUp => 'Przesuń półkę w górę';

  @override
  String get shortcutDeleteShelf => 'Usuń półkę';

  @override
  String get shortcutOpenFocused => 'Otwórz książkę w fokusie';

  @override
  String get shortcutToggleSelection =>
      'Przełącz zaznaczenie książki w fokusie';

  @override
  String get shortcutRemoveFromShelf => 'Usuń zaznaczone książki z półki';

  @override
  String get ai => 'AI';

  @override
  String get aiSettings => 'AI Settings';

  @override
  String get aiFullSort => 'Full Sort (AI)';

  @override
  String get ollamaUrl => 'Ollama URL';

  @override
  String get ollamaModel => 'Ollama Model';

  @override
  String get generalization => 'Generalization';

  @override
  String get generalizationHint =>
      '0 = many specific shelves, 1 = few broad shelves';

  @override
  String get testConnection => 'Test Connection';

  @override
  String get connectionSuccess => 'Connection successful!';

  @override
  String get connectionFailed => 'Connection failed';

  @override
  String get analyzeBook => 'Analyzing book';

  @override
  String get analyzingBooks => 'Analyzing books...';

  @override
  String get sortingLibrary => 'Sorting library...';

  @override
  String get aiSortComplete => 'AI sort complete';

  @override
  String get aiSortFailed => 'AI sort failed';

  @override
  String booksAnalyzed(int count) {
    return '$count books analyzed';
  }

  @override
  String shelvesCreated(int count) {
    return '$count new shelves created';
  }
}
