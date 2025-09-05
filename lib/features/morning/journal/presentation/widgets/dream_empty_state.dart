import 'package:flutter/material.dart';

class DreamEmptyState extends StatelessWidget {
  const DreamEmptyState({super.key, required this.onCreateFirst, this.hasSearchQuery = false, this.searchQuery = ''});

  final VoidCallback onCreateFirst;
  final bool hasSearchQuery;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (hasSearchQuery) {
      return _SearchEmptyState(
        searchQuery: searchQuery,
        onClearSearch: () {
          // This would be handled by the parent widget
        },
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [theme.colorScheme.primaryContainer.withValues(alpha: 0.3), theme.colorScheme.secondaryContainer.withValues(alpha: 0.3)],
                ),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(Icons.bedtime, size: 60, color: theme.colorScheme.primary.withValues(alpha: 0.7)),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              'Commencez votre journal de rêves',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              'Capturez vos rêves et découvrez les patterns de votre subconscient. '
              'Plus vous enregistrez, plus vous développez votre mémoire onirique.',
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Action button
            FilledButton.icon(
              onPressed: onCreateFirst,
              icon: const Icon(Icons.add),
              label: const Text('Enregistrer mon premier rêve'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
            ),

            const SizedBox(height: 24),

            // Tips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Conseils pour se souvenir de ses rêves',
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._buildTips(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTips(ThemeData theme) {
    final tips = ['Gardez un carnet près de votre lit', 'Notez immédiatement au réveil', 'Concentrez-vous sur les émotions ressenties', 'Même des fragments sont précieux'];

    return tips
        .map(
          (tip) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 6, right: 12),
                  decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(3)),
                ),
                Expanded(
                  child: Text(tip, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}

class _SearchEmptyState extends StatelessWidget {
  const _SearchEmptyState({required this.searchQuery, required this.onClearSearch});

  final String searchQuery;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Search icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(40)),
              child: Icon(Icons.search_off, size: 40, color: theme.colorScheme.onSurfaceVariant),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              'Aucun rêve trouvé',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              'Aucun rêve ne correspond à votre recherche "$searchQuery".\n'
              'Essayez avec d\'autres mots-clés ou effacez les filtres.',
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [OutlinedButton(onPressed: onClearSearch, child: const Text('Effacer la recherche'))],
            ),
          ],
        ),
      ),
    );
  }
}
