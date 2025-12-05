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
}
