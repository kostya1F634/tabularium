import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object?> get props => [];
}

/// Event for loading recent directories
class LoadRecentDirectories extends WelcomeEvent {
  const LoadRecentDirectories();
}

/// Event for picking directory via dialog
class PickDirectory extends WelcomeEvent {
  const PickDirectory();
}

/// Event for selecting directory from recent list
class SelectRecentDirectory extends WelcomeEvent {
  final String path;

  const SelectRecentDirectory(this.path);

  @override
  List<Object?> get props => [path];
}

/// Event for clearing recent directories
class ClearRecentDirectories extends WelcomeEvent {
  const ClearRecentDirectories();
}

/// Event for removing specific directory from recent
class RemoveRecentDirectory extends WelcomeEvent {
  final String path;

  const RemoveRecentDirectory(this.path);

  @override
  List<Object?> get props => [path];
}

/// Event for loading favorite directories
class LoadFavoriteDirectories extends WelcomeEvent {
  const LoadFavoriteDirectories();
}

/// Event for adding directory to favorites
class AddToFavorites extends WelcomeEvent {
  final String path;

  const AddToFavorites(this.path);

  @override
  List<Object?> get props => [path];
}

/// Event for removing directory from favorites
class RemoveFromFavorites extends WelcomeEvent {
  final String path;

  const RemoveFromFavorites(this.path);

  @override
  List<Object?> get props => [path];
}

/// Event for clearing all favorites
class ClearFavorites extends WelcomeEvent {
  const ClearFavorites();
}
