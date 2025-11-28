import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabularium/core/services/app_settings.dart';
import 'package:tabularium/core/services/view_mode_service.dart';
import 'package:tabularium/features/library/presentation/pages/library_view_wrapper.dart';

import 'view_mode_service_test.mocks.dart';

@GenerateMocks([AppSettings])
void main() {
  late ViewModeService service;
  late MockAppSettings mockSettings;

  setUp(() {
    mockSettings = MockAppSettings();
    service = ViewModeService(mockSettings);
  });

  group('ViewModeService', () {
    group('getViewMode', () {
      test('should return grid mode when no mode is stored', () {
        // Arrange
        when(mockSettings.getString('view_mode')).thenReturn(null);

        // Act
        final result = service.getViewMode();

        // Assert
        expect(result, equals(LibraryViewMode.grid));
      });

      test('should return cabinet mode when cabinet is stored', () {
        // Arrange
        when(mockSettings.getString('view_mode')).thenReturn('cabinet');

        // Act
        final result = service.getViewMode();

        // Assert
        expect(result, equals(LibraryViewMode.cabinet));
      });

      test('should return grid mode when grid is stored', () {
        // Arrange
        when(mockSettings.getString('view_mode')).thenReturn('grid');

        // Act
        final result = service.getViewMode();

        // Assert
        expect(result, equals(LibraryViewMode.grid));
      });

      test('should return grid mode for unknown stored value', () {
        // Arrange
        when(mockSettings.getString('view_mode')).thenReturn('unknown');

        // Act
        final result = service.getViewMode();

        // Assert
        expect(result, equals(LibraryViewMode.grid));
      });
    });

    group('setViewMode', () {
      test('should save grid mode as "grid"', () async {
        // Arrange
        when(mockSettings.setString(any, any)).thenAnswer((_) async => true);

        // Act
        await service.setViewMode(LibraryViewMode.grid);

        // Assert
        verify(mockSettings.setString('view_mode', 'grid')).called(1);
      });

      test('should save cabinet mode as "cabinet"', () async {
        // Arrange
        when(mockSettings.setString(any, any)).thenAnswer((_) async => true);

        // Act
        await service.setViewMode(LibraryViewMode.cabinet);

        // Assert
        verify(mockSettings.setString('view_mode', 'cabinet')).called(1);
      });
    });

    group('resetViewMode', () {
      test('should remove view mode from settings', () async {
        // Arrange
        when(mockSettings.remove(any)).thenAnswer((_) async => true);

        // Act
        await service.resetViewMode();

        // Assert
        verify(mockSettings.remove('view_mode')).called(1);
      });
    });
  });
}
