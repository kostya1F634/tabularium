// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'La Sua Biblioteca Personale';

  @override
  String get selectBooksDirectory => 'Seleziona Cartella';

  @override
  String get recentDirectories => 'Recenti';

  @override
  String get favorites => 'Preferiti';

  @override
  String get clearRecent => 'Cancella Recenti';

  @override
  String get clearFavorites => 'Cancella Preferiti';

  @override
  String get addToFavorites => 'Aggiungi ai Preferiti';

  @override
  String get removeFromFavorites => 'Rimuovi dai Preferiti';

  @override
  String get directoryNotFound => 'Cartella non trovata';

  @override
  String directoryNotFoundMessage(String path) {
    return 'La cartella \"$path\" non esiste più o non è accessibile. È stata rimossa dai recenti.';
  }

  @override
  String get mainScreen => 'Schermata Principale';

  @override
  String get selectedDirectory => 'Cartella selezionata:';

  @override
  String get error => 'Errore';

  @override
  String errorMessage(String message) {
    return 'Errore: $message';
  }

  @override
  String get retry => 'Riprova';

  @override
  String get loading => 'Caricamento...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Impostazioni';

  @override
  String get language => 'Lingua';

  @override
  String get allBooks => 'Tutti i Libri';

  @override
  String get unsortedBooks => 'Non Ordinati';

  @override
  String get shelves => 'Scaffali';

  @override
  String get createShelf => 'Crea Scaffale';

  @override
  String get editShelf => 'Modifica Scaffale';

  @override
  String get shelfName => 'Nome Scaffale';

  @override
  String get deleteShelf => 'Elimina Scaffale';

  @override
  String get openAllBooks => 'Apri Tutti';

  @override
  String get searchBooks => 'Cerca libri...';

  @override
  String get searchShelves => 'Cerca scaffali...';

  @override
  String get noBooks => 'Nessun libro trovato';

  @override
  String get noBooksInShelf => 'Scaffale vuoto';

  @override
  String get scanForNewBooks => 'Scansiona Nuovi';

  @override
  String get scan => 'Scansiona';

  @override
  String get initializingLibrary => 'Inizializzazione...';

  @override
  String get loadingLibrary => 'Caricamento...';

  @override
  String get backToWelcome => 'Indietro';

  @override
  String get addToShelf => 'Aggiungi allo Scaffale';

  @override
  String get removeFromShelf => 'Rimuovi dallo Scaffale';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count libri',
      one: '1 libro',
      zero: 'Nessun libro',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Annulla';

  @override
  String get create => 'Crea';

  @override
  String get delete => 'Elimina';

  @override
  String get selected => 'selezionato/i';

  @override
  String get openSelected => 'Apri Selezionati';

  @override
  String get selectAll => 'Seleziona Tutto';

  @override
  String get clearSelection => 'Cancella Selezione';

  @override
  String get deleteFromShelf => 'Elimina dallo Scaffale';

  @override
  String get remove => 'Rimuovi';

  @override
  String get open => 'Apri';

  @override
  String get properties => 'Proprietà';

  @override
  String get bookProperties => 'Proprietà Libro';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Percorso File';

  @override
  String get author => 'Autore';

  @override
  String get title => 'Titolo';

  @override
  String get pageCount => 'Pagine';

  @override
  String get fileSize => 'Dimensione';

  @override
  String get save => 'Salva';

  @override
  String get shortcuts => 'Scorciatoie';

  @override
  String get keyboardShortcuts => 'Scorciatoie Tastiera';

  @override
  String get deleteBook => 'Elimina';

  @override
  String get deleteSelected => 'Elimina Selezionati';

  @override
  String get deleteAll => 'Elimina Tutto';

  @override
  String get confirmDeleteBook => 'Eliminare Libro?';

  @override
  String get confirmDeleteBookMessage =>
      'Il file verrà eliminato permanentemente. Azione irreversibile.';

  @override
  String get confirmDeleteSelected => 'Eliminare Selezionati?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file verranno eliminati',
      one: 'file verrà eliminato',
    );
    return '$count $_temp0 permanentemente. Azione irreversibile.';
  }

  @override
  String get confirmDeleteAll => 'Eliminare Tutto?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file',
      one: 'file',
    );
    return 'Tutti i $count $_temp0 di questo scaffale verranno eliminati permanentemente. Azione irreversibile.';
  }

  @override
  String get aboutTabularium => 'Informazioni';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Cambia Vista';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Aiuto';

  @override
  String get about => 'Informazioni';

  @override
  String get resetSettings => 'Ripristina';

  @override
  String get fontSize => 'Dimensione Font';

  @override
  String get bookScaleGrid => 'Scala (Griglia)';

  @override
  String get bookScaleCabinet => 'Scala (Libreria)';

  @override
  String get add => 'Aggiungi';

  @override
  String get selectShelf => 'Seleziona Scaffale';

  @override
  String get sortDateAddedNewest => 'Aggiunto ↓';

  @override
  String get sortDateAddedOldest => 'Aggiunto ↑';

  @override
  String get sortDateOpenedNewest => 'Aperto ↓';

  @override
  String get sortDateOpenedOldest => 'Aperto ↑';

  @override
  String get sortTitleAZ => 'Titolo A-Z';

  @override
  String get sortTitleZA => 'Titolo Z-A';

  @override
  String get searchThemes => 'Cerca temi...';

  @override
  String get sizeSmall => 'Piccolo';

  @override
  String get sizeMedium => 'Medio';

  @override
  String get sizeNormal => 'Normale';

  @override
  String get sizeLarge => 'Grande';

  @override
  String get sizeExtraLarge => 'Molto grande';

  @override
  String get sizeTiny => 'Minuscolo';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Generale';

  @override
  String get shortcutsNavigationShelves => 'Navigazione - Scaffali';

  @override
  String get shortcutsNavigationBooks => 'Navigazione - Libri';

  @override
  String get shortcutsShelves => 'Scaffali';

  @override
  String get shortcutsBooks => 'Libri';

  @override
  String get shortcutToggleScreen =>
      'Passa tra biblioteca e schermata di benvenuto';

  @override
  String get shortcutCreateShelf => 'Crea nuovo scaffale';

  @override
  String get shortcutOpenBooks => 'Apri libri (tutti o selezionati)';

  @override
  String get shortcutSelectAll => 'Seleziona tutto';

  @override
  String get shortcutClearSelection => 'Cancella selezione';

  @override
  String get shortcutQuickShelf => 'Selezione rapida scaffale (primi 10)';

  @override
  String get shortcutEdit => 'Modifica scaffale / Proprietà libro';

  @override
  String get shortcutToggleView => 'Cambia modalità vista (Griglia/Libreria)';

  @override
  String get shortcutAddToShelf =>
      'Aggiungi libri a scaffale (selezionati/focus/tutti)';

  @override
  String get shortcutFocusCenter => 'Focalizza libro centrale visibile';

  @override
  String get shortcutJumpFirst => 'Vai al primo scaffale/libro';

  @override
  String get shortcutJumpLast => 'Vai all\'ultimo scaffale/libro';

  @override
  String get shortcutFocusSearch => 'Focalizza/defocalizza campo di ricerca';

  @override
  String get shortcutSwitchFocus => 'Cambia focus tra scaffali e libri';

  @override
  String get shortcutMoveDown => 'Sposta giù';

  @override
  String get shortcutMoveUp => 'Sposta su';

  @override
  String get shortcutMoveLeft => 'Sposta a sinistra';

  @override
  String get shortcutMoveRight => 'Sposta a destra';

  @override
  String get shortcutMoveShelfDown => 'Sposta scaffale giù';

  @override
  String get shortcutMoveShelfUp => 'Sposta scaffale su';

  @override
  String get shortcutDeleteShelf => 'Elimina scaffale';

  @override
  String get shortcutOpenFocused => 'Apri libro focalizzato';

  @override
  String get shortcutToggleSelection => 'Cambia selezione libro focalizzato';

  @override
  String get shortcutRemoveFromShelf =>
      'Rimuovi libri selezionati dallo scaffale';
}
