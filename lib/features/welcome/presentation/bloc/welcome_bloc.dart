import 'dart:io';
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
    on<ClearRecentDirectories>(_onClearRecentDirectories);
    on<RemoveRecentDirectory>(_onRemoveRecentDirectory);
    on<LoadFavoriteDirectories>(_onLoadFavoriteDirectories);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<ClearFavorites>(_onClearFavorites);
  }

  Future<void> _onLoadRecentDirectories(
    LoadRecentDirectories event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      emit(const WelcomeLoading());

      final recentDirs = await _getRecentDirectories();
      final favoriteDirs = await _repository.getFavoriteDirectories();
      emit(
        WelcomeLoaded(
          recentDirectories: recentDirs,
          favoriteDirectories: favoriteDirs,
        ),
      );
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
        final recentDirs = await _getRecentDirectories();
        final favoriteDirs = await _repository.getFavoriteDirectories();
        emit(
          WelcomeLoaded(
            recentDirectories: recentDirs,
            favoriteDirectories: favoriteDirs,
          ),
        );
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
      // Check if directory exists
      final directory = Directory(event.path);
      if (!await directory.exists()) {
        // Remove from recent directories
        await _repository.removeRecentDirectory(event.path);
        // Reload lists
        final recentDirs = await _getRecentDirectories();
        final favoriteDirs = await _repository.getFavoriteDirectories();
        emit(
          WelcomeLoaded(
            recentDirectories: recentDirs,
            favoriteDirectories: favoriteDirs,
          ),
        );
        emit(WelcomeError('Directory not found: ${event.path}'));
        return;
      }

      // Update recent directories list (moves selected to top)
      await _repository.addRecentDirectory(event.path);
      // Save as last opened directory
      await _repository.setLastOpenedDirectory(event.path);
      emit(DirectorySelected(event.path));
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onClearRecentDirectories(
    ClearRecentDirectories event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      await _repository.clearRecentDirectories();
      final recentDirs = await _getRecentDirectories();

      if (state is WelcomeLoaded) {
        final currentState = state as WelcomeLoaded;
        emit(currentState.copyWith(recentDirectories: recentDirs));
      }
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onRemoveRecentDirectory(
    RemoveRecentDirectory event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      await _repository.removeRecentDirectory(event.path);
      final recentDirs = await _getRecentDirectories();

      if (state is WelcomeLoaded) {
        final currentState = state as WelcomeLoaded;
        emit(currentState.copyWith(recentDirectories: recentDirs));
      }
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onLoadFavoriteDirectories(
    LoadFavoriteDirectories event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      final favoriteDirs = await _repository.getFavoriteDirectories();

      if (state is WelcomeLoaded) {
        final currentState = state as WelcomeLoaded;
        emit(currentState.copyWith(favoriteDirectories: favoriteDirs));
      }
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      await _repository.addFavoriteDirectory(event.path);
      final favoriteDirs = await _repository.getFavoriteDirectories();

      if (state is WelcomeLoaded) {
        final currentState = state as WelcomeLoaded;
        emit(currentState.copyWith(favoriteDirectories: favoriteDirs));
      }
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      await _repository.removeFavoriteDirectory(event.path);
      final favoriteDirs = await _repository.getFavoriteDirectories();

      if (state is WelcomeLoaded) {
        final currentState = state as WelcomeLoaded;
        emit(currentState.copyWith(favoriteDirectories: favoriteDirs));
      }
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }

  Future<void> _onClearFavorites(
    ClearFavorites event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      await _repository.clearFavoriteDirectories();
      final favoriteDirs = await _repository.getFavoriteDirectories();

      if (state is WelcomeLoaded) {
        final currentState = state as WelcomeLoaded;
        emit(currentState.copyWith(favoriteDirectories: favoriteDirs));
      }
    } catch (e) {
      emit(WelcomeError(e.toString()));
    }
  }
}
