import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/daily_tip.dart';
import '../providers/tip_providers.dart';

class TipDetailPage extends ConsumerStatefulWidget {
  final DailyTip tip;

  const TipDetailPage({super.key, required this.tip});

  @override
  ConsumerState<TipDetailPage> createState() => _TipDetailPageState();
}

class _TipDetailPageState extends ConsumerState<TipDetailPage> {
  @override
  void initState() {
    super.initState();
    // Mark tip as read when the detail page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.tip.isRead) {
        ref.read(markTipAsReadProvider)(widget.tip.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        actions: [IconButton(icon: const Icon(Icons.share), onPressed: () => _shareTip())],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: _getCategoryColor(widget.tip.category).withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_getCategoryIcon(widget.tip.category), size: 16, color: _getCategoryColor(widget.tip.category)),
                  const SizedBox(width: 6),
                  Text(
                    _getCategoryDisplayName(widget.tip.category),
                    style: theme.textTheme.labelMedium?.copyWith(color: _getCategoryColor(widget.tip.category), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              widget.tip.title,
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 16),

            // Content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
              ),
              child: Text(widget.tip.content, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6, color: theme.colorScheme.onSurface)),
            ),

            // Tags
            if (widget.tip.tags != null && widget.tip.tags!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Mots-clés',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.tip.tags!
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: theme.colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          '#$tag',
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],

            const SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _getRandomTip(),
                    icon: const Icon(Icons.shuffle),
                    label: const Text('Conseil aléatoire'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _viewAllTips(),
                    icon: const Icon(Icons.list),
                    label: const Text('Tous les conseils'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _shareTip() {
    // TODO: Implement sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fonctionnalité de partage à venir')));
  }

  void _getRandomTip() async {
    final randomTip = await ref.read(randomTipProvider.future);
    if (randomTip != null && mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TipDetailPage(tip: randomTip)));
    }
  }

  void _viewAllTips() {
    Navigator.of(context).pop(); // Return to tips list
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'memory':
        return Colors.purple;
      case 'concentration':
        return Colors.blue;
      case 'productivity':
        return Colors.green;
      case 'health':
        return Colors.red;
      case 'learning':
        return Colors.orange;
      case 'motivation':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'memory':
        return Icons.psychology;
      case 'concentration':
        return Icons.center_focus_strong;
      case 'productivity':
        return Icons.trending_up;
      case 'health':
        return Icons.favorite;
      case 'learning':
        return Icons.school;
      case 'motivation':
        return Icons.emoji_emotions;
      default:
        return Icons.lightbulb;
    }
  }

  String _getCategoryDisplayName(String category) {
    switch (category.toLowerCase()) {
      case 'memory':
        return 'Mémoire';
      case 'concentration':
        return 'Concentration';
      case 'productivity':
        return 'Productivité';
      case 'health':
        return 'Santé';
      case 'learning':
        return 'Apprentissage';
      case 'motivation':
        return 'Motivation';
      default:
        return 'Général';
    }
  }
}
