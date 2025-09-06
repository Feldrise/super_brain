import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/presentation/providers/summary_providers.dart';

class SummaryDetailPage extends ConsumerWidget {
  const SummaryDetailPage({super.key, required this.summaryId});

  final String summaryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(summaryByIdProvider(summaryId));

    return Scaffold(
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _ErrorView(error: error.toString()),
        data: (summary) {
          if (summary == null) {
            return const _NotFoundView();
          }
          return _SummaryDetailView(summary: summary);
        },
      ),
    );
  }
}

class _SummaryDetailView extends StatelessWidget {
  const _SummaryDetailView({required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _SummaryAppBar(summary: summary),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SummaryHeader(summary: summary),
                const SizedBox(height: 24),
                _SummaryContent(summary: summary),
                if (summary.keyPoints.isNotEmpty) ...[const SizedBox(height: 32), _KeyPointsSection(keyPoints: summary.keyPoints)],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryAppBar extends StatelessWidget {
  const _SummaryAppBar({required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          summary.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
          ),
        ),
        background: _DefaultBackground(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

class _DefaultBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [theme.colorScheme.primary.withOpacity(0.8), theme.colorScheme.primary.withOpacity(0.6)],
        ),
      ),
      child: const Center(child: Icon(Icons.summarize, size: 64, color: Colors.white70)),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reading time
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text('${summary.estimatedReadingTime} min de lecture', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}

class _SummaryContent extends StatelessWidget {
  const _SummaryContent({required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contenu', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        MarkdownBody(
          data: summary.content,
          styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
            p: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            h1: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            h2: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            h3: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _KeyPointsSection extends StatelessWidget {
  const _KeyPointsSection({required this.keyPoints});

  final List<String> keyPoints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Points clés', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        ...keyPoints.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                ),
                Expanded(child: Text(point, style: theme.textTheme.bodyMedium?.copyWith(height: 1.4))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Erreur')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('Erreur', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Impossible de charger le résumé', style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _NotFoundView extends StatelessWidget {
  const _NotFoundView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Résumé introuvable')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('Résumé introuvable', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Ce résumé n\'existe pas ou a été supprimé', style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
