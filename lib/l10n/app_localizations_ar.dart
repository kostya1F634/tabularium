// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'مكتبتك الشخصية';

  @override
  String get selectBooksDirectory => 'اختر مجلد الكتب';

  @override
  String get recentDirectories => 'الأخيرة';

  @override
  String get favorites => 'المفضلة';

  @override
  String get clearRecent => 'مسح الأخيرة';

  @override
  String get clearFavorites => 'مسح المفضلة';

  @override
  String get addToFavorites => 'إضافة للمفضلة';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get directoryNotFound => 'المجلد غير موجود';

  @override
  String directoryNotFoundMessage(String path) {
    return 'المجلد \"$path\" غير موجود أو غير قابل للوصول. تم إزالته من الأخيرة.';
  }

  @override
  String get mainScreen => 'الشاشة الرئيسية';

  @override
  String get selectedDirectory => 'المجلد المحدد:';

  @override
  String get error => 'خطأ';

  @override
  String errorMessage(String message) {
    return 'خطأ: $message';
  }

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get allBooks => 'جميع الكتب';

  @override
  String get unsortedBooks => 'غير مصنفة';

  @override
  String get shelves => 'الرفوف';

  @override
  String get createShelf => 'إنشاء رف';

  @override
  String get editShelf => 'تعديل رف';

  @override
  String get shelfName => 'اسم الرف';

  @override
  String get deleteShelf => 'حذف رف';

  @override
  String get openAllBooks => 'فتح الكل';

  @override
  String get searchBooks => 'بحث عن كتب...';

  @override
  String get searchShelves => 'بحث عن رفوف...';

  @override
  String get noBooks => 'لم يتم العثور على كتب';

  @override
  String get noBooksInShelf => 'الرف فارغ';

  @override
  String get scanForNewBooks => 'فحص كتب جديدة';

  @override
  String get scan => 'فحص';

  @override
  String get initializingLibrary => 'جاري التهيئة...';

  @override
  String get loadingLibrary => 'جاري التحميل...';

  @override
  String get backToWelcome => 'رجوع';

  @override
  String get addToShelf => 'إضافة للرف';

  @override
  String get removeFromShelf => 'إزالة من الرف';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count كتب',
      one: 'كتاب واحد',
      zero: 'لا توجد كتب',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get create => 'إنشاء';

  @override
  String get delete => 'حذف';

  @override
  String get selected => 'محدد';

  @override
  String get openSelected => 'فتح المحدد';

  @override
  String get selectAll => 'تحديد الكل';

  @override
  String get clearSelection => 'إلغاء التحديد';

  @override
  String get deleteFromShelf => 'حذف من الرف';

  @override
  String get remove => 'إزالة';

  @override
  String get open => 'فتح';

  @override
  String get properties => 'الخصائص';

  @override
  String get bookProperties => 'خصائص الكتاب';

  @override
  String get alias => 'الاسم المستعار';

  @override
  String get filePath => 'مسار الملف';

  @override
  String get author => 'المؤلف';

  @override
  String get title => 'العنوان';

  @override
  String get pageCount => 'الصفحات';

  @override
  String get fileSize => 'حجم الملف';

  @override
  String get save => 'حفظ';

  @override
  String get shortcuts => 'الاختصارات';

  @override
  String get keyboardShortcuts => 'اختصارات لوحة المفاتيح';

  @override
  String get deleteBook => 'حذف';

  @override
  String get deleteSelected => 'حذف المحدد';

  @override
  String get deleteAll => 'حذف الكل';

  @override
  String get confirmDeleteBook => 'حذف الكتاب؟';

  @override
  String get confirmDeleteBookMessage =>
      'سيتم حذف الملف نهائياً. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get confirmDeleteSelected => 'حذف المحدد؟';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return 'سيتم حذف $count ملف نهائياً. لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get confirmDeleteAll => 'حذف الكل؟';

  @override
  String confirmDeleteAllMessage(int count) {
    return 'سيتم حذف جميع $count ملف من هذا الرف نهائياً. لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get aboutTabularium => 'حول Tabularium';

  @override
  String get ok => 'موافق';

  @override
  String get toggleViewMode => 'تبديل العرض';

  @override
  String get theme => 'المظهر';

  @override
  String get help => 'المساعدة';

  @override
  String get about => 'حول';

  @override
  String get resetSettings => 'إعادة تعيين';

  @override
  String get fontSize => 'حجم الخط';

  @override
  String get bookScaleGrid => 'المقياس (الشبكة)';

  @override
  String get bookScaleCabinet => 'المقياس (الخزانة)';

  @override
  String get add => 'إضافة';

  @override
  String get selectShelf => 'اختر رفاً';

  @override
  String get sortDateAddedNewest => 'تاريخ الإضافة ↓';

  @override
  String get sortDateAddedOldest => 'تاريخ الإضافة ↑';

  @override
  String get sortDateOpenedNewest => 'تاريخ الفتح ↓';

  @override
  String get sortDateOpenedOldest => 'تاريخ الفتح ↑';

  @override
  String get sortTitleAZ => 'العنوان A-Z';

  @override
  String get sortTitleZA => 'العنوان Z-A';

  @override
  String get searchThemes => 'البحث عن مظاهر...';

  @override
  String get sizeSmall => 'صغير';

  @override
  String get sizeMedium => 'متوسط';

  @override
  String get sizeNormal => 'عادي';

  @override
  String get sizeLarge => 'كبير';

  @override
  String get sizeExtraLarge => 'كبير جداً';

  @override
  String get sizeTiny => 'صغير جداً';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'عام';

  @override
  String get shortcutsNavigationShelves => 'التنقل - الرفوف';

  @override
  String get shortcutsNavigationBooks => 'التنقل - الكتب';

  @override
  String get shortcutsShelves => 'الرفوف';

  @override
  String get shortcutsBooks => 'الكتب';

  @override
  String get shortcutToggleScreen => 'التبديل بين المكتبة وشاشة الترحيب';

  @override
  String get shortcutCreateShelf => 'إنشاء رف جديد';

  @override
  String get shortcutOpenBooks => 'فتح الكتب (الكل أو المحدد)';

  @override
  String get shortcutSelectAll => 'تحديد الكل';

  @override
  String get shortcutClearSelection => 'إلغاء التحديد';

  @override
  String get shortcutQuickShelf => 'اختيار رف سريع (أول 10)';

  @override
  String get shortcutEdit => 'تعديل الرف / خصائص الكتاب';

  @override
  String get shortcutToggleView => 'تبديل وضع العرض (الشبكة/الخزانة)';

  @override
  String get shortcutAddToShelf => 'إضافة كتب للرف (المحدد/المركز/الكل)';

  @override
  String get shortcutFocusCenter => 'التركيز على الكتاب المرئي الأوسط';

  @override
  String get shortcutJumpFirst => 'الانتقال لأول رف/كتاب';

  @override
  String get shortcutJumpLast => 'الانتقال لآخر رف/كتاب';

  @override
  String get shortcutFocusSearch => 'تفعيل/إلغاء حقل البحث';

  @override
  String get shortcutSwitchFocus => 'تبديل التركيز بين الرفوف والكتب';

  @override
  String get shortcutMoveDown => 'التحرك للأسفل';

  @override
  String get shortcutMoveUp => 'التحرك للأعلى';

  @override
  String get shortcutMoveLeft => 'التحرك لليسار';

  @override
  String get shortcutMoveRight => 'التحرك لليمين';

  @override
  String get shortcutMoveShelfDown => 'تحريك الرف للأسفل';

  @override
  String get shortcutMoveShelfUp => 'تحريك الرف للأعلى';

  @override
  String get shortcutDeleteShelf => 'حذف الرف';

  @override
  String get shortcutOpenFocused => 'فتح الكتاب المركز عليه';

  @override
  String get shortcutToggleSelection => 'تبديل تحديد الكتاب المركز عليه';

  @override
  String get shortcutRemoveFromShelf => 'إزالة الكتب المحددة من الرف';

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
      '0 = many specific shelves, 100 = few broad shelves';

  @override
  String get maxPages => 'Max Pages';

  @override
  String get maxPagesHint =>
      'Number of pages to read per book (1-50, starting from page 2)';

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
  String get aiRename => 'Analyze (no sorting)';

  @override
  String get aiTitle => 'AI: Title & Tags';
}
