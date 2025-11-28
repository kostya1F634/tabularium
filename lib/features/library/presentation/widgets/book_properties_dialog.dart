import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';

import '../../domain/entities/book.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';

/// Dialog for displaying and editing book properties
class BookPropertiesDialog extends StatefulWidget {
  final Book book;

  const BookPropertiesDialog({super.key, required this.book});

  @override
  State<BookPropertiesDialog> createState() => _BookPropertiesDialogState();
}

class _BookPropertiesDialogState extends State<BookPropertiesDialog> {
  late final TextEditingController _aliasController;

  @override
  void initState() {
    super.initState();
    _aliasController = TextEditingController(text: widget.book.alias);
  }

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  String get _fileSize {
    final megabytes = (widget.book.fileSize / (1024 * 1024)).toStringAsFixed(2);
    return '$megabytes MB';
  }

  void _saveAlias() {
    final newAlias = _aliasController.text.trim();
    if (newAlias != widget.book.alias) {
      context.read<LibraryBloc>().add(
        UpdateBookAlias(
          bookId: widget.book.id,
          alias: newAlias.isEmpty ? null : newAlias,
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(l10n.bookProperties, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 24),

              // Content
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail
                    if (widget.book.thumbnailPath != null)
                      Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(widget.book.thumbnailPath!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: theme.colorScheme.surfaceVariant,
                        ),
                        child: Icon(
                          Icons.picture_as_pdf,
                          size: 48,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    const SizedBox(width: 24),

                    // Properties
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Alias (editable)
                            Text(
                              l10n.alias,
                              style: theme.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 4),
                            TextField(
                              controller: _aliasController,
                              decoration: InputDecoration(
                                hintText: widget.book.fileName,
                                border: const OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // File path (read-only)
                            Text(
                              l10n.filePath,
                              style: theme.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 4),
                            SelectableText(
                              widget.book.filePath,
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),

                            // Author (read-only)
                            if (widget.book.author != null) ...[
                              Text(
                                l10n.author,
                                style: theme.textTheme.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.book.author!,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Title (read-only)
                            if (widget.book.title != null) ...[
                              Text(
                                l10n.title,
                                style: theme.textTheme.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.book.title!,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Page count (read-only)
                            if (widget.book.pageCount > 0) ...[
                              Text(
                                l10n.pageCount,
                                style: theme.textTheme.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${widget.book.pageCount}',
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                            ],

                            // File size (read-only)
                            if (widget.book.fileSize > 0) ...[
                              Text(
                                l10n.fileSize,
                                style: theme.textTheme.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _fileSize,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _saveAlias, child: Text(l10n.save)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
