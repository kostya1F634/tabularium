// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Kişisel Kütüphaneniz';

  @override
  String get selectBooksDirectory => 'Kitap Klasörü Seç';

  @override
  String get recentDirectories => 'Son Kullanılanlar';

  @override
  String get favorites => 'Favoriler';

  @override
  String get clearRecent => 'Son Kullanılanları Temizle';

  @override
  String get clearFavorites => 'Favorileri Temizle';

  @override
  String get addToFavorites => 'Favorilere Ekle';

  @override
  String get removeFromFavorites => 'Favorilerden Çıkar';

  @override
  String get directoryNotFound => 'Klasör bulunamadı';

  @override
  String directoryNotFoundMessage(String path) {
    return '\"$path\" klasörü mevcut değil veya erişilemiyor. Son kullanılanlardan kaldırıldı.';
  }

  @override
  String get mainScreen => 'Ana Ekran';

  @override
  String get selectedDirectory => 'Seçilen klasör:';

  @override
  String get error => 'Hata';

  @override
  String errorMessage(String message) {
    return 'Hata: $message';
  }

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Ayarlar';

  @override
  String get language => 'Dil';

  @override
  String get allBooks => 'Tüm Kitaplar';

  @override
  String get unsortedBooks => 'Sınıflandırılmamış';

  @override
  String get shelves => 'Raflar';

  @override
  String get createShelf => 'Raf Oluştur';

  @override
  String get editShelf => 'Rafı Düzenle';

  @override
  String get shelfName => 'Raf Adı';

  @override
  String get deleteShelf => 'Rafı Sil';

  @override
  String get openAllBooks => 'Tümünü Aç';

  @override
  String get searchBooks => 'Kitap ara...';

  @override
  String get searchShelves => 'Raf ara...';

  @override
  String get noBooks => 'Kitap bulunamadı';

  @override
  String get noBooksInShelf => 'Raf boş';

  @override
  String get scanForNewBooks => 'Yeni Kitapları Tara';

  @override
  String get scan => 'Tara';

  @override
  String get initializingLibrary => 'Başlatılıyor...';

  @override
  String get loadingLibrary => 'Yükleniyor...';

  @override
  String get backToWelcome => 'Geri Dön';

  @override
  String get addToShelf => 'Rafa Ekle';

  @override
  String get removeFromShelf => 'Raftan Çıkar';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kitap',
      one: '1 kitap',
      zero: 'Kitap yok',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'İptal';

  @override
  String get create => 'Oluştur';

  @override
  String get delete => 'Sil';

  @override
  String get selected => 'seçildi';

  @override
  String get openSelected => 'Seçileni Aç';

  @override
  String get selectAll => 'Tümünü Seç';

  @override
  String get clearSelection => 'Seçimi Temizle';

  @override
  String get deleteFromShelf => 'Raftan Sil';

  @override
  String get remove => 'Çıkar';

  @override
  String get open => 'Aç';

  @override
  String get properties => 'Özellikler';

  @override
  String get bookProperties => 'Kitap Özellikleri';

  @override
  String get alias => 'Takma Ad';

  @override
  String get filePath => 'Dosya Yolu';

  @override
  String get author => 'Yazar';

  @override
  String get title => 'Başlık';

  @override
  String get pageCount => 'Sayfa';

  @override
  String get fileSize => 'Dosya Boyutu';

  @override
  String get save => 'Kaydet';

  @override
  String get shortcuts => 'Kısayollar';

  @override
  String get keyboardShortcuts => 'Klavye Kısayolları';

  @override
  String get deleteBook => 'Sil';

  @override
  String get deleteSelected => 'Seçileni Sil';

  @override
  String get deleteAll => 'Tümünü Sil';

  @override
  String get confirmDeleteBook => 'Kitap Silinsin mi?';

  @override
  String get confirmDeleteBookMessage =>
      'Dosya kalıcı olarak silinecek. Bu işlem geri alınamaz.';

  @override
  String get confirmDeleteSelected => 'Seçilenler Silinsin mi?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return '$count dosya kalıcı olarak silinecek. Bu işlem geri alınamaz.';
  }

  @override
  String get confirmDeleteAll => 'Tümü Silinsin mi?';

  @override
  String confirmDeleteAllMessage(int count) {
    return 'Bu raftaki tüm $count dosya kalıcı olarak silinecek. Bu işlem geri alınamaz.';
  }

  @override
  String get aboutTabularium => 'Tabularium Hakkında';

  @override
  String get ok => 'Tamam';

  @override
  String get toggleViewMode => 'Görünümü Değiştir';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Yardım';

  @override
  String get about => 'Hakkında';

  @override
  String get resetSettings => 'Sıfırla';

  @override
  String get fontSize => 'Yazı Boyutu';

  @override
  String get bookScaleGrid => 'Ölçek (Izgara)';

  @override
  String get bookScaleCabinet => 'Ölçek (Dolap)';

  @override
  String get add => 'Ekle';

  @override
  String get selectShelf => 'Raf Seç';

  @override
  String get sortDateAddedNewest => 'Eklenme ↓';

  @override
  String get sortDateAddedOldest => 'Eklenme ↑';

  @override
  String get sortDateOpenedNewest => 'Açılma ↓';

  @override
  String get sortDateOpenedOldest => 'Açılma ↑';

  @override
  String get sortTitleAZ => 'Başlık A-Z';

  @override
  String get sortTitleZA => 'Başlık Z-A';

  @override
  String get searchThemes => 'Tema ara...';

  @override
  String get sizeSmall => 'Küçük';

  @override
  String get sizeMedium => 'Orta';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Büyük';

  @override
  String get sizeExtraLarge => 'Çok büyük';

  @override
  String get sizeTiny => 'Çok küçük';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Genel';

  @override
  String get shortcutsNavigationShelves => 'Gezinti - Raflar';

  @override
  String get shortcutsNavigationBooks => 'Gezinti - Kitaplar';

  @override
  String get shortcutsShelves => 'Raflar';

  @override
  String get shortcutsBooks => 'Kitaplar';

  @override
  String get shortcutToggleScreen =>
      'Kütüphane ve hoş geldiniz ekranı arasında geçiş';

  @override
  String get shortcutCreateShelf => 'Yeni raf oluştur';

  @override
  String get shortcutOpenBooks => 'Kitapları aç (tümü veya seçili)';

  @override
  String get shortcutSelectAll => 'Tümünü seç';

  @override
  String get shortcutClearSelection => 'Seçimi temizle';

  @override
  String get shortcutQuickShelf => 'Hızlı raf seçimi (ilk 10)';

  @override
  String get shortcutEdit => 'Rafı düzenle / Kitap özellikleri';

  @override
  String get shortcutToggleView => 'Görünüm modunu değiştir (Izgara/Dolap)';

  @override
  String get shortcutAddToShelf => 'Rafa kitap ekle (seçili/odaklanmış/tümü)';

  @override
  String get shortcutFocusCenter => 'Merkez görünür kitaba odaklan';

  @override
  String get shortcutJumpFirst => 'İlk rafa/kitaba atla';

  @override
  String get shortcutJumpLast => 'Son rafa/kitaba atla';

  @override
  String get shortcutFocusSearch => 'Arama alanına odaklan/odaklanmayı kaldır';

  @override
  String get shortcutSwitchFocus =>
      'Raflar ve kitaplar arasında odağı değiştir';

  @override
  String get shortcutMoveDown => 'Aşağı git';

  @override
  String get shortcutMoveUp => 'Yukarı git';

  @override
  String get shortcutMoveLeft => 'Sola git';

  @override
  String get shortcutMoveRight => 'Sağa git';

  @override
  String get shortcutMoveShelfDown => 'Rafı aşağı taşı';

  @override
  String get shortcutMoveShelfUp => 'Rafı yukarı taşı';

  @override
  String get shortcutDeleteShelf => 'Rafı sil';

  @override
  String get shortcutOpenFocused => 'Odaklanmış kitabı aç';

  @override
  String get shortcutToggleSelection => 'Odaklanmış kitabın seçimini değiştir';

  @override
  String get shortcutRemoveFromShelf => 'Seçili kitapları raftan çıkar';

  @override
  String get ai => 'AI';

  @override
  String get aiSettings => 'AI Settings';

  @override
  String get aiFullSort => 'Full Sort';

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
  String get processImages => 'Process Images';

  @override
  String get processImagesHint =>
      'Include book cover thumbnail as visual context for analysis (requires vision-capable model)';

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
  String get aiRename => 'Auto Titling';

  @override
  String get aiSort => 'Sort';

  @override
  String get aiTitle => 'AI: Title & Tags';

  @override
  String get outputLanguage => 'Output Language';

  @override
  String get outputLanguageHint =>
      'Language for shelf names, tags, and reasoning (book titles stay in original language)';

  @override
  String get testLanguage => 'Test Language';

  @override
  String get languageTestResult => 'Language Test Result';

  @override
  String get includeDetailedExamples => 'Include Detailed Examples';

  @override
  String get includeDetailedExamplesHint =>
      'Include GOOD/BAD tag examples in prompts (reduces tokens when disabled)';

  @override
  String get includeBookReasoning => 'Include Book Reasoning';

  @override
  String get includeBookReasoningHint =>
      'Include AI reasoning about books when sorting library (reduces tokens when disabled)';

  @override
  String get includeExtendedInstructions => 'Include Extended Instructions';

  @override
  String get includeExtendedInstructionsHint =>
      'Include validation checklists and detailed explanations in prompts (reduces tokens when disabled)';

  @override
  String get aiParameters => 'Parameters';

  @override
  String get ollamaParameters => 'Ollama Parameters';

  @override
  String get numCtx => 'Context Window';

  @override
  String get numCtxHint =>
      'Number of tokens in context window (2048-32768). Default Ollama value is 2048, which may be too small for complex prompts. Larger values use more memory.';

  @override
  String get numCtxEffect =>
      '↑ More context → Better understanding | ↓ Less context → Faster, less memory';

  @override
  String get numPredict => 'Max Output Tokens';

  @override
  String get numPredictHint =>
      'Maximum number of tokens to generate (128-4096, -1 for unlimited). Limits response length.';

  @override
  String get numPredictEffect => '↑ Longer responses | ↓ Shorter responses';

  @override
  String get repeatPenalty => 'Repeat Penalty';

  @override
  String get repeatPenaltyHint =>
      'Penalty for repeating tokens (0.0-2.0). Higher values reduce repetition. Default: 1.1';

  @override
  String get repeatPenaltyEffect => '↑ Less repetition | ↓ More repetition';

  @override
  String get topK => 'Top-K';

  @override
  String get topKHint =>
      'Number of top tokens to consider (1-100). Lower values make output more focused. Default: 40';

  @override
  String get topKEffect => '↑ More diverse | ↓ More focused';

  @override
  String get topP => 'Top-P (Nucleus)';

  @override
  String get topPHint =>
      'Nucleus sampling threshold (0.0-1.0). Lower values make output more deterministic. Default: 0.9';

  @override
  String get topPEffect => '↑ More creative | ↓ More deterministic';

  @override
  String get numBatch => 'Batch Size';

  @override
  String get numBatchHint =>
      'Batch size for prompt processing (32-1024). Reduce if experiencing out-of-memory errors. Default: 512';

  @override
  String get numBatchEffect => '↑ Faster processing | ↓ Less memory usage';

  @override
  String get presencePenalty => 'Presence Penalty';

  @override
  String get presencePenaltyHint =>
      'Penalizes tokens that already appeared (0.0-2.0). Encourages diversity. Higher values = more variety in tags/shelves. Default: 0.0';

  @override
  String get presencePenaltyEffect => '↑ More variety | ↓ May repeat';

  @override
  String get frequencyPenalty => 'Frequency Penalty';

  @override
  String get frequencyPenaltyHint =>
      'Penalizes tokens based on frequency (0.0-2.0). Reduces repetition proportionally. Default: 0.0';

  @override
  String get frequencyPenaltyEffect =>
      '↑ Less frequent words | ↓ Common words OK';

  @override
  String get minP => 'Min-P';

  @override
  String get minPHint =>
      'Minimum probability threshold (0.0-1.0). Alternative to Top-P. Only considers tokens with probability ≥ min_p × max_probability. Default: 0.0 (disabled)';

  @override
  String get minPEffect => '↑ More conservative | ↓ More diverse';

  @override
  String get seed => 'Random Seed';

  @override
  String get seedHint =>
      'Random seed for reproducibility. Set to -1 for random generation, or fixed value (e.g., 42) for consistent results. Useful for debugging.';

  @override
  String get seedEffect => 'Fixed = Reproducible | -1 = Random';

  @override
  String get stopSequences => 'Stop Sequences';

  @override
  String get stopSequencesHint =>
      'Comma-separated stop sequences (e.g., \\n\\n\\n,```,---). Generation stops when encountering these. Saves tokens by stopping after JSON.';

  @override
  String get stopSequencesEffect => 'Saves tokens by early stopping';

  @override
  String get contextParameters => 'Context & Output';

  @override
  String get samplingParameters => 'Sampling & Creativity';

  @override
  String get penaltyParameters => 'Penalties & Control';

  @override
  String get resetDefaults => 'Reset to Defaults';

  @override
  String get advancedParameters => 'Advanced Parameters';

  @override
  String get useIncrementalSort => 'Incremental Sort (Reliable)';

  @override
  String get useIncrementalSortHint =>
      'Sort books one at a time instead of all at once. More reliable and debuggable, but slower. Recommended for large libraries or if batch sorting fails.';
}
