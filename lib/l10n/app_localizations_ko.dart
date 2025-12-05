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
}
