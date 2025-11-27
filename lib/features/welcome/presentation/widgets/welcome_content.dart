import 'package:flutter/material.dart';
import 'package:tabularium/l10n/app_localizations.dart';
import '../../domain/entities/directory_path.dart';

class WelcomeContent extends StatelessWidget {
  final List<DirectoryPath> recentDirectories;
  final VoidCallback onPickDirectory;
  final Function(String) onSelectDirectory;

  const WelcomeContent({
    super.key,
    required this.recentDirectories,
    required this.onPickDirectory,
    required this.onSelectDirectory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Application icon
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.book_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        const SizedBox(height: 32),

        // Application name
        Text(
          AppLocalizations.of(context)!.appTitle,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          AppLocalizations.of(context)!.appSubtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),

        const SizedBox(height: 48),

        // Directory selection button
        ElevatedButton.icon(
          onPressed: onPickDirectory,
          icon: const Icon(Icons.folder_open, size: 24),
          label: Text(AppLocalizations.of(context)!.selectBooksDirectory),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 20,
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
          ),
        ),

        const SizedBox(height: 48),

        // Recent directories list
        if (recentDirectories.isNotEmpty) ...[
          Text(
            AppLocalizations.of(context)!.recentDirectories,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentDirectories.length,
              itemBuilder: (context, index) {
                final dir = recentDirectories[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        Icons.folder,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      dir.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      dir.path,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                    ),
                    onTap: () => onSelectDirectory(dir.path),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
