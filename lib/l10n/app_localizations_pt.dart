// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'A Sua Biblioteca Pessoal';

  @override
  String get selectBooksDirectory => 'Selecionar Pasta de Livros';

  @override
  String get recentDirectories => 'Recentes';

  @override
  String get favorites => 'Favoritos';

  @override
  String get clearRecent => 'Limpar Recentes';

  @override
  String get clearFavorites => 'Limpar Favoritos';

  @override
  String get addToFavorites => 'Adicionar aos Favoritos';

  @override
  String get removeFromFavorites => 'Remover dos Favoritos';

  @override
  String get directoryNotFound => 'Pasta não encontrada';

  @override
  String directoryNotFoundMessage(String path) {
    return 'A pasta \"$path\" não existe ou está inacessível. Foi removida dos recentes.';
  }

  @override
  String get mainScreen => 'Tela Principal';

  @override
  String get selectedDirectory => 'Pasta selecionada:';

  @override
  String get error => 'Erro';

  @override
  String errorMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get retry => 'Tentar Novamente';

  @override
  String get loading => 'Carregando...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Configurações';

  @override
  String get language => 'Idioma';

  @override
  String get allBooks => 'Todos os Livros';

  @override
  String get unsortedBooks => 'Sem Prateleira';

  @override
  String get shelves => 'Prateleiras';

  @override
  String get createShelf => 'Criar Prateleira';

  @override
  String get editShelf => 'Editar Prateleira';

  @override
  String get shelfName => 'Nome da Prateleira';

  @override
  String get deleteShelf => 'Excluir Prateleira';

  @override
  String get openAllBooks => 'Abrir Todos';

  @override
  String get searchBooks => 'Buscar livros...';

  @override
  String get searchShelves => 'Buscar prateleiras...';

  @override
  String get noBooks => 'Nenhum livro encontrado';

  @override
  String get noBooksInShelf => 'Prateleira vazia';

  @override
  String get scanForNewBooks => 'Escanear Novos Livros';

  @override
  String get scan => 'Escanear';

  @override
  String get initializingLibrary => 'Inicializando biblioteca...';

  @override
  String get loadingLibrary => 'Carregando biblioteca...';

  @override
  String get backToWelcome => 'Voltar';

  @override
  String get addToShelf => 'Adicionar à Prateleira';

  @override
  String get removeFromShelf => 'Remover da Prateleira';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count livros',
      one: '1 livro',
      zero: 'Nenhum livro',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get create => 'Criar';

  @override
  String get delete => 'Excluir';

  @override
  String get selected => 'selecionado(s)';

  @override
  String get openSelected => 'Abrir Selecionados';

  @override
  String get selectAll => 'Selecionar Tudo';

  @override
  String get clearSelection => 'Limpar Seleção';

  @override
  String get deleteFromShelf => 'Excluir da Prateleira';

  @override
  String get remove => 'Remover';

  @override
  String get open => 'Abrir';

  @override
  String get properties => 'Propriedades';

  @override
  String get bookProperties => 'Propriedades do Livro';

  @override
  String get alias => 'Apelido';

  @override
  String get filePath => 'Caminho do Arquivo';

  @override
  String get author => 'Autor';

  @override
  String get title => 'Título';

  @override
  String get pageCount => 'Páginas';

  @override
  String get fileSize => 'Tamanho';

  @override
  String get save => 'Salvar';

  @override
  String get shortcuts => 'Atalhos';

  @override
  String get keyboardShortcuts => 'Atalhos de Teclado';

  @override
  String get deleteBook => 'Excluir';

  @override
  String get deleteSelected => 'Excluir Selecionados';

  @override
  String get deleteAll => 'Excluir Tudo';

  @override
  String get confirmDeleteBook => 'Excluir Livro?';

  @override
  String get confirmDeleteBookMessage =>
      'O arquivo será excluído permanentemente. Ação irreversível.';

  @override
  String get confirmDeleteSelected => 'Excluir Selecionados?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'arquivos serão excluídos',
      one: 'arquivo será excluído',
    );
    return '$count $_temp0 permanentemente. Ação irreversível.';
  }

  @override
  String get confirmDeleteAll => 'Excluir Todos?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'arquivos',
      one: 'arquivo',
    );
    return 'Todos os $count $_temp0 desta prateleira serão excluídos permanentemente. Ação irreversível.';
  }

  @override
  String get aboutTabularium => 'Sobre Tabularium';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Alternar Visualização';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Ajuda';

  @override
  String get about => 'Sobre';

  @override
  String get resetSettings => 'Redefinir Configurações';

  @override
  String get fontSize => 'Tamanho da Fonte';

  @override
  String get bookScaleGrid => 'Escala (Grade)';

  @override
  String get bookScaleCabinet => 'Escala (Estante)';

  @override
  String get add => 'Adicionar';

  @override
  String get selectShelf => 'Selecionar Prateleira';

  @override
  String get sortDateAddedNewest => 'Adicionado ↓';

  @override
  String get sortDateAddedOldest => 'Adicionado ↑';

  @override
  String get sortDateOpenedNewest => 'Aberto ↓';

  @override
  String get sortDateOpenedOldest => 'Aberto ↑';

  @override
  String get sortTitleAZ => 'Título A-Z';

  @override
  String get sortTitleZA => 'Título Z-A';

  @override
  String get searchThemes => 'Pesquisar temas...';

  @override
  String get sizeSmall => 'Pequeno';

  @override
  String get sizeMedium => 'Médio';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Grande';

  @override
  String get sizeExtraLarge => 'Muito grande';

  @override
  String get sizeTiny => 'Minúsculo';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Geral';

  @override
  String get shortcutsNavigationShelves => 'Navegação - Prateleiras';

  @override
  String get shortcutsNavigationBooks => 'Navegação - Livros';

  @override
  String get shortcutsShelves => 'Prateleiras';

  @override
  String get shortcutsBooks => 'Livros';

  @override
  String get shortcutToggleScreen =>
      'Alternar entre biblioteca e tela de boas-vindas';

  @override
  String get shortcutCreateShelf => 'Criar nova prateleira';

  @override
  String get shortcutOpenBooks => 'Abrir livros (todos ou selecionados)';

  @override
  String get shortcutSelectAll => 'Selecionar tudo';

  @override
  String get shortcutClearSelection => 'Limpar seleção';

  @override
  String get shortcutQuickShelf =>
      'Seleção rápida de prateleira (primeiras 10)';

  @override
  String get shortcutEdit => 'Editar prateleira / Propriedades do livro';

  @override
  String get shortcutToggleView =>
      'Alternar modo de visualização (Grade/Estante)';

  @override
  String get shortcutAddToShelf =>
      'Adicionar livros à prateleira (selecionados/foco/todos)';

  @override
  String get shortcutFocusCenter => 'Focar no livro central visível';

  @override
  String get shortcutJumpFirst => 'Ir para primeira prateleira/livro';

  @override
  String get shortcutJumpLast => 'Ir para última prateleira/livro';

  @override
  String get shortcutFocusSearch => 'Focar/desfocar campo de pesquisa';

  @override
  String get shortcutSwitchFocus => 'Alternar foco entre prateleiras e livros';

  @override
  String get shortcutMoveDown => 'Mover para baixo';

  @override
  String get shortcutMoveUp => 'Mover para cima';

  @override
  String get shortcutMoveLeft => 'Mover para esquerda';

  @override
  String get shortcutMoveRight => 'Mover para direita';

  @override
  String get shortcutMoveShelfDown => 'Mover prateleira para baixo';

  @override
  String get shortcutMoveShelfUp => 'Mover prateleira para cima';

  @override
  String get shortcutDeleteShelf => 'Excluir prateleira';

  @override
  String get shortcutOpenFocused => 'Abrir livro em foco';

  @override
  String get shortcutToggleSelection => 'Alternar seleção do livro em foco';

  @override
  String get shortcutRemoveFromShelf =>
      'Remover livros selecionados da prateleira';

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
