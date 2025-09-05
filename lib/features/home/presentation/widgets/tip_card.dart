import 'package:flutter/material.dart';
import '../../domain/entities/daily_tip.dart';

class TipCard extends StatelessWidget {
  final DailyTip tip;
  final VoidCallback? onTap;
  final bool showReadBadge;

  const TipCard({super.key, required this.tip, this.onTap, this.showReadBadge = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with category and read badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: _getCategoryColor(tip.category).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      _getCategoryDisplayName(tip.category),
                      style: theme.textTheme.labelSmall?.copyWith(color: _getCategoryColor(tip.category), fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  if (showReadBadge && tip.isRead)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, size: 12, color: Colors.green[700]),
                          const SizedBox(width: 4),
                          Text(
                            'Lu',
                            style: theme.textTheme.labelSmall?.copyWith(color: Colors.green[700], fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                tip.title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              const SizedBox(height: 8),

              // Content preview
              Text(
                tip.content,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              // Tags if available
              if (tip.tags != null && tip.tags!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tip.tags!
                      .take(3)
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: theme.colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(8)),
                          child: Text('#$tag', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                        ),
                      )
                      .toList(),
                ),
              ],

              // Read more arrow
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lire plus',
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16, color: theme.colorScheme.primary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
