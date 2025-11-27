import '../data/datasources/pdf_scanner_datasource.dart';
import '../data/datasources/thumbnail_generator_datasource.dart';
import '../data/datasources/config_datasource.dart';
import '../data/repositories/library_repository_impl.dart';
import '../domain/repositories/library_repository.dart';
import '../domain/usecases/initialize_library_usecase.dart';
import '../domain/usecases/load_library_usecase.dart';
import '../domain/usecases/save_library_usecase.dart';
import '../domain/usecases/open_book_usecase.dart';
import '../domain/usecases/open_all_books_usecase.dart';
import '../presentation/bloc/library_bloc.dart';

/// Dependency injection container for library feature
class LibraryDependencies {
  late final PdfScannerDataSource _pdfScanner;
  late final ThumbnailGeneratorDataSource _thumbnailGenerator;
  late final ConfigDataSource _configDataSource;
  late final LibraryRepository _repository;
  late final InitializeLibraryUseCase _initializeLibrary;
  late final LoadLibraryUseCase _loadLibrary;
  late final SaveLibraryUseCase _saveLibrary;
  late final OpenBookUseCase _openBook;
  late final OpenAllBooksUseCase _openAllBooks;

  LibraryDependencies() {
    _setupDataSources();
    _setupRepository();
    _setupUseCases();
  }

  void _setupDataSources() {
    _pdfScanner = PdfScannerDataSourceImpl();
    _thumbnailGenerator = ThumbnailGeneratorDataSourceImpl();
    _configDataSource = ConfigDataSourceImpl();
  }

  void _setupRepository() {
    _repository = LibraryRepositoryImpl(
      pdfScanner: _pdfScanner,
      thumbnailGenerator: _thumbnailGenerator,
      configDataSource: _configDataSource,
    );
  }

  void _setupUseCases() {
    _initializeLibrary = InitializeLibraryUseCase(_repository);
    _loadLibrary = LoadLibraryUseCase(_repository);
    _saveLibrary = SaveLibraryUseCase(_repository);
    _openBook = OpenBookUseCase(_repository);
    _openAllBooks = OpenAllBooksUseCase(_repository);
  }

  /// Create a new LibraryBloc instance
  LibraryBloc createLibraryBloc() {
    return LibraryBloc(
      initializeLibrary: _initializeLibrary,
      loadLibrary: _loadLibrary,
      saveLibrary: _saveLibrary,
      openBook: _openBook,
      openAllBooks: _openAllBooks,
    );
  }
}
