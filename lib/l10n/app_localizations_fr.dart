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
}
