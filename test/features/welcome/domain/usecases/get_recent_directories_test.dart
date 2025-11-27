import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabularium/features/welcome/domain/entities/directory_path.dart';
import 'package:tabularium/features/welcome/domain/repositories/directory_repository.dart';
import 'package:tabularium/features/welcome/domain/usecases/get_recent_directories.dart';

import 'get_recent_directories_test.mocks.dart';

@GenerateMocks([DirectoryRepository])
void main() {
  late GetRecentDirectories useCase;
  late MockDirectoryRepository mockRepository;

  setUp(() {
    mockRepository = MockDirectoryRepository();
    useCase = GetRecentDirectories(mockRepository);
  });

  group('GetRecentDirectories', () {
    test('should get recent directories from repository', () async {
      // Arrange
      final directories = [
        DirectoryPath(
          path: '/home/user/books',
          lastAccessed: DateTime(2025, 1, 1),
        ),
        DirectoryPath(
          path: '/home/user/documents',
          lastAccessed: DateTime(2025, 1, 2),
        ),
      ];

      when(mockRepository.getRecentDirectories())
          .thenAnswer((_) async => directories);

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(directories));
      verify(mockRepository.getRecentDirectories()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no recent directories', () async {
      // Arrange
      when(mockRepository.getRecentDirectories())
          .thenAnswer((_) async => []);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isEmpty);
      verify(mockRepository.getRecentDirectories()).called(1);
    });
  });
}
