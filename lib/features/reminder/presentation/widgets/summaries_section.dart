import 'package:flutter/material.dart';

class SummariesSection extends StatelessWidget {
  const SummariesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final summaries = [
      {
        'title': 'Les lois de Newton',
        'tags': ['Physique', 'Mécanique'],
        'nextReview': 'Dans 1 heure',
      },
      {
        'title': 'Introduction à la psychologie cognitive',
        'tags': ['Psychologie', 'Cognition'],
        'nextReview': 'Dans 2 jours',
      },
      {
        'title': 'Histoire de la Révolution française',
        'tags': ['Histoire', 'France'],
        'nextReview': 'Dans 1 semaine',
      },
    ];

    if (summaries.isEmpty) {
      return const _EmptyState(icon: Icons.summarize, title: 'Aucun résumé à réviser', subtitle: 'Créez vos premiers résumés de cours !');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: summaries.length,
      itemBuilder: (context, index) {
        final summary = summaries[index];
        return _SummaryCard(
          title: summary['title']! as String,
          tags: summary['tags']! as List<String>,
          nextReview: summary['nextReview']! as String,
          onTap: () {
            // TODO: Open summary for review
          },
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.tags, required this.nextReview, required this.onTap});

  final String title;
  final List<String> tags;
  final String nextReview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Wrap(spacing: 6, runSpacing: 4, children: tags.map((tag) => _TagChip(tag)).toList()),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  nextReview,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurfaceVariant),
        onTap: onTap,
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: theme.colorScheme.secondaryContainer.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSecondaryContainer, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(title, style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
