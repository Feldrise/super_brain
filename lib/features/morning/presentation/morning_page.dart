import 'package:flutter/material.dart';
import 'package:super_brain/features/training/presentation/pages/training_hub_page.dart';
import 'package:super_brain/features/morning/journal/presentation/pages/dream_journal_page.dart';

class MorningPage extends StatelessWidget {
  const MorningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routine Matinale'), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [_GreetingSection(), const SizedBox(height: 24), _RoutineGrid()]),
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.wb_sunny, size: 48, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text('Bonjour !', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              'Commencez votre journée en beauté avec votre routine matinale.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoutineGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routineItems = [
      {'title': 'Journal des rêves', 'subtitle': 'Notez vos rêves', 'icon': Icons.bedtime_outlined, 'color': Colors.purple, 'completed': false},
      {'title': 'Journal quotidien', 'subtitle': 'Vos pensées du jour', 'icon': Icons.edit_note_outlined, 'color': Colors.blue, 'completed': true},
      {'title': 'Respiration guidée', 'subtitle': '5 minutes de calme', 'icon': Icons.self_improvement_outlined, 'color': Colors.green, 'completed': false},
      {'title': 'Entraînement', 'subtitle': 'Session courte', 'icon': Icons.fitness_center_outlined, 'color': Colors.orange, 'completed': false},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.2),
      itemCount: routineItems.length,
      itemBuilder: (context, index) {
        final item = routineItems[index];
        return _RoutineCard(
          title: item['title']! as String,
          subtitle: item['subtitle']! as String,
          icon: item['icon']! as IconData,
          color: item['color']! as Color,
          completed: item['completed']! as bool,
          onTap: () {
            if (item['title'] == 'Entraînement') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TrainingHubPage()));
            } else if (item['title'] == 'Journal des rêves') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DreamJournalPage()));
            } else {
              // TODO: Navigate to other routines
            }
          },
        );
      },
    );
  }
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard({required this.title, required this.subtitle, required this.icon, required this.color, required this.completed, required this.onTap});

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  if (completed)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                        child: const Icon(Icons.check, color: Colors.white, size: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
