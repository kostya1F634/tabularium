import 'package:equatable/equatable.dart';
import '../../domain/entities/directory_path.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class WelcomeInitial extends WelcomeState {
  const WelcomeInitial();
}

/// Loading state
class WelcomeLoading extends WelcomeState {
  const WelcomeLoading();
}

/// State with loaded recent directories
class WelcomeLoaded extends WelcomeState {
  final List<DirectoryPath> recentDirectories;

  const WelcomeLoaded(this.recentDirectories);

  @override
  List<Object?> get props => [recentDirectories];
}

/// Directory picking state
class DirectoryPicking extends WelcomeState {
  const DirectoryPicking();
}

/// Successfully selected directory state
class DirectorySelected extends WelcomeState {
  final String path;

  const DirectorySelected(this.path);

  @override
  List<Object?> get props => [path];
}

/// Error state
class WelcomeError extends WelcomeState {
  final String message;

  const WelcomeError(this.message);

  @override
  List<Object?> get props => [message];
}
