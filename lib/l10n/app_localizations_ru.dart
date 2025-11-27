// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Ваша персональная библиотека';

  @override
  String get selectBooksDirectory => 'Выбрать директорию с книгами';

  @override
  String get recentDirectories => 'Недавние директории';

  @override
  String get mainScreen => 'Главный экран';

  @override
  String get selectedDirectory => 'Выбранная директория:';

  @override
  String get error => 'Ошибка';

  @override
  String errorMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get retry => 'Повторить';

  @override
  String get loading => 'Загрузка...';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get allBooks => 'Все книги';

  @override
  String get shelves => 'Полки';

  @override
  String get createShelf => 'Создать полку';

  @override
  String get shelfName => 'Название полки';

  @override
  String get deleteShelf => 'Удалить полку';

  @override
  String get openAllBooks => 'Открыть все книги';

  @override
  String get searchBooks => 'Поиск книг...';

  @override
  String get noBooks => 'Книги не найдены';

  @override
  String get noBooksInShelf => 'На этой полке нет книг';

  @override
  String get scanForNewBooks => 'Сканировать новые книги';

  @override
  String get initializingLibrary => 'Инициализация библиотеки...';

  @override
  String get loadingLibrary => 'Загрузка библиотеки...';

  @override
  String get backToWelcome => 'Вернуться к приветствию';

  @override
  String get addToShelf => 'Добавить на полку';

  @override
  String get removeFromShelf => 'Убрать с полки';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count книг',
      few: '$count книги',
      one: '1 книга',
      zero: 'Нет книг',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get create => 'Создать';

  @override
  String get delete => 'Удалить';

  @override
  String get selected => 'выбрано';

  @override
  String get openSelected => 'Открыть выбранные';

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get clearSelection => 'Снять выделение';

  @override
  String get deleteFromShelf => 'Удалить из полки';
}
