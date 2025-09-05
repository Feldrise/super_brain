import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/home/presentation/widgets/tip_of_day_card.dart';
import 'package:super_brain/features/home/presentation/widgets/quick_stats_card.dart';
import 'package:super_brain/features/home/presentation/widgets/quick_actions_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('SuperBrain'), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_WelcomeSection(), SizedBox(height: 24), TipOfDayCard(), SizedBox(height: 16), QuickStatsCard(), SizedBox(height: 16), QuickActionsCard()],
        ),
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeOfDay = _getTimeOfDay();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          timeOfDay,
          style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text('Prêt à stimuler votre cerveau ?', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bonjour !';
    if (hour < 17) return 'Bon après-midi !';
    return 'Bonsoir !';
  }
}
