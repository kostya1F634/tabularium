import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabularium/features/welcome/domain/repositories/directory_repository.dart';
import 'package:tabularium/features/welcome/domain/usecases/select_directory.dart';

import 'select_directory_test.mocks.dart';

@GenerateMocks([DirectoryRepository])
void main() {
  late SelectDirectory useCase;
  late MockDirectoryRepository mockRepository;

  setUp(() {
    mockRepository = MockDirectoryRepository();
    useCase = SelectDirectory(mockRepository);
  });

  group('SelectDirectory', () {
    test('should pick directory and add it to recent directories', () async {
      // Arrange
      const path = '/home/user/books';
      when(mockRepository.pickDirectory()).thenAnswer((_) async => path);
      when(mockRepository.addRecentDirectory(any)).thenAnswer((_) async => {});

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(path));
      verify(mockRepository.pickDirectory()).called(1);
      verify(mockRepository.addRecentDirectory(path)).called(1);
    });

    test(
      'should return null and not add to recent when user cancels',
      () async {
        // Arrange
        when(mockRepository.pickDirectory()).thenAnswer((_) async => null);

        // Act
        final result = await useCase();

        // Assert
        expect(result, isNull);
        verify(mockRepository.pickDirectory()).called(1);
        verifyNever(mockRepository.addRecentDirectory(any));
      },
    );
  });
}
