import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_menu_bar.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_state.dart';

/// App bar for library screen showing directory path
class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight / 2);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          Widget? centerWidget;
          if (state is LibraryLoaded) {
            centerWidget = InkWell(
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          state.config.directoryPath,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return AppMenuBar(centerWidget: centerWidget);
        },
      ),
      leadingWidth: double.infinity,
      elevation: 1,
    );
  }
}
