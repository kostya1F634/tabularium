import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../domain/entities/shelf.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

/// Header with search bar and action buttons
class LibraryHeader extends StatefulWidget {
  final Shelf selectedShelf;
  final int bookCount;
  final String? searchQuery;

  const LibraryHeader({
    super.key,
    required this.selectedShelf,
    required this.bookCount,
    this.searchQuery,
  });

  @override
  State<LibraryHeader> createState() => _LibraryHeaderState();
}

class _LibraryHeaderState extends State<LibraryHeader> {
  late final TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(LibraryHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery && widget.searchQuery != _searchController.text) {
      _searchController.text = widget.searchQuery ?? '';
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<LibraryBloc>().add(SearchBooks(query));
    });
  }

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
        final isAllShelf = widget.selectedShelf.id == 'all';

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
                if (!isAllShelf) ...[
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => context.read<LibraryBloc>().add(const DeleteSelectedBooks()),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: Text(l10n.deleteFromShelf),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ] else ...[
                // Normal mode actions
                ElevatedButton.icon(
                  onPressed: widget.bookCount > 0
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
                const Spacer(),
                // Search bar
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: l10n.searchBooks,
                      prefixIcon: const Icon(Icons.search, size: 20),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                context.read<LibraryBloc>().add(const ClearSearch());
                              },
                            )
                          : null,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      isDense: true,
                    ),
                    onChanged: _onSearchChanged,
                  ),
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
