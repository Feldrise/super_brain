import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/tip_providers.dart';
import '../pages/tip_detail_page.dart';

class TipOfDayCard extends ConsumerWidget {
  const TipOfDayCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dailyTipAsync = ref.watch(dailyTipProvider);

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
            dailyTipAsync.when(
              data: (tip) => tip != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tip.title,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tip.content,
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : Text('Aucun conseil disponible pour aujourd\'hui.', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4)),
              loading: () => const SizedBox(height: 60, child: Center(child: CircularProgressIndicator())),
              error: (error, stack) => Text('Erreur lors du chargement du conseil.', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dailyTipAsync.when(
                  data: (tip) => tip != null
                      ? TextButton.icon(onPressed: () => _navigateToTipDetail(context, tip), icon: const Icon(Icons.visibility, size: 16), label: const Text('Lire'))
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (error, stack) => const SizedBox.shrink(),
                ),
                TextButton.icon(onPressed: () => _navigateToTipsList(context), icon: const Icon(Icons.arrow_forward, size: 16), label: const Text('Voir plus')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTipDetail(BuildContext context, tip) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TipDetailPage(tip: tip)));
  }

  void _navigateToTipsList(BuildContext context) {
    context.push('/tips');
  }
}
