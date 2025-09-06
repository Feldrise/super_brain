import 'package:flutter/material.dart';

class UnsavedChangesDialog extends StatelessWidget {
  const UnsavedChangesDialog({
    super.key,
    required this.title,
    required this.content,
    this.discardText = 'Abandonner',
    this.saveText = 'Sauvegarder',
    this.cancelText = 'Annuler',
    this.onDiscard,
    this.onSave,
  });

  final String title;
  final String content;
  final String discardText;
  final String saveText;
  final String cancelText;
  final VoidCallback? onDiscard;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning_outlined, color: theme.colorScheme.warning, size: 24),
          const SizedBox(width: 8),
          Flexible(child: Text(title)),
        ],
      ),
      content: Text(content),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(cancelText)),
        if (onSave != null)
          FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).pop(true);
              onSave!();
            },
            child: Text(saveText),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onDiscard?.call();
          },
          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
          child: Text(discardText),
        ),
      ],
    );
  }

  /// Shows a confirmation dialog for unsaved changes
  /// Returns true if the user confirms to leave, false otherwise
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String content,
    String discardText = 'Abandonner',
    String saveText = 'Sauvegarder',
    String cancelText = 'Annuler',
    VoidCallback? onDiscard,
    VoidCallback? onSave,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          UnsavedChangesDialog(title: title, content: content, discardText: discardText, saveText: saveText, cancelText: cancelText, onDiscard: onDiscard, onSave: onSave),
    );

    return result ?? false;
  }
}

extension ThemeDataExtension on ColorScheme {
  Color get warning => const Color(0xFFFF9800);
}
