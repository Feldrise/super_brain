import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/presentation/providers/dream_journal_providers.dart';

class DreamStatsHeader extends ConsumerWidget {
  const DreamStatsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dreamEntriesAsync = ref.watch(dreamEntriesProvider);

    return dreamEntriesAsync.when(data: (entries) => _buildStatsContent(context, entries), loading: () => const SizedBox.shrink(), error: (_, __) => const SizedBox.shrink());
  }

  Widget _buildStatsContent(BuildContext context, List<DreamEntry> entries) {
    final theme = Theme.of(context);
    final totalDreams = entries.length;
    final lucidDreams = entries.where((e) => e.isLucid).length;
    final thisMonthDreams = entries.where((e) {
      final now = DateTime.now();
      final entryDate = e.dreamDate ?? e.createdAt;
      return entryDate.year == now.year && entryDate.month == now.month;
    }).length;

    final recentMoods = entries.take(10).where((e) => e.mood != null).map((e) => e.mood!).toList();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [theme.colorScheme.primaryContainer, theme.colorScheme.secondaryContainer]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: theme.colorScheme.shadow.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics_outlined, color: theme.colorScheme.onPrimaryContainer, size: 24),
              const SizedBox(width: 8),
              Text(
                'Statistiques de vos rêves',
                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(icon: Icons.bedtime_outlined, label: 'Total', value: totalDreams.toString(), color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(icon: Icons.auto_awesome, label: 'Lucides', value: lucidDreams.toString(), color: Colors.amber),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(icon: Icons.calendar_month, label: 'Ce mois', value: thisMonthDreams.toString(), color: Colors.green),
              ),
            ],
          ),
          if (recentMoods.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Humeurs récentes',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: recentMoods.take(5).map((mood) {
                final dreamMood = DreamMood.values.firstWhere((m) => m.name == mood, orElse: () => DreamMood.neutral);
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: theme.colorScheme.surface.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(16)),
                  child: Text(dreamMood.emoji, style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: theme.colorScheme.surface.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
