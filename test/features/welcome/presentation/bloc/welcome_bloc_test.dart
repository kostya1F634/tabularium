import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabularium/features/welcome/domain/entities/directory_path.dart';
import 'package:tabularium/features/welcome/domain/repositories/directory_repository.dart';
import 'package:tabularium/features/welcome/domain/usecases/get_recent_directories.dart';
import 'package:tabularium/features/welcome/domain/usecases/select_directory.dart';
import 'package:tabularium/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:tabularium/features/welcome/presentation/bloc/welcome_event.dart';
import 'package:tabularium/features/welcome/presentation/bloc/welcome_state.dart';

import 'welcome_bloc_test.mocks.dart';

@GenerateMocks([GetRecentDirectories, SelectDirectory, DirectoryRepository])
void main() {
  late WelcomeBloc bloc;
  late MockGetRecentDirectories mockGetRecentDirectories;
  late MockSelectDirectory mockSelectDirectory;
  late MockDirectoryRepository mockRepository;

  setUp(() {
    mockGetRecentDirectories = MockGetRecentDirectories();
    mockSelectDirectory = MockSelectDirectory();
    mockRepository = MockDirectoryRepository();
    bloc = WelcomeBloc(
      getRecentDirectories: mockGetRecentDirectories,
      selectDirectory: mockSelectDirectory,
      repository: mockRepository,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('WelcomeBloc', () {
    test('initial state should be WelcomeInitial', () {
      expect(bloc.state, equals(const WelcomeInitial()));
    });

    blocTest<WelcomeBloc, WelcomeState>(
      'emits [WelcomeLoading, WelcomeLoaded] when LoadRecentDirectories is added and succeeds',
      build: () {
        final directories = [
          DirectoryPath(
            path: '/home/user/books',
            lastAccessed: DateTime(2025, 1, 1),
          ),
        ];
        when(
          mockGetRecentDirectories.call(),
        ).thenAnswer((_) async => directories);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadRecentDirectories()),
      expect: () => [
        const WelcomeLoading(),
        WelcomeLoaded([
          DirectoryPath(
            path: '/home/user/books',
            lastAccessed: DateTime(2025, 1, 1),
          ),
        ]),
      ],
      verify: (_) {
        verify(mockGetRecentDirectories.call()).called(1);
      },
    );

    blocTest<WelcomeBloc, WelcomeState>(
      'emits [WelcomeLoading, WelcomeError] when LoadRecentDirectories fails',
      build: () {
        when(
          mockGetRecentDirectories.call(),
        ).thenThrow(Exception('Failed to load'));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadRecentDirectories()),
      expect: () => [
        const WelcomeLoading(),
        const WelcomeError('Exception: Failed to load'),
      ],
    );

    blocTest<WelcomeBloc, WelcomeState>(
      'emits [DirectoryPicking, DirectorySelected] when PickDirectory is added and user selects a directory',
      build: () {
        when(
          mockSelectDirectory.call(),
        ).thenAnswer((_) async => '/home/user/books');
        return bloc;
      },
      act: (bloc) => bloc.add(const PickDirectory()),
      expect: () => [
        const DirectoryPicking(),
        const DirectorySelected('/home/user/books'),
      ],
      verify: (_) {
        verify(mockSelectDirectory.call()).called(1);
      },
    );

    blocTest<WelcomeBloc, WelcomeState>(
      'emits [DirectoryPicking, WelcomeLoaded] when PickDirectory is added but user cancels',
      build: () {
        when(mockSelectDirectory.call()).thenAnswer((_) async => null);
        when(mockGetRecentDirectories.call()).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(const PickDirectory()),
      expect: () => [const DirectoryPicking(), const WelcomeLoaded([])],
      verify: (_) {
        verify(mockSelectDirectory.call()).called(1);
        verify(mockGetRecentDirectories.call()).called(1);
      },
    );

    blocTest<WelcomeBloc, WelcomeState>(
      'emits [DirectorySelected] when SelectRecentDirectory is added',
      build: () => bloc,
      act: (bloc) => bloc.add(const SelectRecentDirectory('/home/user/books')),
      expect: () => [const DirectorySelected('/home/user/books')],
    );
  });
}
