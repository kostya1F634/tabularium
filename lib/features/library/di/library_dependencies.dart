import '../../../core/services/ai_settings_service.dart';
import '../../../core/services/ollama_client.dart';
import '../data/datasources/pdf_scanner_datasource.dart';
import '../data/datasources/pdf_text_extractor.dart';
import '../data/datasources/thumbnail_generator_datasource.dart';
import '../data/datasources/config_datasource.dart';
import '../data/repositories/library_repository_impl.dart';
import '../domain/repositories/library_repository.dart';
import '../domain/usecases/ai_analyze_book.dart';
import '../domain/usecases/ai_sort_library.dart';
import '../domain/usecases/initialize_library_usecase.dart';
import '../domain/usecases/load_library_usecase.dart';
import '../domain/usecases/save_library_usecase.dart';
import '../domain/usecases/open_book_usecase.dart';
import '../domain/usecases/open_all_books_usecase.dart';
import '../presentation/bloc/library_bloc.dart';

/// Dependency injection container for library feature
class LibraryDependencies {
  final AISettingsService aiSettingsService;

  late final PdfScannerDataSource _pdfScanner;
  late final ThumbnailGeneratorDataSource _thumbnailGenerator;
  late final ConfigDataSource _configDataSource;
  late final PdfTextExtractor _pdfTextExtractor;
  late final LibraryRepository _repository;
  late final InitializeLibraryUseCase _initializeLibrary;
  late final LoadLibraryUseCase _loadLibrary;
  late final SaveLibraryUseCase _saveLibrary;
  late final OpenBookUseCase _openBook;
  late final OpenAllBooksUseCase _openAllBooks;
  late final AIAnalyzeBook? _aiAnalyzeBook;
  late final AISortLibrary? _aiSortLibrary;

  LibraryDependencies({required this.aiSettingsService}) {
    _setupDataSources();
    _setupRepository();
    _setupUseCases();
    _setupAIUseCases();
  }

  void _setupDataSources() {
    _pdfScanner = PdfScannerDataSourceImpl();
    _thumbnailGenerator = ThumbnailGeneratorDataSourceImpl();
    _configDataSource = ConfigDataSourceImpl();
    _pdfTextExtractor = PdfTextExtractor();
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

  void _setupAIUseCases() {
    if (aiSettingsService.isConfigured) {
      final ollamaClient = OllamaClient(
        baseUrl: aiSettingsService.ollamaUrl,
        model: aiSettingsService.ollamaModel,
      );
      _aiAnalyzeBook = AIAnalyzeBook(
        ollamaClient: ollamaClient,
        textExtractor: _pdfTextExtractor,
        maxPages: aiSettingsService.maxPages,
      );
      _aiSortLibrary = AISortLibrary(ollamaClient: ollamaClient);
    } else {
      _aiAnalyzeBook = null;
      _aiSortLibrary = null;
    }
  }

  /// Create a new LibraryBloc instance
  LibraryBloc createLibraryBloc() {
    return LibraryBloc(
      initializeLibrary: _initializeLibrary,
      loadLibrary: _loadLibrary,
      saveLibrary: _saveLibrary,
      openBook: _openBook,
      openAllBooks: _openAllBooks,
      aiAnalyzeBook: _aiAnalyzeBook,
      aiSortLibrary: _aiSortLibrary,
      aiSettings: aiSettingsService,
    );
  }
}
