import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../di/library_dependencies.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import '../widgets/library_app_bar.dart';
import '../widgets/shelves_sidebar.dart';
import '../widgets/books_grid.dart';
import '../widgets/library_header.dart';

/// Main library screen with sidebar and books grid
class LibraryScreen extends StatelessWidget {
  final String directoryPath;

  const LibraryScreen({
    super.key,
    required this.directoryPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LibraryDependencies().createLibraryBloc()
        ..add(InitializeLibrary(directoryPath)),
      child: const _LibraryScreenContent(),
    );
  }
}

class _LibraryScreenContent extends StatelessWidget {
  const _LibraryScreenContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const LibraryAppBar(),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    l10n.initializingLibrary,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          if (state is LibraryInitializing) {
            final progress = state.currentBook / state.totalBooks;
            return Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.initializingLibrary,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 32),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${state.currentBook} / ${state.totalBooks}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is LibraryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
                    child: Text(l10n.backToWelcome),
                  ),
                ],
              ),
            );
          }

          if (state is LibraryLoaded) {
            return Row(
              children: [
                // Left sidebar with shelves
                SizedBox(
                  width: 250,
                  child: ShelfsSidebar(
                    shelves: state.config.shelves,
                    selectedShelfId: state.selectedShelf.id,
                    totalBooksCount: state.config.books.length,
                  ),
                ),
                // Vertical divider
                const VerticalDivider(width: 1),
                // Main content area
                Expanded(
                  child: Column(
                    children: [
                      // Header with search and open all button
                      LibraryHeader(
                        selectedShelf: state.selectedShelf,
                        bookCount: state.displayedBooks.length,
                        searchQuery: state.searchQuery,
                      ),
                      const Divider(height: 1),
                      // Books grid
                      Expanded(
                        child: BooksGrid(
                          books: state.displayedBooks,
                          shelves: state.config.shelves,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
