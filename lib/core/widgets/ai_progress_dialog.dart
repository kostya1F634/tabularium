import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../features/library/presentation/bloc/library_bloc.dart';
import '../../features/library/presentation/bloc/library_state.dart';

/// Dialog showing AI processing progress with BLoC integration
class AIProgressDialog extends StatelessWidget {
  const AIProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is! LibraryAIProcessing) {
          // Should not happen, but close dialog if state changed
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          });
          return const SizedBox.shrink();
        }

        final hasProgress =
            state.progress != null && state.total != null && state.total! > 0;

        return AlertDialog(
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(height: 24),
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                if (hasProgress) ...[
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: state.progress! / state.total!,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.progress} / ${state.total}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (state.currentItem != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.currentItem!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
