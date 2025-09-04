import 'package:flutter/material.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';

class TrainingStatsCard extends StatelessWidget {
  final TrainingStats stats;

  const TrainingStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top row - main stats
        Row(
          children: [
            Expanded(
              child: _StatItem(icon: Icons.local_fire_department, value: '${stats.currentStreak}', label: 'Jours de Suite', color: Colors.orange),
            ),
            Expanded(
              child: _StatItem(icon: Icons.fitness_center, value: '${stats.totalSessions}', label: 'Sessions', color: Colors.blue),
            ),
            Expanded(
              child: _StatItem(icon: Icons.timer, value: '${stats.totalMinutes}', label: 'Minutes', color: Colors.green),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Category breakdown
        if (stats.sessionsByCategory.isNotEmpty) ...[_CategoryBreakdown(sessionsByCategory: stats.sessionsByCategory), const SizedBox(height: 16)],

        // Achievements preview
        if (stats.achievements.isNotEmpty) ...[_AchievementsPreview(achievements: stats.achievements)],
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
      ],
    );
  }
}

class _CategoryBreakdown extends StatelessWidget {
  final Map<TrainingCategory, int> sessionsByCategory;

  const _CategoryBreakdown({required this.sessionsByCategory});

  @override
  Widget build(BuildContext context) {
    final totalSessions = sessionsByCategory.values.fold<int>(0, (sum, count) => sum + count);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Répartition de l\'Entraînement', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        ...sessionsByCategory.entries.map((entry) {
          final percentage = totalSessions > 0 ? (entry.value / totalSessions) : 0.0;
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: _CategoryProgressBar(category: entry.key, count: entry.value, percentage: percentage),
          );
        }),
      ],
    );
  }
}

class _CategoryProgressBar extends StatelessWidget {
  final TrainingCategory category;
  final int count;
  final double percentage;

  const _CategoryProgressBar({required this.category, required this.count, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(category);

    return Row(
      children: [
        SizedBox(width: 80, child: Text(_getCategoryName(category), style: Theme.of(context).textTheme.bodySmall)),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 20,
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: color),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(TrainingCategory category) {
    switch (category) {
      case TrainingCategory.cardio:
        return Colors.red;
      case TrainingCategory.strength:
        return Colors.blue;
      case TrainingCategory.yoga:
        return Colors.green;
    }
  }

  String _getCategoryName(TrainingCategory category) {
    switch (category) {
      case TrainingCategory.cardio:
        return 'Cardio';
      case TrainingCategory.strength:
        return 'Force';
      case TrainingCategory.yoga:
        return 'Yoga';
    }
  }
}

class _AchievementsPreview extends StatelessWidget {
  final List<TrainingAchievement> achievements;

  const _AchievementsPreview({required this.achievements});

  @override
  Widget build(BuildContext context) {
    final recentAchievements = achievements.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Récents Succès', style: Theme.of(context).textTheme.titleSmall),
            if (achievements.length > 3)
              TextButton(
                onPressed: () {
                  // Navigate to full achievements page
                },
                child: const Text('Voir Tout'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: recentAchievements.map((achievement) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.emoji_events, size: 16, color: Colors.amber[700]),
                  const SizedBox(width: 4),
                  Text(
                    achievement.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.amber[700], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
