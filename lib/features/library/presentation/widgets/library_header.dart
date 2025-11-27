import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

/// Header with action buttons
class LibraryHeader extends StatelessWidget {
  final Shelf selectedShelf;
  final int bookCount;
  final bool isFocused;

  const LibraryHeader({
    super.key,
    required this.selectedShelf,
    required this.bookCount,
    this.isFocused = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is! LibraryLoaded) {
          return const SizedBox.shrink();
        }

        final hasSelection = state.hasSelection;
        final selectedCount = state.selectedBookIds.length;
        final isAllShelf = selectedShelf.id == 'all';
        final isUnsortedShelf = selectedShelf.id == 'unsorted';
        final isDefaultShelf = isAllShelf || isUnsortedShelf;

        return Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 40, // Fixed height to prevent jittering
            child: Row(
              children: [
                if (hasSelection) ...[
                // Selection mode actions
                Text(
                  '$selectedCount ${l10n.selected}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => context.read<LibraryBloc>().add(const OpenAllBooks()),
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: Text(l10n.openSelected),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => context.read<LibraryBloc>().add(const SelectAllBooks()),
                  icon: const Icon(Icons.select_all, size: 18),
                  label: Text(l10n.selectAll),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => context.read<LibraryBloc>().add(const ClearBookSelection()),
                  icon: const Icon(Icons.deselect, size: 18),
                  label: Text(l10n.clearSelection),
                ),
                if (!isDefaultShelf) ...[
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => context.read<LibraryBloc>().add(const DeleteSelectedBooks()),
                    icon: const Icon(Icons.remove_circle_outline, size: 18),
                    label: Text(l10n.removeFromShelf),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ] else ...[
                // Normal mode actions
                ElevatedButton.icon(
                  onPressed: bookCount > 0
                      ? () => context.read<LibraryBloc>().add(const OpenAllBooks())
                      : null,
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: Text(l10n.openAllBooks),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () => context.read<LibraryBloc>().add(const ScanForNewBooks()),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(l10n.scanForNewBooks),
                ),
              ],
            ],
          ),
          ),
        );
      },
    );
  }
}
