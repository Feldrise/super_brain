import 'package:flutter/material.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';

class TrainingPlanCard extends StatelessWidget {
  final TrainingPlan plan;
  final VoidCallback onTap;

  const TrainingPlanCard({super.key, required this.plan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Plan icon/image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(color: _getCategoryColor(plan.category).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(_getCategoryIcon(plan.category), color: _getCategoryColor(plan.category), size: 30),
              ),

              const SizedBox(width: 16),

              // Plan details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      plan.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _InfoTag(icon: Icons.timer, text: '${plan.estimatedDuration} min'),
                        const SizedBox(width: 8),
                        _InfoTag(icon: Icons.signal_cellular_alt, text: _getDifficultyLabel(plan.difficulty)),
                        const SizedBox(width: 8),
                        _InfoTag(icon: Icons.fitness_center, text: '${plan.exercises.length} exercises'),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(TrainingCategory category) {
    switch (category) {
      case TrainingCategory.cardio:
        return Colors.red;
      case TrainingCategory.strength:
        return Colors.blue;
      case TrainingCategory.yoga:
        return Colors.green;
    }
  }

  IconData _getCategoryIcon(TrainingCategory category) {
    switch (category) {
      case TrainingCategory.cardio:
        return Icons.favorite;
      case TrainingCategory.strength:
        return Icons.fitness_center;
      case TrainingCategory.yoga:
        return Icons.self_improvement;
    }
  }

  String _getDifficultyLabel(TrainingDifficulty difficulty) {
    switch (difficulty) {
      case TrainingDifficulty.beginner:
        return 'Beginner';
      case TrainingDifficulty.intermediate:
        return 'Intermediate';
      case TrainingDifficulty.advanced:
        return 'Advanced';
    }
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoTag({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
