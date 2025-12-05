// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Tabularium';

  @override
  String get appSubtitle => 'Kişisel Kütüphaneniz';

  @override
  String get selectBooksDirectory => 'Kitap Klasörü Seç';

  @override
  String get recentDirectories => 'Son Kullanılanlar';

  @override
  String get favorites => 'Favoriler';

  @override
  String get clearRecent => 'Son Kullanılanları Temizle';

  @override
  String get clearFavorites => 'Favorileri Temizle';

  @override
  String get addToFavorites => 'Favorilere Ekle';

  @override
  String get removeFromFavorites => 'Favorilerden Çıkar';

  @override
  String get directoryNotFound => 'Klasör bulunamadı';

  @override
  String directoryNotFoundMessage(String path) {
    return '\"$path\" klasörü mevcut değil veya erişilemiyor. Son kullanılanlardan kaldırıldı.';
  }

  @override
  String get mainScreen => 'Ana Ekran';

  @override
  String get selectedDirectory => 'Seçilen klasör:';

  @override
  String get error => 'Hata';

  @override
  String errorMessage(String message) {
    return 'Hata: $message';
  }

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get settings => 'Ayarlar';

  @override
  String get language => 'Dil';

  @override
  String get allBooks => 'Tüm Kitaplar';

  @override
  String get unsortedBooks => 'Sınıflandırılmamış';

  @override
  String get shelves => 'Raflar';

  @override
  String get createShelf => 'Raf Oluştur';

  @override
  String get editShelf => 'Rafı Düzenle';

  @override
  String get shelfName => 'Raf Adı';

  @override
  String get deleteShelf => 'Rafı Sil';

  @override
  String get openAllBooks => 'Tümünü Aç';

  @override
  String get searchBooks => 'Kitap ara...';

  @override
  String get searchShelves => 'Raf ara...';

  @override
  String get noBooks => 'Kitap bulunamadı';

  @override
  String get noBooksInShelf => 'Raf boş';

  @override
  String get scanForNewBooks => 'Yeni Kitapları Tara';

  @override
  String get scan => 'Tara';

  @override
  String get initializingLibrary => 'Başlatılıyor...';

  @override
  String get loadingLibrary => 'Yükleniyor...';

  @override
  String get backToWelcome => 'Geri Dön';

  @override
  String get addToShelf => 'Rafa Ekle';

  @override
  String get removeFromShelf => 'Raftan Çıkar';

  @override
  String bookCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kitap',
      one: '1 kitap',
      zero: 'Kitap yok',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'İptal';

  @override
  String get create => 'Oluştur';

  @override
  String get delete => 'Sil';

  @override
  String get selected => 'seçildi';

  @override
  String get openSelected => 'Seçileni Aç';

  @override
  String get selectAll => 'Tümünü Seç';

  @override
  String get clearSelection => 'Seçimi Temizle';

  @override
  String get deleteFromShelf => 'Raftan Sil';

  @override
  String get remove => 'Çıkar';

  @override
  String get open => 'Aç';

  @override
  String get properties => 'Özellikler';

  @override
  String get bookProperties => 'Kitap Özellikleri';

  @override
  String get alias => 'Takma Ad';

  @override
  String get filePath => 'Dosya Yolu';

  @override
  String get author => 'Yazar';

  @override
  String get title => 'Başlık';

  @override
  String get pageCount => 'Sayfa';

  @override
  String get fileSize => 'Dosya Boyutu';

  @override
  String get save => 'Kaydet';

  @override
  String get shortcuts => 'Kısayollar';

  @override
  String get keyboardShortcuts => 'Klavye Kısayolları';

  @override
  String get deleteBook => 'Sil';

  @override
  String get deleteSelected => 'Seçileni Sil';

  @override
  String get deleteAll => 'Tümünü Sil';

  @override
  String get confirmDeleteBook => 'Kitap Silinsin mi?';

  @override
  String get confirmDeleteBookMessage =>
      'Dosya kalıcı olarak silinecek. Bu işlem geri alınamaz.';

  @override
  String get confirmDeleteSelected => 'Seçilenler Silinsin mi?';

  @override
  String confirmDeleteSelectedMessage(int count) {
    return '$count dosya kalıcı olarak silinecek. Bu işlem geri alınamaz.';
  }

  @override
  String get confirmDeleteAll => 'Tümü Silinsin mi?';

  @override
  String confirmDeleteAllMessage(int count) {
    return 'Bu raftaki tüm $count dosya kalıcı olarak silinecek. Bu işlem geri alınamaz.';
  }

  @override
  String get aboutTabularium => 'Tabularium Hakkında';

  @override
  String get ok => 'Tamam';

  @override
  String get toggleViewMode => 'Görünümü Değiştir';

  @override
  String get theme => 'Tema';

  @override
  String get help => 'Yardım';

  @override
  String get about => 'Hakkında';

  @override
  String get resetSettings => 'Sıfırla';

  @override
  String get fontSize => 'Yazı Boyutu';

  @override
  String get bookScaleGrid => 'Ölçek (Izgara)';

  @override
  String get bookScaleCabinet => 'Ölçek (Dolap)';

  @override
  String get add => 'Ekle';

  @override
  String get selectShelf => 'Raf Seç';

  @override
  String get sortDateAddedNewest => 'Eklenme ↓';

  @override
  String get sortDateAddedOldest => 'Eklenme ↑';

  @override
  String get sortDateOpenedNewest => 'Açılma ↓';

  @override
  String get sortDateOpenedOldest => 'Açılma ↑';

  @override
  String get sortTitleAZ => 'Başlık A-Z';

  @override
  String get sortTitleZA => 'Başlık Z-A';
}
