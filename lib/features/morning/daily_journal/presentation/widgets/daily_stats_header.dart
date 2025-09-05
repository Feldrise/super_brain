import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/providers/daily_journal_providers.dart';

class DailyStatsHeader extends ConsumerWidget {
  const DailyStatsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final streakAsync = ref.watch(journalStreakProvider);
    final todaysEntryAsync = ref.watch(todaysDailyEntryProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Streak card
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.local_fire_department, color: theme.colorScheme.primary, size: 32),
                    const SizedBox(height: 8),
                    streakAsync.when(
                      data: (streak) => Text(
                        '$streak',
                        style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => const Text('-'),
                    ),
                    Text(
                      'Série de jours',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Today's status card
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    todaysEntryAsync.when(
                      data: (entry) => Icon(entry != null ? Icons.check_circle : Icons.edit_note, color: entry != null ? Colors.green : theme.colorScheme.outline, size: 32),
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => Icon(Icons.error, color: theme.colorScheme.error, size: 32),
                    ),
                    const SizedBox(height: 8),
                    todaysEntryAsync.when(
                      data: (entry) => Text(
                        entry != null ? 'Fait' : 'À faire',
                        style: theme.textTheme.titleMedium?.copyWith(color: entry != null ? Colors.green : theme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600),
                      ),
                      loading: () => const Text('...'),
                      error: (_, __) => const Text('Erreur'),
                    ),
                    Text(
                      'Aujourd\'hui',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
