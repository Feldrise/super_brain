import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/home/presentation/providers/home_stats_providers.dart';

class QuickStatsCard extends ConsumerWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final homeStatsAsync = ref.watch(homeStatsProvider);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vos progrès', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            homeStatsAsync.when(
              data: (stats) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(icon: Icons.local_fire_department, value: '${stats.streakCount}', label: 'Série', color: theme.colorScheme.primary),
                  _StatItem(icon: Icons.psychology_outlined, value: '${stats.wordsLearned}', label: 'Mots mémorisés', color: theme.colorScheme.secondary),
                  _StatItem(icon: Icons.book_outlined, value: '${stats.summariesCount}', label: 'Résumés', color: theme.colorScheme.tertiary),
                ],
              ),
              loading: () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(icon: Icons.local_fire_department, value: '...', label: 'Série', color: theme.colorScheme.primary),
                  _StatItem(icon: Icons.psychology_outlined, value: '...', label: 'Mots mémorisés', color: theme.colorScheme.secondary),
                  _StatItem(icon: Icons.book_outlined, value: '...', label: 'Résumés', color: theme.colorScheme.tertiary),
                ],
              ),
              error: (error, stackTrace) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(icon: Icons.local_fire_department, value: '0', label: 'Série', color: theme.colorScheme.primary),
                  _StatItem(icon: Icons.psychology_outlined, value: '0', label: 'Mots mémorisés', color: theme.colorScheme.secondary),
                  _StatItem(icon: Icons.book_outlined, value: '0', label: 'Résumés', color: theme.colorScheme.tertiary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.value, required this.label, required this.color});

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
