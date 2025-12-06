// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'あなたの個人図書館';

  @override
  String get selectBooksDirectory => '本のフォルダを選択';

  @override
  String get recentDirectories => '最近使用';

  @override
  String get favorites => 'お気に入り';

  @override
  String get clearRecent => '最近使用をクリア';

  @override
  String get clearFavorites => 'お気に入りをクリア';

  @override
  String get addToFavorites => 'お気に入りに追加';

  @override
  String get removeFromFavorites => 'お気に入りから削除';

  @override
  String get directoryNotFound => 'フォルダが見つかりません';

  @override
  String directoryNotFoundMessage(String path) {
    return 'フォルダ \"$path\" は存在しないか、アクセスできません。最近使用から削除されました。';
  }

  @override
  String get mainScreen => 'メイン画面';

  @override
  String get selectedDirectory => '選択されたフォルダ：';

  @override
  String get error => 'エラー';

  @override
  String errorMessage(String message) {
    return 'エラー：$message';
  }

  @override
  String get retry => '再試行';

  @override
  String get loading => '読み込み中...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get allBooks => 'すべての本';

  @override
  String get unsortedBooks => '未整理';

  @override
  String get shelves => '本棚';

  @override
  String get createShelf => '本棚を作成';

  @override
  String get editShelf => '本棚を編集';

  @override
  String get shelfName => '本棚名';

  @override
  String get deleteShelf => '本棚を削除';

  @override
  String get openAllBooks => 'すべて開く';

  @override
  String get searchBooks => '本を検索...';

  @override
  String get searchShelves => '本棚を検索...';

  @override
  String get noBooks => '本が見つかりません';

  @override
  String get noBooksInShelf => '本棚は空です';

  @override
  String get scanForNewBooks => '新しい本をスキャン';

  @override
  String get scan => 'スキャン';

  @override
  String get initializingLibrary => '初期化中...';

  @override
  String get loadingLibrary => '読み込み中...';

  @override
  String get backToWelcome => '戻る';

  @override
  String get addToShelf => '本棚に追加';

  @override
  String get removeFromShelf => '本棚から削除';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count冊',
      zero: '本なし',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get create => '作成';

  @override
  String get delete => '削除';

  @override
  String get selected => '選択中';

  @override
  String get openSelected => '選択を開く';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get clearSelection => '選択解除';

  @override
  String get deleteFromShelf => '本棚から削除';

  @override
  String get remove => '削除';

  @override
  String get open => '開く';

  @override
  String get properties => 'プロパティ';

  @override
  String get bookProperties => '本のプロパティ';

  @override
  String get alias => '別名';

  @override
  String get filePath => 'ファイルパス';

  @override
  String get author => '著者';

  @override
  String get title => 'タイトル';

  @override
  String get pageCount => 'ページ数';

  @override
  String get fileSize => 'ファイルサイズ';

  @override
  String get save => '保存';

  @override
  String get shortcuts => 'ショートカット';

  @override
  String get keyboardShortcuts => 'キーボードショートカット';

  @override
  String get deleteBook => '削除';

  @override
  String get deleteSelected => '選択を削除';

  @override
  String get deleteAll => 'すべて削除';

  @override
  String get confirmDeleteBook => '本を削除しますか？';

  @override
  String get confirmDeleteBookMessage => 'ファイルは完全に削除されます。この操作は元に戻せません。';

  @override
  String get confirmDeleteSelected => '選択した本を削除しますか？';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return '$count個のファイルが完全に削除されます。この操作は元に戻せません。';
  }

  @override
  String get confirmDeleteAll => 'すべての本を削除しますか？';

  @override
  String confirmDeleteAllMessage(int count) {
    return 'この本棚の$count個のファイルがすべて完全に削除されます。この操作は元に戻せません。';
  }

  @override
  String get aboutTabularium => 'Tabulariumについて';

  @override
  String get ok => 'OK';

  @override
  String get toggleViewMode => '表示切替';

  @override
  String get theme => 'テーマ';

  @override
  String get help => 'ヘルプ';

  @override
  String get about => 'について';

  @override
  String get resetSettings => '設定リセット';

  @override
  String get fontSize => 'フォントサイズ';

  @override
  String get bookScaleGrid => '本のスケール（グリッド）';

  @override
  String get bookScaleCabinet => '本のスケール（本棚）';

  @override
  String get add => '追加';

  @override
  String get selectShelf => '本棚を選択';

  @override
  String get sortDateAddedNewest => '追加日 ↓';

  @override
  String get sortDateAddedOldest => '追加日 ↑';

  @override
  String get sortDateOpenedNewest => '開いた日 ↓';

  @override
  String get sortDateOpenedOldest => '開いた日 ↑';

  @override
  String get sortTitleAZ => 'タイトル A-Z';

  @override
  String get sortTitleZA => 'タイトル Z-A';

  @override
  String get searchThemes => 'テーマを検索...';

  @override
  String get sizeSmall => '小';

  @override
  String get sizeMedium => '中';

  @override
  String get sizeNormal => '通常';

  @override
  String get sizeLarge => '大';

  @override
  String get sizeExtraLarge => '特大';

  @override
  String get sizeTiny => '極小';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => '一般';

  @override
  String get shortcutsNavigationShelves => 'ナビゲーション - 本棚';

  @override
  String get shortcutsNavigationBooks => 'ナビゲーション - 本';

  @override
  String get shortcutsShelves => '本棚';

  @override
  String get shortcutsBooks => '本';

  @override
  String get shortcutToggleScreen => '図書館とウェルカム画面を切替';

  @override
  String get shortcutCreateShelf => '新しい本棚を作成';

  @override
  String get shortcutOpenBooks => '本を開く（すべてまたは選択）';

  @override
  String get shortcutSelectAll => 'すべて選択';

  @override
  String get shortcutClearSelection => '選択解除';

  @override
  String get shortcutQuickShelf => '本棚クイック選択（最初の10個）';

  @override
  String get shortcutEdit => '本棚を編集 / 本のプロパティ';

  @override
  String get shortcutToggleView => '表示モード切替（グリッド/本棚）';

  @override
  String get shortcutAddToShelf => '本棚に追加（選択/フォーカス/すべて）';

  @override
  String get shortcutFocusCenter => '中央の表示本にフォーカス';

  @override
  String get shortcutJumpFirst => '最初の本棚/本へジャンプ';

  @override
  String get shortcutJumpLast => '最後の本棚/本へジャンプ';

  @override
  String get shortcutFocusSearch => '検索フィールドをフォーカス/解除';

  @override
  String get shortcutSwitchFocus => '本棚と本の間でフォーカス切替';

  @override
  String get shortcutMoveDown => '下へ移動';

  @override
  String get shortcutMoveUp => '上へ移動';

  @override
  String get shortcutMoveLeft => '左へ移動';

  @override
  String get shortcutMoveRight => '右へ移動';

  @override
  String get shortcutMoveShelfDown => '本棚を下へ移動';

  @override
  String get shortcutMoveShelfUp => '本棚を上へ移動';

  @override
  String get shortcutDeleteShelf => '本棚を削除';

  @override
  String get shortcutOpenFocused => 'フォーカスされた本を開く';

  @override
  String get shortcutToggleSelection => 'フォーカスされた本の選択を切替';

  @override
  String get shortcutRemoveFromShelf => '選択した本を本棚から削除';

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
      '0 = many specific shelves, 1 = few broad shelves';

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
}
