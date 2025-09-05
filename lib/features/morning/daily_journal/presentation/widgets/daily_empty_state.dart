import 'package:flutter/material.dart';

class DailyEmptyState extends StatelessWidget {
  const DailyEmptyState({super.key, required this.onCreateFirst, this.hasSearchQuery = false, this.searchQuery = ''});

  final VoidCallback onCreateFirst;
  final bool hasSearchQuery;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (hasSearchQuery) {
      return _buildSearchEmptyState(context, theme);
    }

    return _buildMainEmptyState(context, theme);
  }

  Widget _buildMainEmptyState(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.edit_note_outlined, size: 120, color: theme.colorScheme.outline.withValues(alpha: 0.5)),
          const SizedBox(height: 24),
          Text(
            'Votre journal vous attend',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Commencez votre routine matinale en écrivant votre première entrée de journal. Notez vos pensées, vos gratitudes et vos objectifs pour la journée.',
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: onCreateFirst,
            icon: const Icon(Icons.add),
            label: const Text('Créer ma première entrée'),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          ),
          const SizedBox(height: 24),
          _buildBenefitsCard(theme),
        ],
      ),
    );
  }

  Widget _buildSearchEmptyState(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text('Aucun résultat', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(
            'Aucune entrée ne correspond à "$searchQuery"',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton(onPressed: onCreateFirst, child: const Text('Créer une nouvelle entrée')),
        ],
      ),
    );
  }

  Widget _buildBenefitsCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tips_and_updates, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Pourquoi tenir un journal ?', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            _buildBenefitItem('🧠 Clarté mentale', 'Organisez vos pensées et émotions', theme),
            const SizedBox(height: 8),
            _buildBenefitItem('🙏 Gratitude', 'Cultivez une attitude positive', theme),
            const SizedBox(height: 8),
            _buildBenefitItem('🎯 Objectifs', 'Définissez et suivez vos intentions', theme),
            const SizedBox(height: 8),
            _buildBenefitItem('📈 Croissance', 'Suivez votre évolution personnelle', theme),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String title, String description, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.split(' ')[0], // Emoji
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.substring(2), // Title without emoji
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(description, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}
