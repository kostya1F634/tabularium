// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => '您的个人图书馆';

  @override
  String get selectBooksDirectory => '选择图书目录';

  @override
  String get recentDirectories => '最近目录';

  @override
  String get favorites => '收藏';

  @override
  String get clearRecent => '清除最近';

  @override
  String get clearFavorites => '清除收藏';

  @override
  String get addToFavorites => '添加到收藏';

  @override
  String get removeFromFavorites => '从收藏中移除';

  @override
  String get directoryNotFound => '目录未找到';

  @override
  String directoryNotFoundMessage(String path) {
    return '目录 \"$path\" 不存在或无法访问。已从最近目录中移除。';
  }

  @override
  String get mainScreen => '主屏幕';

  @override
  String get selectedDirectory => '选定目录：';

  @override
  String get error => '错误';

  @override
  String errorMessage(String message) {
    return '错误：$message';
  }

  @override
  String get retry => '重试';

  @override
  String get loading => '加载中...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get allBooks => '所有图书';

  @override
  String get unsortedBooks => '未分类';

  @override
  String get shelves => '书架';

  @override
  String get createShelf => '创建书架';

  @override
  String get editShelf => '编辑书架';

  @override
  String get shelfName => '书架名称';

  @override
  String get deleteShelf => '删除书架';

  @override
  String get openAllBooks => '打开全部';

  @override
  String get searchBooks => '搜索图书...';

  @override
  String get searchShelves => '搜索书架...';

  @override
  String get noBooks => '未找到图书';

  @override
  String get noBooksInShelf => '书架为空';

  @override
  String get scanForNewBooks => '扫描新书';

  @override
  String get scan => '扫描';

  @override
  String get initializingLibrary => '初始化图书馆...';

  @override
  String get loadingLibrary => '加载图书馆...';

  @override
  String get backToWelcome => '返回欢迎页';

  @override
  String get addToShelf => '添加到书架';

  @override
  String get removeFromShelf => '从书架移除';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 本',
      zero: '无图书',
    );
    return '$_temp0';
  }

  @override
  String get cancel => '取消';

  @override
  String get create => '创建';

  @override
  String get delete => '删除';

  @override
  String get selected => '已选';

  @override
  String get openSelected => '打开选定';

  @override
  String get selectAll => '全选';

  @override
  String get clearSelection => '清除选择';

  @override
  String get deleteFromShelf => '从书架删除';

  @override
  String get remove => '移除';

  @override
  String get open => '打开';

  @override
  String get properties => '属性';

  @override
  String get bookProperties => '图书属性';

  @override
  String get alias => '别名';

  @override
  String get filePath => '文件路径';

  @override
  String get author => '作者';

  @override
  String get title => '标题';

  @override
  String get pageCount => '页数';

  @override
  String get fileSize => '文件大小';

  @override
  String get save => '保存';

  @override
  String get shortcuts => '快捷键';

  @override
  String get keyboardShortcuts => '键盘快捷键';

  @override
  String get deleteBook => '删除';

  @override
  String get deleteSelected => '删除选定';

  @override
  String get deleteAll => '全部删除';

  @override
  String get confirmDeleteBook => '删除图书？';

  @override
  String get confirmDeleteBookMessage => '将永久删除此文件，无法撤销。';

  @override
  String get confirmDeleteSelected => '删除选定图书？';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return '将永久删除 $count 个文件，无法撤销。';
  }

  @override
  String get confirmDeleteAll => '删除全部图书？';

  @override
  String confirmDeleteAllMessage(int count) {
    return '将永久删除此书架上的所有 $count 个文件，无法撤销。';
  }

  @override
  String get aboutTabularium => '关于 Tabularium';

  @override
  String get ok => '确定';

  @override
  String get toggleViewMode => '切换视图';

  @override
  String get theme => '主题';

  @override
  String get help => '帮助';

  @override
  String get about => '关于';

  @override
  String get resetSettings => '重置设置';

  @override
  String get fontSize => '字体大小';

  @override
  String get bookScaleGrid => '图书缩放（网格）';

  @override
  String get bookScaleCabinet => '图书缩放（书柜）';

  @override
  String get add => '添加';

  @override
  String get selectShelf => '选择书架';

  @override
  String get sortDateAddedNewest => '添加日期 ↓';

  @override
  String get sortDateAddedOldest => '添加日期 ↑';

  @override
  String get sortDateOpenedNewest => '打开日期 ↓';

  @override
  String get sortDateOpenedOldest => '打开日期 ↑';

  @override
  String get sortTitleAZ => '标题 A-Z';

  @override
  String get sortTitleZA => '标题 Z-A';

  @override
  String get searchThemes => '搜索主题...';

  @override
  String get sizeSmall => '小';

  @override
  String get sizeMedium => '中';

  @override
  String get sizeNormal => '正常';

  @override
  String get sizeLarge => '大';

  @override
  String get sizeExtraLarge => '超大';

  @override
  String get sizeTiny => '极小';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => '通用';

  @override
  String get shortcutsNavigationShelves => '导航 - 书架';

  @override
  String get shortcutsNavigationBooks => '导航 - 图书';

  @override
  String get shortcutsShelves => '书架';

  @override
  String get shortcutsBooks => '图书';

  @override
  String get shortcutToggleScreen => '在图书馆和欢迎屏幕之间切换';

  @override
  String get shortcutCreateShelf => '创建新书架';

  @override
  String get shortcutOpenBooks => '打开图书（全部或选定）';

  @override
  String get shortcutSelectAll => '全选图书';

  @override
  String get shortcutClearSelection => '清除选择';

  @override
  String get shortcutQuickShelf => '快速选择书架（前10个）';

  @override
  String get shortcutEdit => '编辑书架/图书属性';

  @override
  String get shortcutToggleView => '切换视图模式（网格/书柜）';

  @override
  String get shortcutAddToShelf => '将选定/聚焦/全部图书添加到书架';

  @override
  String get shortcutFocusCenter => '聚焦中间可见图书';

  @override
  String get shortcutJumpFirst => '跳到第一个书架/图书';

  @override
  String get shortcutJumpLast => '跳到最后一个书架/图书';

  @override
  String get shortcutFocusSearch => '聚焦/取消聚焦搜索框';

  @override
  String get shortcutSwitchFocus => '在书架和图书之间切换焦点';

  @override
  String get shortcutMoveDown => '向下移动';

  @override
  String get shortcutMoveUp => '向上移动';

  @override
  String get shortcutMoveLeft => '向左移动';

  @override
  String get shortcutMoveRight => '向右移动';

  @override
  String get shortcutMoveShelfDown => '向下移动书架';

  @override
  String get shortcutMoveShelfUp => '向上移动书架';

  @override
  String get shortcutDeleteShelf => '删除书架';

  @override
  String get shortcutOpenFocused => '打开聚焦图书';

  @override
  String get shortcutToggleSelection => '切换聚焦图书的选择状态';

  @override
  String get shortcutRemoveFromShelf => '从书架移除选定图书';

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
