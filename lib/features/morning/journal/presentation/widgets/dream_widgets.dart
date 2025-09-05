import 'package:flutter/material.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({super.key, required this.selectedMood, required this.onMoodSelected});

  final String? selectedMood;
  final ValueChanged<String?> onMoodSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: DreamMood.values.map((mood) {
        final isSelected = selectedMood == mood.name;
        return FilterChip(
          label: Text('${mood.emoji} ${mood.displayName}'),
          selected: isSelected,
          onSelected: (selected) {
            onMoodSelected(selected ? mood.name : null);
          },
        );
      }).toList(),
    );
  }
}

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key, required this.selectedCategory, required this.onCategorySelected});

  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: DreamCategory.values.map((category) {
        final isSelected = selectedCategory == category.name;
        return FilterChip(
          label: Text('${category.emoji} ${category.displayName}'),
          selected: isSelected,
          onSelected: (selected) {
            onCategorySelected(selected ? category.name : null);
          },
        );
      }).toList(),
    );
  }
}

class DreamStatsWidget extends StatelessWidget {
  const DreamStatsWidget({super.key, required this.totalDreams, required this.lucidDreams, required this.recentDreams});

  final int totalDreams;
  final int lucidDreams;
  final int recentDreams;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistiques', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(icon: Icons.bedtime_outlined, label: 'Total', value: totalDreams.toString(), color: Colors.blue),
                _StatItem(icon: Icons.auto_awesome, label: 'Lucides', value: lucidDreams.toString(), color: Colors.amber),
                _StatItem(icon: Icons.calendar_today, label: 'Ce mois', value: recentDreams.toString(), color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.label, required this.value, required this.color});

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}

class QuickDreamPrompts extends StatelessWidget {
  const QuickDreamPrompts({super.key, required this.onPromptSelected});

  final ValueChanged<String> onPromptSelected;

  static const List<String> prompts = [
    'Je volais dans mon rêve...',
    'J\'étais dans un endroit familier...',
    'Une personne importante était présente...',
    'Quelque chose d\'étrange s\'est produit...',
    'Je me sentais...',
    'L\'environnement était...',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Débuts de phrases', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: prompts.map((prompt) => ActionChip(label: Text(prompt), onPressed: () => onPromptSelected(prompt))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
