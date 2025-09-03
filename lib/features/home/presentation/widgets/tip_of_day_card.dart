import 'package:flutter/material.dart';

class TipOfDayCard extends StatelessWidget {
  const TipOfDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Conseil du jour',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Saviez-vous que faire une pause toutes les 25 minutes améliore la concentration et la mémorisation ? C\'est la technique Pomodoro !',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // TODO: Navigate to tips section
                },
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('Voir plus'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
