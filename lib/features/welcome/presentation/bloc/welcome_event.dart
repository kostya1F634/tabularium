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
