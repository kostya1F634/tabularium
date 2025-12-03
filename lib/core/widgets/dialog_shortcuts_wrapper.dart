import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Wraps an AlertDialog to add standard keyboard shortcuts:
/// - ESC: Close dialog (cancel)
/// - ENTER: Trigger primary action (if provided)
class DialogShortcutsWrapper extends StatelessWidget {
  final Widget dialog;
  final VoidCallback? onEnterKey;

  const DialogShortcutsWrapper({
    super.key,
    required this.dialog,
    this.onEnterKey,
  });

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () {
          Navigator.of(context).pop();
        },
        if (onEnterKey != null)
          const SingleActivator(LogicalKeyboardKey.enter): onEnterKey!,
      },
      child: Focus(autofocus: true, child: dialog),
    );
  }
}
