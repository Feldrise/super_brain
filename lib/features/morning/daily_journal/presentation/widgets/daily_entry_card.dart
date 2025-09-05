import 'package:flutter/material.dart';
import 'package:super_brain/features/morning/daily_journal/domain/entities/daily_entry.dart';

class DailyEntryCard extends StatelessWidget {
  const DailyEntryCard({super.key, required this.dailyEntry, required this.onTap, required this.onEdit, required this.onDelete});

  final DailyEntry dailyEntry;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mood = _getMoodFromString(dailyEntry.mood);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with date and mood
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(dailyEntry.entryDate),
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  if (mood != null) ...[
                    Text(mood.emoji),
                    const SizedBox(width: 4),
                    Text(mood.label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
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
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(children: [Icon(Icons.edit), SizedBox(width: 8), Text('Modifier')]),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Supprimer', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Content preview
              Text(dailyEntry.content, style: theme.textTheme.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis),

              // Gratitude and goals indicators
              if (dailyEntry.gratitudeList.isNotEmpty || dailyEntry.goalsForToday.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (dailyEntry.gratitudeList.isNotEmpty) ...[
                      Icon(Icons.favorite, size: 16, color: Colors.pink),
                      const SizedBox(width: 4),
                      Text(
                        '${dailyEntry.gratitudeList.length} gratitude${dailyEntry.gratitudeList.length > 1 ? 's' : ''}',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.pink),
                      ),
                    ],
                    if (dailyEntry.gratitudeList.isNotEmpty && dailyEntry.goalsForToday.isNotEmpty) const SizedBox(width: 16),
                    if (dailyEntry.goalsForToday.isNotEmpty) ...[
                      Icon(Icons.track_changes, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        '${dailyEntry.goalsForToday.length} objectif${dailyEntry.goalsForToday.length > 1 ? 's' : ''}',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.orange),
                      ),
                    ],
                  ],
                ),
              ],

              // Reflection indicator
              if (dailyEntry.reflection != null && dailyEntry.reflection!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.psychology, size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 4),
                    Text('Contient une réflexion', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary)),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final entryDate = DateTime(date.year, date.month, date.day);

    if (entryDate == today) {
      return 'Aujourd\'hui';
    } else if (entryDate == yesterday) {
      return 'Hier';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  DailyMood? _getMoodFromString(String? moodString) {
    if (moodString == null) return null;
    try {
      return DailyMood.values.firstWhere((mood) => mood.name == moodString);
    } catch (e) {
      return null;
    }
  }
}
