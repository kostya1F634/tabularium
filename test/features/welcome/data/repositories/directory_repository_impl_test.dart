import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabularium/core/services/app_settings.dart';
import 'package:tabularium/features/welcome/data/datasources/file_picker_datasource.dart';
import 'package:tabularium/features/welcome/data/repositories/directory_repository_impl.dart';

import 'directory_repository_impl_test.mocks.dart';

@GenerateMocks([AppSettings, FilePickerDataSource])
void main() {
  late DirectoryRepositoryImpl repository;
  late MockAppSettings mockPrefs;
  late MockFilePickerDataSource mockFilePicker;

  setUp(() {
    mockPrefs = MockAppSettings();
    mockFilePicker = MockFilePickerDataSource();
    repository = DirectoryRepositoryImpl(
      prefs: mockPrefs,
      filePicker: mockFilePicker,
    );
  });

  group('DirectoryRepositoryImpl', () {
    group('getRecentDirectories', () {
      test('should return empty list when no directories stored', () async {
        // Arrange
        when(mockPrefs.getStringList('recent_directories')).thenReturn(null);
        when(
          mockPrefs.getStringList('recent_directories_timestamps'),
        ).thenReturn(null);

        // Act
        final result = await repository.getRecentDirectories();

        // Assert
        expect(result, isEmpty);
      });

      test(
        'should return list of DirectoryPath when directories exist',
        () async {
          // Arrange
          final paths = ['/home/user/books', '/home/user/documents'];
          final timestamps = [
            DateTime(2025, 1, 1).toIso8601String(),
            DateTime(2025, 1, 2).toIso8601String(),
          ];

          when(mockPrefs.getStringList('recent_directories')).thenReturn(paths);
          when(
            mockPrefs.getStringList('recent_directories_timestamps'),
          ).thenReturn(timestamps);

          // Act
          final result = await repository.getRecentDirectories();

          // Assert
          expect(result.length, equals(2));
          expect(result[0].path, equals('/home/user/books'));
          expect(result[1].path, equals('/home/user/documents'));
        },
      );

      test('should handle missing timestamps gracefully', () async {
        // Arrange
        final paths = ['/home/user/books'];
        when(mockPrefs.getStringList('recent_directories')).thenReturn(paths);
        when(
          mockPrefs.getStringList('recent_directories_timestamps'),
        ).thenReturn(null);

        // Act
        final result = await repository.getRecentDirectories();

        // Assert
        expect(result.length, equals(1));
        expect(result[0].path, equals('/home/user/books'));
        expect(result[0].lastAccessed, isNotNull);
      });
    });

    group('addRecentDirectory', () {
      test('should add new directory to empty list', () async {
        // Arrange
        const path = '/home/user/books';
        when(mockPrefs.getStringList('recent_directories')).thenReturn(null);
        when(
          mockPrefs.getStringList('recent_directories_timestamps'),
        ).thenReturn(null);
        when(
          mockPrefs.setStringList('recent_directories', any),
        ).thenAnswer((_) async => true);
        when(
          mockPrefs.setStringList('recent_directories_timestamps', any),
        ).thenAnswer((_) async => true);

        // Act
        await repository.addRecentDirectory(path);

        // Assert
        verify(mockPrefs.setStringList('recent_directories', [path])).called(1);
        verify(
          mockPrefs.setStringList(
            'recent_directories_timestamps',
            argThat(hasLength(1)),
          ),
        ).called(1);
      });

      test('should add directory to beginning of existing list', () async {
        // Arrange
        const newPath = '/home/user/books';
        final existingPaths = ['/home/user/documents'];
        final existingTimestamps = [DateTime(2025, 1, 1).toIso8601String()];

        when(
          mockPrefs.getStringList('recent_directories'),
        ).thenReturn(existingPaths);
        when(
          mockPrefs.getStringList('recent_directories_timestamps'),
        ).thenReturn(existingTimestamps);
        when(
          mockPrefs.setStringList('recent_directories', any),
        ).thenAnswer((_) async => true);
        when(
          mockPrefs.setStringList('recent_directories_timestamps', any),
        ).thenAnswer((_) async => true);

        // Act
        await repository.addRecentDirectory(newPath);

        // Assert
        verify(
          mockPrefs.setStringList('recent_directories', [
            newPath,
            '/home/user/documents',
          ]),
        ).called(1);
      });

      test('should remove duplicate and add to beginning', () async {
        // Arrange
        const existingPath = '/home/user/books';
        final existingPaths = ['/home/user/documents', existingPath];
        final existingTimestamps = [
          DateTime(2025, 1, 1).toIso8601String(),
          DateTime(2025, 1, 2).toIso8601String(),
        ];

        when(
          mockPrefs.getStringList('recent_directories'),
        ).thenReturn(existingPaths);
        when(
          mockPrefs.getStringList('recent_directories_timestamps'),
        ).thenReturn(existingTimestamps);
        when(
          mockPrefs.setStringList('recent_directories', any),
        ).thenAnswer((_) async => true);
        when(
          mockPrefs.setStringList('recent_directories_timestamps', any),
        ).thenAnswer((_) async => true);

        // Act
        await repository.addRecentDirectory(existingPath);

        // Assert
        verify(
          mockPrefs.setStringList('recent_directories', [
            existingPath,
            '/home/user/documents',
          ]),
        ).called(1);
      });

      test('should limit list to max 10 items', () async {
        // Arrange
        const newPath = '/home/user/new';
        final existingPaths = List.generate(10, (i) => '/home/user/path$i');
        final existingTimestamps = List.generate(
          10,
          (i) => DateTime(2025, 1, i + 1).toIso8601String(),
        );

        when(
          mockPrefs.getStringList('recent_directories'),
        ).thenReturn(existingPaths);
        when(
          mockPrefs.getStringList('recent_directories_timestamps'),
        ).thenReturn(existingTimestamps);
        when(
          mockPrefs.setStringList('recent_directories', any),
        ).thenAnswer((_) async => true);
        when(
          mockPrefs.setStringList('recent_directories_timestamps', any),
        ).thenAnswer((_) async => true);

        // Act
        await repository.addRecentDirectory(newPath);

        // Assert
        final captured = verify(
          mockPrefs.setStringList('recent_directories', captureAny),
        ).captured;
        expect((captured[0] as List).length, equals(10));
        expect((captured[0] as List).first, equals(newPath));
      });
    });

    group('clearRecentDirectories', () {
      test('should remove both keys from preferences', () async {
        // Arrange
        when(
          mockPrefs.remove('recent_directories'),
        ).thenAnswer((_) async => true);
        when(
          mockPrefs.remove('recent_directories_timestamps'),
        ).thenAnswer((_) async => true);

        // Act
        await repository.clearRecentDirectories();

        // Assert
        verify(mockPrefs.remove('recent_directories')).called(1);
        verify(mockPrefs.remove('recent_directories_timestamps')).called(1);
      });
    });
  });
}
