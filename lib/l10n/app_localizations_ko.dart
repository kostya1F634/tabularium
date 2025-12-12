// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => '나의 개인 도서관';

  @override
  String get selectBooksDirectory => '도서 폴더 선택';

  @override
  String get recentDirectories => '최근 항목';

  @override
  String get favorites => '즐겨찾기';

  @override
  String get clearRecent => '최근 항목 지우기';

  @override
  String get clearFavorites => '즐겨찾기 지우기';

  @override
  String get addToFavorites => '즐겨찾기에 추가';

  @override
  String get removeFromFavorites => '즐겨찾기에서 제거';

  @override
  String get directoryNotFound => '폴더를 찾을 수 없음';

  @override
  String directoryNotFoundMessage(String path) {
    return '폴더 \"$path\"이(가) 존재하지 않거나 접근할 수 없습니다. 최근 항목에서 제거되었습니다.';
  }

  @override
  String get mainScreen => '메인 화면';

  @override
  String get selectedDirectory => '선택된 폴더:';

  @override
  String get error => '오류';

  @override
  String errorMessage(String message) {
    return '오류: $message';
  }

  @override
  String get retry => '다시 시도';

  @override
  String get loading => '로딩 중...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => '설정';

  @override
  String get language => '언어';

  @override
  String get allBooks => '모든 책';

  @override
  String get unsortedBooks => '미분류';

  @override
  String get shelves => '서가';

  @override
  String get createShelf => '서가 만들기';

  @override
  String get editShelf => '서가 편집';

  @override
  String get shelfName => '서가 이름';

  @override
  String get deleteShelf => '서가 삭제';

  @override
  String get openAllBooks => '모두 열기';

  @override
  String get searchBooks => '책 검색...';

  @override
  String get searchShelves => '서가 검색...';

  @override
  String get noBooks => '책을 찾을 수 없음';

  @override
  String get noBooksInShelf => '서가가 비어 있음';

  @override
  String get scanForNewBooks => '새 책 스캔';

  @override
  String get scan => '스캔';

  @override
  String get initializingLibrary => '초기화 중...';

  @override
  String get loadingLibrary => '로딩 중...';

  @override
  String get backToWelcome => '돌아가기';

  @override
  String get addToShelf => '서가에 추가';

  @override
  String get removeFromShelf => '서가에서 제거';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count권',
      zero: '책 없음',
    );
    return '$_temp0';
  }

  @override
  String get cancel => '취소';

  @override
  String get create => '만들기';

  @override
  String get delete => '삭제';

  @override
  String get selected => '선택됨';

  @override
  String get openSelected => '선택 항목 열기';

  @override
  String get selectAll => '모두 선택';

  @override
  String get clearSelection => '선택 해제';

  @override
  String get deleteFromShelf => '서가에서 삭제';

  @override
  String get remove => '제거';

  @override
  String get open => '열기';

  @override
  String get properties => '속성';

  @override
  String get bookProperties => '책 속성';

  @override
  String get alias => '별칭';

  @override
  String get filePath => '파일 경로';

  @override
  String get author => '저자';

  @override
  String get title => '제목';

  @override
  String get pageCount => '페이지';

  @override
  String get fileSize => '파일 크기';

  @override
  String get save => '저장';

  @override
  String get shortcuts => '단축키';

  @override
  String get keyboardShortcuts => '키보드 단축키';

  @override
  String get deleteBook => '삭제';

  @override
  String get deleteSelected => '선택 항목 삭제';

  @override
  String get deleteAll => '모두 삭제';

  @override
  String get confirmDeleteBook => '책을 삭제하시겠습니까?';

  @override
  String get confirmDeleteBookMessage => '파일이 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get confirmDeleteSelected => '선택한 책을 삭제하시겠습니까?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return '$count개 파일이 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String get confirmDeleteAll => '모든 책을 삭제하시겠습니까?';

  @override
  String confirmDeleteAllMessage(int count) {
    return '이 서가의 $count개 파일이 모두 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String get aboutTabularium => 'Tabularium 정보';

  @override
  String get ok => '확인';

  @override
  String get toggleViewMode => '보기 전환';

  @override
  String get theme => '테마';

  @override
  String get help => '도움말';

  @override
  String get about => '정보';

  @override
  String get resetSettings => '설정 초기화';

  @override
  String get fontSize => '글꼴 크기';

  @override
  String get bookScaleGrid => '책 크기 (그리드)';

  @override
  String get bookScaleCabinet => '책 크기 (서가)';

  @override
  String get add => '추가';

  @override
  String get selectShelf => '서가 선택';

  @override
  String get sortDateAddedNewest => '추가일 ↓';

  @override
  String get sortDateAddedOldest => '추가일 ↑';

  @override
  String get sortDateOpenedNewest => '열린 날짜 ↓';

  @override
  String get sortDateOpenedOldest => '열린 날짜 ↑';

  @override
  String get sortTitleAZ => '제목 A-Z';

  @override
  String get sortTitleZA => '제목 Z-A';

  @override
  String get searchThemes => '테마 검색...';

  @override
  String get sizeSmall => '작게';

  @override
  String get sizeMedium => '중간';

  @override
  String get sizeNormal => '보통';

  @override
  String get sizeLarge => '크게';

  @override
  String get sizeExtraLarge => '매우 크게';

  @override
  String get sizeTiny => '아주 작게';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => '일반';

  @override
  String get shortcutsNavigationShelves => '탐색 - 서가';

  @override
  String get shortcutsNavigationBooks => '탐색 - 책';

  @override
  String get shortcutsShelves => '서가';

  @override
  String get shortcutsBooks => '책';

  @override
  String get shortcutToggleScreen => '도서관과 시작 화면 전환';

  @override
  String get shortcutCreateShelf => '새 서가 만들기';

  @override
  String get shortcutOpenBooks => '책 열기 (전체 또는 선택)';

  @override
  String get shortcutSelectAll => '모두 선택';

  @override
  String get shortcutClearSelection => '선택 해제';

  @override
  String get shortcutQuickShelf => '서가 빠른 선택 (처음 10개)';

  @override
  String get shortcutEdit => '서가 편집 / 책 속성';

  @override
  String get shortcutToggleView => '보기 모드 전환 (그리드/서가)';

  @override
  String get shortcutAddToShelf => '서가에 추가 (선택/포커스/전체)';

  @override
  String get shortcutFocusCenter => '중앙 표시 책에 포커스';

  @override
  String get shortcutJumpFirst => '첫 번째 서가/책으로 이동';

  @override
  String get shortcutJumpLast => '마지막 서가/책으로 이동';

  @override
  String get shortcutFocusSearch => '검색 필드 포커스/해제';

  @override
  String get shortcutSwitchFocus => '서가와 책 사이 포커스 전환';

  @override
  String get shortcutMoveDown => '아래로 이동';

  @override
  String get shortcutMoveUp => '위로 이동';

  @override
  String get shortcutMoveLeft => '왼쪽으로 이동';

  @override
  String get shortcutMoveRight => '오른쪽으로 이동';

  @override
  String get shortcutMoveShelfDown => '서가 아래로 이동';

  @override
  String get shortcutMoveShelfUp => '서가 위로 이동';

  @override
  String get shortcutDeleteShelf => '서가 삭제';

  @override
  String get shortcutOpenFocused => '포커스된 책 열기';

  @override
  String get shortcutToggleSelection => '포커스된 책 선택 전환';

  @override
  String get shortcutRemoveFromShelf => '선택한 책을 서가에서 제거';

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
