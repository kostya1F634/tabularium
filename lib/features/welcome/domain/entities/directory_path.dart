import 'package:equatable/equatable.dart';

/// Entity representing a directory path
class DirectoryPath extends Equatable {
  final String path;
  final DateTime lastAccessed;

  const DirectoryPath({required this.path, required this.lastAccessed});

  /// Get directory name (last path segment)
  String get name {
    final segments = path.split('/');
    return segments.last.isNotEmpty
        ? segments.last
        : segments[segments.length - 2];
  }

  @override
  List<Object?> get props => [path, lastAccessed];
}
