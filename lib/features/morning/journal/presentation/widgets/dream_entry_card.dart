import 'package:flutter/material.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:intl/intl.dart';

class DreamEntryCard extends StatelessWidget {
  const DreamEntryCard({super.key, required this.dreamEntry, required this.onTap, required this.onEdit, required this.onDelete});

  final DreamEntry dreamEntry;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mood = _getMoodFromString(dreamEntry.mood);
    final category = _getCategoryFromString(dreamEntry.category);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with date, mood, and actions
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
                  child: Row(
                    children: [
                      // Date and mood
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                _formatDate(dreamEntry.dreamDate ?? dreamEntry.createdAt),
                                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: _getMoodColor(mood, theme).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                '${mood.emoji} ${mood.displayName}',
                                style: theme.textTheme.bodySmall?.copyWith(color: _getMoodColor(mood, theme), fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action buttons
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              onEdit();
                              break;
                            case 'delete':
                              onDelete();
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(children: [const Icon(Icons.edit, size: 20), const SizedBox(width: 8), Text('Modifier')]),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 20, color: theme.colorScheme.error),
                                const SizedBox(width: 8),
                                Text('Supprimer', style: TextStyle(color: theme.colorScheme.error)),
                              ],
                            ),
                          ),
                        ],
                        child: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),

                // Content preview
                if (dreamEntry.content.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Text(
                      dreamEntry.content,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                // Bottom row with category, lucid indicator, and tags
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      // Category
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(6)),
                        child: Text('${category.emoji} ${category.displayName}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      ),

                      // Lucid indicator
                      if (dreamEntry.isLucid) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.purple.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            '✨ Lucide',
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.purple, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],

                      // Recurring indicator
                      if (dreamEntry.isRecurring) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            '🔄 Récurrent',
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.orange, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],

                      const Spacer(),

                      // Time indicator
                      Text(
                        _formatTime(dreamEntry.dreamDate ?? dreamEntry.createdAt),
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7)),
                      ),
                    ],
                  ),
                ),

                // Tags if any
                if (dreamEntry.tags.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: dreamEntry.tags
                          .take(3)
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(4)),
                              child: Text('#$tag', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSecondaryContainer, fontSize: 11)),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DreamMood _getMoodFromString(String? moodString) {
    if (moodString == null) return DreamMood.neutral;
    return DreamMood.values.firstWhere((mood) => mood.name == moodString, orElse: () => DreamMood.neutral);
  }

  DreamCategory _getCategoryFromString(String? categoryString) {
    if (categoryString == null) return DreamCategory.normal;
    return DreamCategory.values.firstWhere((category) => category.name == categoryString, orElse: () => DreamCategory.normal);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final cardDate = DateTime(date.year, date.month, date.day);

    if (cardDate == today) {
      return "Aujourd'hui";
    } else if (cardDate == yesterday) {
      return "Hier";
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE', 'fr_FR').format(date);
    } else {
      return DateFormat('dd MMM', 'fr_FR').format(date);
    }
  }

  String _formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  Color _getMoodColor(DreamMood mood, ThemeData theme) {
    switch (mood) {
      case DreamMood.happy:
        return Colors.green;
      case DreamMood.excited:
        return Colors.amber;
      case DreamMood.neutral:
        return theme.colorScheme.primary;
      case DreamMood.sad:
        return Colors.blue;
      case DreamMood.anxious:
        return Colors.orange;
      case DreamMood.confused:
        return Colors.brown;
      case DreamMood.scary:
        return Colors.red;
      case DreamMood.peaceful:
        return Colors.teal;
    }
  }
}
