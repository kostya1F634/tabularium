import 'package:shared_preferences/shared_preferences.dart';
import '../data/datasources/file_picker_datasource.dart';
import '../data/repositories/directory_repository_impl.dart';
import '../domain/repositories/directory_repository.dart';
import '../domain/usecases/get_recent_directories.dart';
import '../domain/usecases/select_directory.dart';
import '../presentation/bloc/welcome_bloc.dart';

/// Class for configuring Welcome module dependencies
class WelcomeDependencies {
  static DirectoryRepository createDirectoryRepository(
    SharedPreferences prefs,
  ) {
    return DirectoryRepositoryImpl(
      prefs: prefs,
      filePicker: FilePickerDataSourceImpl(),
    );
  }

  static GetRecentDirectories createGetRecentDirectoriesUseCase(
    DirectoryRepository repository,
  ) {
    return GetRecentDirectories(repository);
  }

  static SelectDirectory createSelectDirectoryUseCase(
    DirectoryRepository repository,
  ) {
    return SelectDirectory(repository);
  }

  static WelcomeBloc createWelcomeBloc(
    DirectoryRepository repository,
  ) {
    return WelcomeBloc(
      getRecentDirectories: createGetRecentDirectoriesUseCase(repository),
      selectDirectory: createSelectDirectoryUseCase(repository),
      repository: repository,
    );
  }
}
