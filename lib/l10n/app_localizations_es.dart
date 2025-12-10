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

  @override
  String get searchThemes => 'Buscar temas...';

  @override
  String get sizeSmall => 'Pequeño';

  @override
  String get sizeMedium => 'Medio';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Grande';

  @override
  String get sizeExtraLarge => 'Muy grande';

  @override
  String get sizeTiny => 'Diminuto';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'General';

  @override
  String get shortcutsNavigationShelves => 'Navegación - Estantes';

  @override
  String get shortcutsNavigationBooks => 'Navegación - Libros';

  @override
  String get shortcutsShelves => 'Estantes';

  @override
  String get shortcutsBooks => 'Libros';

  @override
  String get shortcutToggleScreen =>
      'Alternar entre biblioteca y pantalla de bienvenida';

  @override
  String get shortcutCreateShelf => 'Crear nuevo estante';

  @override
  String get shortcutOpenBooks => 'Abrir libros (todos o seleccionados)';

  @override
  String get shortcutSelectAll => 'Seleccionar todo';

  @override
  String get shortcutClearSelection => 'Limpiar selección';

  @override
  String get shortcutQuickShelf => 'Selección rápida estante (primeros 10)';

  @override
  String get shortcutEdit => 'Editar estante / Propiedades del libro';

  @override
  String get shortcutToggleView =>
      'Cambiar modo de vista (Cuadrícula/Estantería)';

  @override
  String get shortcutAddToShelf =>
      'Añadir libros a estante (seleccionados/enfocados/todos)';

  @override
  String get shortcutFocusCenter => 'Enfocar libro central visible';

  @override
  String get shortcutJumpFirst => 'Ir al primer estante/libro';

  @override
  String get shortcutJumpLast => 'Ir al último estante/libro';

  @override
  String get shortcutFocusSearch => 'Enfocar/desenfocar campo de búsqueda';

  @override
  String get shortcutSwitchFocus => 'Cambiar enfoque entre estantes y libros';

  @override
  String get shortcutMoveDown => 'Mover hacia abajo';

  @override
  String get shortcutMoveUp => 'Mover hacia arriba';

  @override
  String get shortcutMoveLeft => 'Mover hacia la izquierda';

  @override
  String get shortcutMoveRight => 'Mover hacia la derecha';

  @override
  String get shortcutMoveShelfDown => 'Mover estante hacia abajo';

  @override
  String get shortcutMoveShelfUp => 'Mover estante hacia arriba';

  @override
  String get shortcutDeleteShelf => 'Eliminar estante';

  @override
  String get shortcutOpenFocused => 'Abrir libro enfocado';

  @override
  String get shortcutToggleSelection => 'Alternar selección del libro enfocado';

  @override
  String get shortcutRemoveFromShelf =>
      'Quitar libros seleccionados del estante';

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
      '0 = many specific shelves, 100 = few broad shelves';

  @override
  String get maxPages => 'Max Pages';

  @override
  String get maxPagesHint =>
      'Number of pages to read per book (1-50, starting from page 2)';

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

  @override
  String get aiRename => 'Analyze (no sorting)';

  @override
  String get aiTitle => 'AI: Title & Tags';
}
