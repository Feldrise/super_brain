import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/presentation/providers/summary_providers.dart';
import 'package:super_brain/features/reminder/presentation/pages/summary_detail_page.dart';

class SummariesSection extends ConsumerWidget {
  const SummariesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalSummariesAsync = ref.watch(globalSummariesProvider);

    return globalSummariesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _ErrorState(error: error.toString()),
      data: (globalSummaries) {
        if (globalSummaries.isEmpty) {
          return const _EmptyState(icon: Icons.summarize, title: 'Aucun résumé disponible', subtitle: 'Les résumés de cours seront ajoutés bientôt !');
        }

        return _SummariesList(summaries: globalSummaries);
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
          const SizedBox(height: 16),
          Text('Erreur', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.error)),
          const SizedBox(height: 8),
          Text(
            'Impossible de charger les résumés',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SummariesList extends StatelessWidget {
  const _SummariesList({required this.summaries});

  final List<Summary> summaries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: summaries.length + 1, // +1 for header
      itemBuilder: (context, index) {
        // Show header first
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(title: 'Résumés de cours', subtitle: '${summaries.length} résumé(s) disponible(s)', icon: Icons.library_books),
              const SizedBox(height: 8),
            ],
          );
        }

        final summaryIndex = index - 1;
        final summary = summaries[summaryIndex];

        return _SummaryCard(summary: summary, onTap: () => _openSummary(context, summary));
      },
    );
  }

  void _openSummary(BuildContext context, Summary summary) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SummaryDetailPage(summaryId: summary.id)));
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor = theme.colorScheme.primary;

    return Row(
      children: [
        Icon(icon, color: headerColor, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(color: headerColor, fontWeight: FontWeight.w600),
            ),
            Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary, required this.onTap});

  final Summary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(summary.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Key points preview
            if (summary.keyPoints.isNotEmpty)
              Text(
                summary.keyPoints.first,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

            const SizedBox(height: 8),

            // Reading time
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text('${summary.estimatedReadingTime} min de lecture', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
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
