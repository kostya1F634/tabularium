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
}
