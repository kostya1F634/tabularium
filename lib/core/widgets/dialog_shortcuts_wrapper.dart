import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Wraps an AlertDialog to add standard keyboard shortcuts:
/// - ESC: Close dialog (cancel)
/// - ENTER: Trigger primary action (if provided)
class DialogShortcutsWrapper extends StatefulWidget {
  final Widget dialog;
  final VoidCallback? onEnterKey;

  const DialogShortcutsWrapper({
    super.key,
    required this.dialog,
    this.onEnterKey,
  });

  @override
  State<DialogShortcutsWrapper> createState() => _DialogShortcutsWrapperState();
}

class _DialogShortcutsWrapperState extends State<DialogShortcutsWrapper> {
  @override
  Widget build(BuildContext context) {
    return Focus(
      // Don't request focus - let child widgets (like TextField with autofocus) get it
      autofocus: false,
      // Use onKeyEvent to catch keys from any focused child
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.enter &&
              widget.onEnterKey != null) {
            widget.onEnterKey!();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: widget.dialog,
    );
  }
}
