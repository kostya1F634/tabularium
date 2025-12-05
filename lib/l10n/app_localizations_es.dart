// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Su Biblioteca Personal';

  @override
  String get selectBooksDirectory => 'Seleccionar Carpeta';

  @override
  String get recentDirectories => 'Recientes';

  @override
  String get favorites => 'Favoritos';

  @override
  String get clearRecent => 'Limpiar Recientes';

  @override
  String get clearFavorites => 'Limpiar Favoritos';

  @override
  String get addToFavorites => 'Añadir a Favoritos';

  @override
  String get removeFromFavorites => 'Quitar de Favoritos';

  @override
  String get directoryNotFound => 'Carpeta no encontrada';

  @override
  String directoryNotFoundMessage(String path) {
    return 'La carpeta \"$path\" ya no existe o no está accesible. Se eliminó de los recientes.';
  }

  @override
  String get mainScreen => 'Pantalla Principal';

  @override
  String get selectedDirectory => 'Carpeta seleccionada:';

  @override
  String get error => 'Error';

  @override
  String errorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get retry => 'Reintentar';

  @override
  String get loading => 'Cargando...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get allBooks => 'Todos los Libros';

  @override
  String get unsortedBooks => 'Sin Estante';

  @override
  String get shelves => 'Estantes';

  @override
  String get createShelf => 'Crear Estante';

  @override
  String get editShelf => 'Editar Estante';

  @override
  String get shelfName => 'Nombre del Estante';

  @override
  String get deleteShelf => 'Eliminar Estante';

  @override
  String get openAllBooks => 'Abrir Todos';

  @override
  String get searchBooks => 'Buscar libros...';

  @override
  String get searchShelves => 'Buscar estantes...';

  @override
  String get noBooks => 'No se encontraron libros';

  @override
  String get noBooksInShelf => 'Estante vacío';

  @override
  String get scanForNewBooks => 'Escanear Nuevos';

  @override
  String get scan => 'Escanear';

  @override
  String get initializingLibrary => 'Inicializando...';

  @override
  String get loadingLibrary => 'Cargando...';

  @override
  String get backToWelcome => 'Volver';

  @override
  String get addToShelf => 'Añadir al Estante';

  @override
  String get removeFromShelf => 'Quitar del Estante';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count libros',
      one: '1 libro',
      zero: 'Sin libros',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get create => 'Crear';

  @override
  String get delete => 'Eliminar';

  @override
  String get selected => 'seleccionado(s)';

  @override
  String get openSelected => 'Abrir Selección';

  @override
  String get selectAll => 'Seleccionar Todo';

  @override
  String get clearSelection => 'Limpiar Selección';

  @override
  String get deleteFromShelf => 'Eliminar del Estante';

  @override
  String get remove => 'Quitar';

  @override
  String get open => 'Abrir';

  @override
  String get properties => 'Propiedades';

  @override
  String get bookProperties => 'Propiedades del Libro';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Ruta del Archivo';

  @override
  String get author => 'Autor';

  @override
  String get title => 'Título';

  @override
  String get pageCount => 'Páginas';

  @override
  String get fileSize => 'Tamaño';

  @override
  String get save => 'Guardar';

  @override
  String get shortcuts => 'Atajos';

  @override
  String get keyboardShortcuts => 'Atajos de Teclado';

  @override
  String get deleteBook => 'Eliminar';

  @override
  String get deleteSelected => 'Eliminar Selección';

  @override
  String get deleteAll => 'Eliminar Todo';

  @override
  String get confirmDeleteBook => '¿Eliminar Libro?';

  @override
  String get confirmDeleteBookMessage =>
      'El archivo se eliminará permanentemente. Acción irreversible.';

  @override
  String get confirmDeleteSelected => '¿Eliminar Selección?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'eliminarán $count archivos',
      one: 'eliminará 1 archivo',
    );
    return 'Se $_temp0 permanentemente. Acción irreversible.';
  }

  @override
  String get confirmDeleteAll => '¿Eliminar Todo?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos',
      one: '1 archivo',
    );
    return 'Se eliminarán permanentemente $_temp0 de este estante. Acción irreversible.';
  }

  @override
  String get aboutTabularium => 'Acerca de Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Cambiar Vista';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Ayuda';

  @override
  String get about => 'Acerca de';

  @override
  String get resetSettings => 'Restablecer';

  @override
  String get fontSize => 'Tamaño Fuente';

  @override
  String get bookScaleGrid => 'Escala (Cuadrícula)';

  @override
  String get bookScaleCabinet => 'Escala (Estantería)';

  @override
  String get add => 'Añadir';

  @override
  String get selectShelf => 'Seleccionar Estante';

  @override
  String get sortDateAddedNewest => 'Agregado ↓';

  @override
  String get sortDateAddedOldest => 'Agregado ↑';

  @override
  String get sortDateOpenedNewest => 'Abierto ↓';

  @override
  String get sortDateOpenedOldest => 'Abierto ↑';

  @override
  String get sortTitleAZ => 'Título A-Z';

  @override
  String get sortTitleZA => 'Título Z-A';
}
