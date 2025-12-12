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
  String get favorites => 'Избранное';

  @override
  String get clearRecent => 'Очистить недавние';

  @override
  String get clearFavorites => 'Очистить избранное';

  @override
  String get addToFavorites => 'Добавить в избранное';

  @override
  String get removeFromFavorites => 'Убрать из избранного';

  @override
  String get directoryNotFound => 'Директория не найдена';

  @override
  String directoryNotFoundMessage(String path) {
    return 'Директория \"$path\" больше не существует или недоступна. Она была удалена из списка недавних.';
  }

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
  String get unsortedBooks => 'Без полки';

  @override
  String get shelves => 'Полки';

  @override
  String get createShelf => 'Создать полку';

  @override
  String get editShelf => 'Редактировать полку';

  @override
  String get shelfName => 'Название полки';

  @override
  String get deleteShelf => 'Удалить полку';

  @override
  String get openAllBooks => 'Открыть все книги';

  @override
  String get searchBooks => 'Поиск книг...';

  @override
  String get searchShelves => 'Поиск полок...';

  @override
  String get noBooks => 'Книги не найдены';

  @override
  String get noBooksInShelf => 'На этой полке нет книг';

  @override
  String get scanForNewBooks => 'Сканировать новые книги';

  @override
  String get scan => 'Сканировать';

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

  @override
  String get remove => 'Убрать';

  @override
  String get open => 'Открыть';

  @override
  String get properties => 'Свойства';

  @override
  String get bookProperties => 'Свойства книги';

  @override
  String get alias => 'Псевдоним';

  @override
  String get filePath => 'Путь к файлу';

  @override
  String get author => 'Автор';

  @override
  String get title => 'Название';

  @override
  String get pageCount => 'Страниц';

  @override
  String get fileSize => 'Размер файла';

  @override
  String get save => 'Сохранить';

  @override
  String get shortcuts => 'Горячие клавиши';

  @override
  String get keyboardShortcuts => 'Горячие клавиши';

  @override
  String get deleteBook => 'Удалить';

  @override
  String get deleteSelected => 'Удалить выбранные';

  @override
  String get deleteAll => 'Удалить всё';

  @override
  String get confirmDeleteBook => 'Удалить книгу?';

  @override
  String get confirmDeleteBookMessage =>
      'Файл книги будет удалён с диска навсегда. Это действие нельзя отменить.';

  @override
  String get confirmDeleteSelected => 'Удалить выбранные книги?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файлов книг',
      few: 'файла книг',
      one: 'файл книги',
    );
    return '$count $_temp0 будут удалены с диска навсегда. Это действие нельзя отменить.';
  }

  @override
  String get confirmDeleteAll => 'Удалить все книги?';

  @override
  String confirmDeleteAllMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файлов книг',
      few: 'файла книг',
      one: 'файл книги',
    );
    return 'Все $count $_temp0 с этой полки будут удалены с диска навсегда. Это действие нельзя отменить.';
  }

  @override
  String get aboutTabularium => 'О программе Tabularium';

  @override
  String get ok => 'ОК';

  @override
  String get toggleViewMode => 'Переключить режим просмотра';

  @override
  String get theme => 'Тема';

  @override
  String get help => 'Справка';

  @override
  String get about => 'О программе';

  @override
  String get resetSettings => 'Сбросить настройки';

  @override
  String get fontSize => 'Размер шрифта';

  @override
  String get bookScaleGrid => 'Масштаб книг (Сетка)';

  @override
  String get bookScaleCabinet => 'Масштаб книг (Шкаф)';

  @override
  String get add => 'Добавить';

  @override
  String get selectShelf => 'Выбрать полку';

  @override
  String get sortDateAddedNewest => 'Дата добавления ↓';

  @override
  String get sortDateAddedOldest => 'Дата добавления ↑';

  @override
  String get sortDateOpenedNewest => 'Дата открытия ↓';

  @override
  String get sortDateOpenedOldest => 'Дата открытия ↑';

  @override
  String get sortTitleAZ => 'Название А-Я';

  @override
  String get sortTitleZA => 'Название Я-А';

  @override
  String get searchThemes => 'Поиск тем...';

  @override
  String get sizeSmall => 'Маленький';

  @override
  String get sizeMedium => 'Средний';

  @override
  String get sizeNormal => 'Обычный';

  @override
  String get sizeLarge => 'Большой';

  @override
  String get sizeExtraLarge => 'Очень большой';

  @override
  String get sizeTiny => 'Крошечный';

  @override
  String get sizeXXL => 'XXL';

  @override
  String get shortcutsGeneral => 'Общие';

  @override
  String get shortcutsNavigationShelves => 'Навигация - Полки';

  @override
  String get shortcutsNavigationBooks => 'Навигация - Книги';

  @override
  String get shortcutsShelves => 'Полки';

  @override
  String get shortcutsBooks => 'Книги';

  @override
  String get shortcutToggleScreen =>
      'Переключение между библиотекой и главным экраном';

  @override
  String get shortcutCreateShelf => 'Создать новую полку';

  @override
  String get shortcutOpenBooks => 'Открыть книги (все или выбранные)';

  @override
  String get shortcutSelectAll => 'Выбрать все книги';

  @override
  String get shortcutClearSelection => 'Снять выделение';

  @override
  String get shortcutQuickShelf => 'Быстрый выбор полки (первые 10)';

  @override
  String get shortcutEdit => 'Редактировать полку / Свойства книги';

  @override
  String get shortcutToggleView => 'Переключить вид (Сетка/Шкаф)';

  @override
  String get shortcutAddToShelf =>
      'Добавить выбранные/фокусную/все книги на полку';

  @override
  String get shortcutFocusCenter => 'Фокус на центральной видимой книге';

  @override
  String get shortcutJumpFirst => 'Перейти к первой полке/книге';

  @override
  String get shortcutJumpLast => 'Перейти к последней полке/книге';

  @override
  String get shortcutFocusSearch => 'Фокус/снять фокус с поля поиска';

  @override
  String get shortcutSwitchFocus => 'Переключить фокус между полками и книгами';

  @override
  String get shortcutMoveDown => 'Вниз';

  @override
  String get shortcutMoveUp => 'Вверх';

  @override
  String get shortcutMoveLeft => 'Влево';

  @override
  String get shortcutMoveRight => 'Вправо';

  @override
  String get shortcutMoveShelfDown => 'Переместить полку вниз';

  @override
  String get shortcutMoveShelfUp => 'Переместить полку вверх';

  @override
  String get shortcutDeleteShelf => 'Удалить полку';

  @override
  String get shortcutOpenFocused => 'Открыть фокусную книгу';

  @override
  String get shortcutToggleSelection => 'Переключить выделение фокусной книги';

  @override
  String get shortcutRemoveFromShelf => 'Удалить выбранные книги с полки';

  @override
  String get ai => 'ИИ';

  @override
  String get aiSettings => 'Настройки ИИ';

  @override
  String get aiFullSort => 'Полная сортировка';

  @override
  String get ollamaUrl => 'Ollama URL';

  @override
  String get ollamaModel => 'Модель Ollama';

  @override
  String get generalization => 'Обобщение';

  @override
  String get generalizationHint =>
      '0 = много узких полок, 100 = мало широких полок';

  @override
  String get maxPages => 'Макс. страниц';

  @override
  String get maxPagesHint =>
      'Количество страниц для анализа книги (1-50, начиная со 2-й страницы)';

  @override
  String get processImages => 'Обрабатывать изображения';

  @override
  String get processImagesHint =>
      'Использовать обложку книги как визуальный контекст для анализа (требуется модель с vision)';

  @override
  String get testConnection => 'Проверить соединение';

  @override
  String get connectionSuccess => 'Соединение установлено!';

  @override
  String get connectionFailed => 'Ошибка соединения';

  @override
  String get analyzeBook => 'Анализ книги';

  @override
  String get analyzingBooks => 'Анализ книг...';

  @override
  String get sortingLibrary => 'Сортировка библиотеки...';

  @override
  String get aiSortComplete => 'Сортировка ИИ завершена';

  @override
  String get aiSortFailed => 'Ошибка сортировки ИИ';

  @override
  String booksAnalyzed(int count) {
    return 'Проанализировано книг: $count';
  }

  @override
  String shelvesCreated(int count) {
    return 'Создано новых полок: $count';
  }

  @override
  String get aiRename => 'Авто-заголовки';

  @override
  String get aiSort => 'Сортировать';

  @override
  String get aiTitle => 'ИИ: Название и теги';

  @override
  String get outputLanguage => 'Язык вывода';

  @override
  String get outputLanguageHint =>
      'Язык для названий полок, тегов и размышлений (названия книг остаются на оригинальном языке)';

  @override
  String get testLanguage => 'Проверить язык';

  @override
  String get languageTestResult => 'Результат проверки языка';

  @override
  String get includeDetailedExamples => 'Включать детальные примеры';

  @override
  String get includeDetailedExamplesHint =>
      'Включать примеры ХОРОШИХ/ПЛОХИХ тегов в запросы (уменьшает токены при отключении)';

  @override
  String get includeBookReasoning => 'Включать размышления о книгах';

  @override
  String get includeBookReasoningHint =>
      'Включать размышления ИИ о книгах при сортировке библиотеки (уменьшает токены при отключении)';

  @override
  String get includeExtendedInstructions => 'Включать расширенные инструкции';

  @override
  String get includeExtendedInstructionsHint =>
      'Включать валидационные чеклисты и детальные объяснения в запросы (уменьшает токены при отключении)';

  @override
  String get aiParameters => 'Параметры';

  @override
  String get ollamaParameters => 'Параметры Ollama';

  @override
  String get numCtx => 'Контекстное окно';

  @override
  String get numCtxHint =>
      'Количество токенов в контекстном окне (2048-32768). По умолчанию в Ollama 2048, что может быть мало для сложных запросов. Большие значения требуют больше памяти.';

  @override
  String get numCtxEffect =>
      '↑ Больше контекста → Лучше понимание | ↓ Меньше → Быстрее, меньше памяти';

  @override
  String get numPredict => 'Макс. выходных токенов';

  @override
  String get numPredictHint =>
      'Максимальное количество генерируемых токенов (128-4096, -1 без ограничений). Ограничивает длину ответа.';

  @override
  String get numPredictEffect => '↑ Длиннее ответы | ↓ Короче ответы';

  @override
  String get repeatPenalty => 'Штраф за повторы';

  @override
  String get repeatPenaltyHint =>
      'Штраф за повторяющиеся токены (0.0-2.0). Большие значения уменьшают повторения. По умолчанию: 1.1';

  @override
  String get repeatPenaltyEffect => '↑ Меньше повторов | ↓ Больше повторов';

  @override
  String get topK => 'Top-K';

  @override
  String get topKHint =>
      'Число рассматриваемых топ токенов (1-100). Меньшие значения делают вывод более фокусированным. По умолчанию: 40';

  @override
  String get topKEffect => '↑ Разнообразнее | ↓ Фокуснее';

  @override
  String get topP => 'Top-P (Nucleus)';

  @override
  String get topPHint =>
      'Порог nucleus sampling (0.0-1.0). Меньшие значения делают вывод более детерминированным. По умолчанию: 0.9';

  @override
  String get topPEffect => '↑ Креативнее | ↓ Детерминированнее';

  @override
  String get numBatch => 'Размер батча';

  @override
  String get numBatchHint =>
      'Размер батча для обработки запросов (32-1024). Уменьшите при ошибках нехватки памяти. По умолчанию: 512';

  @override
  String get numBatchEffect => '↑ Быстрее обработка | ↓ Меньше памяти';

  @override
  String get presencePenalty => 'Штраф за присутствие';

  @override
  String get presencePenaltyHint =>
      'Штрафует токены, которые уже появились (0.0-2.0). Поощряет разнообразие. Большие значения = больше вариативности тегов/полок. По умолчанию: 0.0';

  @override
  String get presencePenaltyEffect =>
      '↑ Больше вариативности | ↓ Может повторяться';

  @override
  String get frequencyPenalty => 'Штраф за частоту';

  @override
  String get frequencyPenaltyHint =>
      'Штрафует токены пропорционально частоте использования (0.0-2.0). Уменьшает повторы. По умолчанию: 0.0';

  @override
  String get frequencyPenaltyEffect =>
      '↑ Меньше частых слов | ↓ Обычные слова ОК';

  @override
  String get minP => 'Min-P';

  @override
  String get minPHint =>
      'Минимальный порог вероятности (0.0-1.0). Альтернатива Top-P. Рассматривает только токены с вероятностью ≥ min_p × макс_вероятность. По умолчанию: 0.0 (выкл)';

  @override
  String get minPEffect => '↑ Консервативнее | ↓ Разнообразнее';

  @override
  String get seed => 'Случайное зерно';

  @override
  String get seedHint =>
      'Зерно для генератора случайных чисел. -1 для случайной генерации, или фиксированное значение (напр. 42) для воспроизводимых результатов. Полезно для отладки.';

  @override
  String get seedEffect => 'Фикс. = Воспроизводимо | -1 = Случайно';

  @override
  String get stopSequences => 'Стоп-последовательности';

  @override
  String get stopSequencesHint =>
      'Стоп-последовательности через запятую (напр. \\n\\n\\n,```,---). Генерация останавливается при встрече. Экономит токены, останавливая после JSON.';

  @override
  String get stopSequencesEffect => 'Экономит токены ранней остановкой';

  @override
  String get contextParameters => 'Контекст и вывод';

  @override
  String get samplingParameters => 'Сэмплинг и креативность';

  @override
  String get penaltyParameters => 'Штрафы и контроль';

  @override
  String get resetDefaults => 'Сбросить на значения по умолчанию';

  @override
  String get advancedParameters => 'Расширенные параметры';

  @override
  String get useIncrementalSort => 'Инкрементная сортировка (Надежная)';

  @override
  String get useIncrementalSortHint =>
      'Сортировать книги по одной вместо всех сразу. Более надежный и отлаживаемый метод, но медленнее. Рекомендуется для больших библиотек или если пакетная сортировка не работает.';
}
