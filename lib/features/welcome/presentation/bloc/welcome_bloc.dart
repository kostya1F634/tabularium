import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/directory_repository.dart';
import '../../domain/usecases/get_recent_directories.dart';
import '../../domain/usecases/select_directory.dart';
import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final GetRecentDirectories _getRecentDirectories;
  final SelectDirectory _selectDirectory;
  final DirectoryRepository _repository;

  WelcomeBloc({
    required GetRecentDirectories getRecentDirectories,
    required SelectDirectory selectDirectory,
    required DirectoryRepository repository,
  }) : _getRecentDirectories = getRecentDirectories,
       _selectDirectory = selectDirectory,
       _repository = repository,
       super(const WelcomeInitial()) {
    on<LoadRecentDirectories>(_onLoadRecentDirectories);
    on<PickDirectory>(_onPickDirectory);
    on<SelectRecentDirectory>(_onSelectRecentDirectory);
  }

  Future<void> _onLoadRecentDirectories(
    LoadRecentDirectories event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      emit(const WelcomeLoading());
      final directories = await _getRecentDirectories();
      emit(WelcomeLoaded(directories));
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onPickDirectory(
    PickDirectory event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      emit(const DirectoryPicking());
      final path = await _selectDirectory();
      if (path != null) {
        emit(DirectorySelected(path));
      } else {
        // Пользователь отменил выбор, возвращаемся к списку
        final directories = await _getRecentDirectories();
        emit(WelcomeLoaded(directories));
      }
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onSelectRecentDirectory(
    SelectRecentDirectory event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      // Update recent directories list (moves selected to top)
      await _repository.addRecentDirectory(event.path);
      // Save as last opened directory
      await _repository.setLastOpenedDirectory(event.path);
      emit(DirectorySelected(event.path));
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }
}
