// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Votre Bibliothèque Personnelle';

  @override
  String get selectBooksDirectory => 'Sélectionner le Dossier';

  @override
  String get recentDirectories => 'Récents';

  @override
  String get favorites => 'Favoris';

  @override
  String get clearRecent => 'Effacer Récents';

  @override
  String get clearFavorites => 'Effacer Favoris';

  @override
  String get addToFavorites => 'Ajouter aux Favoris';

  @override
  String get removeFromFavorites => 'Retirer des Favoris';

  @override
  String get directoryNotFound => 'Dossier introuvable';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Le dossier \"$path\" n\'existe plus ou est inaccessible. Il a été retiré des récents.';
  }

  @override
  String get mainScreen => 'Écran Principal';

  @override
  String get selectedDirectory => 'Dossier sélectionné :';

  @override
  String get error => 'Erreur';

  @override
  String errorMessage(String message) {
    return 'Erreur : $message';
  }

  @override
  String get retry => 'Réessayer';

  @override
  String get loading => 'Chargement...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get allBooks => 'Tous les Livres';

  @override
  String get unsortedBooks => 'Non Triés';

  @override
  String get shelves => 'Étagères';

  @override
  String get createShelf => 'Créer Étagère';

  @override
  String get editShelf => 'Modifier Étagère';

  @override
  String get shelfName => 'Nom de l\'Étagère';

  @override
  String get deleteShelf => 'Supprimer Étagère';

  @override
  String get openAllBooks => 'Tout Ouvrir';

  @override
  String get searchBooks => 'Rechercher...';

  @override
  String get searchShelves => 'Rechercher étagères...';

  @override
  String get noBooks => 'Aucun livre trouvé';

  @override
  String get noBooksInShelf => 'Étagère vide';

  @override
  String get scanForNewBooks => 'Scanner Nouveaux Livres';

  @override
  String get scan => 'Scanner';

  @override
  String get initializingLibrary => 'Initialisation...';

  @override
  String get loadingLibrary => 'Chargement...';

  @override
  String get backToWelcome => 'Retour';

  @override
  String get addToShelf => 'Ajouter à l\'Étagère';

  @override
  String get removeFromShelf => 'Retirer de l\'Étagère';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count livres',
      one: '1 livre',
      zero: 'Aucun livre',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get create => 'Créer';

  @override
  String get delete => 'Supprimer';

  @override
  String get selected => 'sélectionné(s)';

  @override
  String get openSelected => 'Ouvrir Sélection';

  @override
  String get selectAll => 'Tout Sélectionner';

  @override
  String get clearSelection => 'Effacer Sélection';

  @override
  String get deleteFromShelf => 'Supprimer de l\'Étagère';

  @override
  String get remove => 'Retirer';

  @override
  String get open => 'Ouvrir';

  @override
  String get properties => 'Propriétés';

  @override
  String get bookProperties => 'Propriétés du Livre';

  @override
  String get alias => 'Alias';

  @override
  String get filePath => 'Chemin du Fichier';

  @override
  String get author => 'Auteur';

  @override
  String get title => 'Titre';

  @override
  String get pageCount => 'Pages';

  @override
  String get fileSize => 'Taille';

  @override
  String get save => 'Enregistrer';

  @override
  String get shortcuts => 'Raccourcis';

  @override
  String get keyboardShortcuts => 'Raccourcis Clavier';

  @override
  String get deleteBook => 'Supprimer';

  @override
  String get deleteSelected => 'Supprimer Sélection';

  @override
  String get deleteAll => 'Tout Supprimer';

  @override
  String get confirmDeleteBook => 'Supprimer le Livre ?';

  @override
  String get confirmDeleteBookMessage =>
      'Le fichier sera définitivement supprimé. Action irréversible.';

  @override
  String get confirmDeleteSelected => 'Supprimer la Sélection ?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fichiers seront supprimés',
      one: 'fichier sera supprimé',
    );
    return '$count $_temp0 définitivement. Action irréversible.';
  }

  @override
  String get confirmDeleteAll => 'Tout Supprimer ?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fichiers',
      one: 'fichier',
    );
    return 'Tous les $count $_temp0 de cette étagère seront définitivement supprimés. Action irréversible.';
  }

  @override
  String get aboutTabularium => 'À Propos';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => 'Changer Vue';

  @override
  String get theme => 'Thème';

  @override
  String get help => 'Aide';

  @override
  String get about => 'À Propos';

  @override
  String get resetSettings => 'Réinitialiser';

  @override
  String get fontSize => 'Taille Police';

  @override
  String get bookScaleGrid => 'Échelle (Grille)';

  @override
  String get bookScaleCabinet => 'Échelle (Armoire)';

  @override
  String get add => 'Ajouter';

  @override
  String get selectShelf => 'Sélectionner Étagère';

  @override
  String get sortDateAddedNewest => 'Ajout ↓';

  @override
  String get sortDateAddedOldest => 'Ajout ↑';

  @override
  String get sortDateOpenedNewest => 'Ouvert ↓';

  @override
  String get sortDateOpenedOldest => 'Ouvert ↑';

  @override
  String get sortTitleAZ => 'Titre A-Z';

  @override
  String get sortTitleZA => 'Titre Z-A';

  @override
  String get searchThemes => 'Rechercher thèmes...';

  @override
  String get sizeSmall => 'Petit';

  @override
  String get sizeMedium => 'Moyen';

  @override
  String get sizeNormal => 'Normal';

  @override
  String get sizeLarge => 'Grand';

  @override
  String get sizeExtraLarge => 'Très grand';

  @override
  String get sizeTiny => 'Minuscule';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Général';

  @override
  String get shortcutsNavigationShelves => 'Navigation - Étagères';

  @override
  String get shortcutsNavigationBooks => 'Navigation - Livres';

  @override
  String get shortcutsShelves => 'Étagères';

  @override
  String get shortcutsBooks => 'Livres';

  @override
  String get shortcutToggleScreen =>
      'Basculer entre bibliothèque et écran d\'accueil';

  @override
  String get shortcutCreateShelf => 'Créer nouvelle étagère';

  @override
  String get shortcutOpenBooks => 'Ouvrir livres (tous ou sélectionnés)';

  @override
  String get shortcutSelectAll => 'Tout sélectionner';

  @override
  String get shortcutClearSelection => 'Effacer sélection';

  @override
  String get shortcutQuickShelf => 'Sélection rapide étagère (10 premières)';

  @override
  String get shortcutEdit => 'Modifier étagère / Propriétés du livre';

  @override
  String get shortcutToggleView => 'Changer mode d\'affichage (Grille/Armoire)';

  @override
  String get shortcutAddToShelf =>
      'Ajouter livres à étagère (sélectionnés/focus/tous)';

  @override
  String get shortcutFocusCenter => 'Focaliser sur livre central visible';

  @override
  String get shortcutJumpFirst => 'Aller à première étagère/livre';

  @override
  String get shortcutJumpLast => 'Aller à dernière étagère/livre';

  @override
  String get shortcutFocusSearch => 'Focaliser/défocaliser champ de recherche';

  @override
  String get shortcutSwitchFocus => 'Basculer focus entre étagères et livres';

  @override
  String get shortcutMoveDown => 'Descendre';

  @override
  String get shortcutMoveUp => 'Monter';

  @override
  String get shortcutMoveLeft => 'Aller à gauche';

  @override
  String get shortcutMoveRight => 'Aller à droite';

  @override
  String get shortcutMoveShelfDown => 'Déplacer étagère vers le bas';

  @override
  String get shortcutMoveShelfUp => 'Déplacer étagère vers le haut';

  @override
  String get shortcutDeleteShelf => 'Supprimer étagère';

  @override
  String get shortcutOpenFocused => 'Ouvrir livre focalisé';

  @override
  String get shortcutToggleSelection => 'Basculer sélection du livre focalisé';

  @override
  String get shortcutRemoveFromShelf =>
      'Retirer livres sélectionnés de l\'étagère';

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
