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
  });
}
