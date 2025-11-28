import 'package:flutter_test/flutter_test.dart';
import 'package:tabularium/features/welcome/domain/entities/directory_path.dart';

void main() {
  group('DirectoryPath', () {
    test('should create DirectoryPath with path and lastAccessed', () {
      // Arrange
      const path = '/home/user/books';
      final timestamp = DateTime(2025, 1, 1);

      // Act
      final directoryPath = DirectoryPath(path: path, lastAccessed: timestamp);

      // Assert
      expect(directoryPath.path, equals(path));
      expect(directoryPath.lastAccessed, equals(timestamp));
    });

    test('should extract name from path correctly', () {
      // Arrange
      const path = '/home/user/books';
      final timestamp = DateTime(2025, 1, 1);
      final directoryPath = DirectoryPath(path: path, lastAccessed: timestamp);

      // Act
      final name = directoryPath.name;

      // Assert
      expect(name, equals('books'));
    });

    test('should handle path with trailing slash', () {
      // Arrange
      const path = '/home/user/books/';
      final timestamp = DateTime(2025, 1, 1);
      final directoryPath = DirectoryPath(path: path, lastAccessed: timestamp);

      // Act
      final name = directoryPath.name;

      // Assert
      expect(name, equals('books'));
    });

    test('should be equal when properties are the same', () {
      // Arrange
      final timestamp = DateTime(2025, 1, 1);
      const path = '/home/user/books';

      final directoryPath1 = DirectoryPath(path: path, lastAccessed: timestamp);

      final directoryPath2 = DirectoryPath(path: path, lastAccessed: timestamp);

      // Assert
      expect(directoryPath1, equals(directoryPath2));
    });

    test('should not be equal when paths differ', () {
      // Arrange
      final timestamp = DateTime(2025, 1, 1);

      final directoryPath1 = DirectoryPath(
        path: '/home/user/books',
        lastAccessed: timestamp,
      );

      final directoryPath2 = DirectoryPath(
        path: '/home/user/documents',
        lastAccessed: timestamp,
      );

      // Assert
      expect(directoryPath1, isNot(equals(directoryPath2)));
    });
  });
}
