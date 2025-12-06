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
                _buildSection(context, l10n.shortcutsGeneral, [
                  _ShortcutItem('Ctrl+W', l10n.shortcutToggleScreen),
                  _ShortcutItem('Ctrl+N', l10n.shortcutCreateShelf),
                  _ShortcutItem('Ctrl+O', l10n.shortcutOpenBooks),
                  _ShortcutItem('Ctrl+S', l10n.shortcutSelectAll),
                  _ShortcutItem('Ctrl+D', l10n.shortcutClearSelection),
                  _ShortcutItem('Ctrl+1...0', l10n.shortcutQuickShelf),
                  _ShortcutItem('Ctrl+E', l10n.shortcutEdit),
                  _ShortcutItem('Ctrl+T', l10n.shortcutToggleView),
                  _ShortcutItem('Ctrl+A', l10n.shortcutAddToShelf),
                  _ShortcutItem('Ctrl+F', l10n.shortcutFocusCenter),
                  _ShortcutItem('Ctrl+U', l10n.shortcutJumpFirst),
                  _ShortcutItem('Ctrl+I', l10n.shortcutJumpLast),
                  _ShortcutItem('/ or .', l10n.shortcutFocusSearch),
                  _ShortcutItem('Tab', l10n.shortcutSwitchFocus),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, l10n.shortcutsNavigationShelves, [
                  _ShortcutItem('J / ↓', l10n.shortcutMoveDown),
                  _ShortcutItem('K / ↑', l10n.shortcutMoveUp),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, l10n.shortcutsNavigationBooks, [
                  _ShortcutItem('H / ←', l10n.shortcutMoveLeft),
                  _ShortcutItem('J / ↓', l10n.shortcutMoveDown),
                  _ShortcutItem('K / ↑', l10n.shortcutMoveUp),
                  _ShortcutItem('L / →', l10n.shortcutMoveRight),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, l10n.shortcutsShelves, [
                  _ShortcutItem('Ctrl+J / Ctrl+↓', l10n.shortcutMoveShelfDown),
                  _ShortcutItem('Ctrl+K / Ctrl+↑', l10n.shortcutMoveShelfUp),
                  _ShortcutItem('Delete', l10n.shortcutDeleteShelf),
                ]),
                const SizedBox(height: 16),
                _buildSection(context, l10n.shortcutsBooks, [
                  _ShortcutItem('Enter', l10n.shortcutOpenFocused),
                  _ShortcutItem('Space', l10n.shortcutToggleSelection),
                  _ShortcutItem('Delete', l10n.shortcutRemoveFromShelf),
                ]),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.ok),
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
