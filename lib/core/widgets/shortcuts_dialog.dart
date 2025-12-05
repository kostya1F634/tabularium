import 'package:flutter/material.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import 'dialog_shortcuts_wrapper.dart';

class ShortcutsDialog extends StatelessWidget {
  const ShortcutsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DialogShortcutsWrapper(
      onEnterKey: () => Navigator.of(context).pop(),
      dialog: AlertDialog(
        title: Text(l10n.keyboardShortcuts),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSection(context, 'General', [
                  _ShortcutItem(
                    'Ctrl+W',
                    'Toggle between library and welcome screen',
                  ),
                  _ShortcutItem('Ctrl+N', 'Create new shelf'),
                  _ShortcutItem('Ctrl+O', 'Open books (all or selected)'),
                  _ShortcutItem('Ctrl+S', 'Select all books'),
                  _ShortcutItem('Ctrl+D', 'Clear selection'),
                  _ShortcutItem(
                    'Ctrl+1...0',
                    'Quick shelf selection (first 10 shelves)',
                  ),
                  _ShortcutItem('Ctrl+E', 'Edit shelf / Book properties'),
                  _ShortcutItem('Ctrl+T', 'Toggle view mode (Grid/Cabinet)'),
                  _ShortcutItem(
                    'Ctrl+A',
                    'Add selected/focused/all books to shelf',
                  ),
                  _ShortcutItem('Ctrl+F', 'Focus on center visible book'),
                  _ShortcutItem('Ctrl+U', 'Jump to first shelf/book'),
                  _ShortcutItem('Ctrl+I', 'Jump to last shelf/book'),
                  _ShortcutItem('/ or .', 'Focus/unfocus search field'),
                  _ShortcutItem(
                    'Tab',
                    'Switch focus between shelves and books',
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, 'Navigation - Shelves', [
                  _ShortcutItem('J / ↓', 'Move down'),
                  _ShortcutItem('K / ↑', 'Move up'),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, 'Navigation - Books', [
                  _ShortcutItem('H / ←', 'Move left'),
                  _ShortcutItem('J / ↓', 'Move down'),
                  _ShortcutItem('K / ↑', 'Move up'),
                  _ShortcutItem('L / →', 'Move right'),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, 'Shelves', [
                  _ShortcutItem('Ctrl+J / Ctrl+↓', 'Move shelf down'),
                  _ShortcutItem('Ctrl+K / Ctrl+↑', 'Move shelf up'),
                  _ShortcutItem('Delete', 'Delete shelf'),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, 'Books', [
                  _ShortcutItem('Enter', 'Open focused book'),
                  _ShortcutItem('Space', 'Toggle selection of focused book'),
                  _ShortcutItem('Delete', 'Remove selected books from shelf'),
                ]),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<_ShortcutItem> shortcuts,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...shortcuts.map(
          (shortcut) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    shortcut.keys,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    shortcut.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ShortcutItem {
  final String keys;
  final String description;

  _ShortcutItem(this.keys, this.description);
}
