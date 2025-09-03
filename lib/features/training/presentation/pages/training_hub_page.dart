import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';
import 'package:super_brain/features/training/presentation/controllers/training_controllers.dart';
import 'package:super_brain/features/training/presentation/widgets/training_plan_card.dart';
import 'package:super_brain/features/training/presentation/widgets/training_stats_card.dart';
import 'package:super_brain/features/training/presentation/pages/training_session_page.dart';

class TrainingHubPage extends ConsumerWidget {
  const TrainingHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Stats Card
            const _UserStatsSection(),

            const SizedBox(height: 24),

            // Quick Actions
            const _QuickActionsSection(),

            const SizedBox(height: 24),

            // Training Categories
            const _CategoriesSection(),

            const SizedBox(height: 24),

            // Recent Plans or Recommended
            const _RecommendedPlansSection(),
          ],
        ),
      ),
    );
  }
}

class _UserStatsSection extends ConsumerWidget {
  const _UserStatsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assuming we have a current user provider
    const userId = 'current_user_id'; // This would come from auth
    final statsAsync = ref.watch(userTrainingStatsProvider(userId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Progress', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            statsAsync.when(
              data: (stats) => stats != null ? TrainingStatsCard(stats: stats) : const _EmptyStatsWidget(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error loading stats: $error'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyStatsWidget extends StatelessWidget {
  const _EmptyStatsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.fitness_center, size: 48, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
        const SizedBox(height: 8),
        Text('No training sessions yet', style: Theme.of(context).textTheme.bodyLarge),
        Text(
          'Start your first session to begin tracking progress',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
        ),
      ],
    );
  }
}

class _QuickActionsSection extends ConsumerWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Start', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                title: '5-Min Cardio',
                subtitle: 'Get your heart pumping',
                icon: Icons.favorite,
                color: Colors.red,
                onTap: () => _startQuickCardio(context, ref),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                title: '10-Min Strength',
                subtitle: 'Build muscle',
                icon: Icons.fitness_center,
                color: Colors.blue,
                onTap: () => _startQuickStrength(context, ref),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                title: '15-Min Yoga',
                subtitle: 'Stretch & relax',
                icon: Icons.self_improvement,
                color: Colors.green,
                onTap: () => _startQuickYoga(context, ref),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _startQuickCardio(BuildContext context, WidgetRef ref) {
    // Navigate to session with quick cardio plan
    _startQuickSession(context, ref, 'cardio_quick_5');
  }

  void _startQuickStrength(BuildContext context, WidgetRef ref) {
    _startQuickSession(context, ref, 'strength_bodyweight_10');
  }

  void _startQuickYoga(BuildContext context, WidgetRef ref) {
    _startQuickSession(context, ref, 'yoga_morning_15');
  }

  void _startQuickSession(BuildContext context, WidgetRef ref, String planId) async {
    // Fetch the specific plan and start the session
    final plansAsync = ref.read(trainingPlansProvider);

    plansAsync.when(
      data: (plans) {
        final plan = plans.where((p) => p.id == planId).firstOrNull;
        if (plan != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrainingSessionPage(plan: plan)));
        } else {
          // Fall back to the first plan of the requested type
          late TrainingPlan? fallbackPlan;
          if (planId.contains('cardio')) {
            fallbackPlan = plans.where((p) => p.category == TrainingCategory.cardio).firstOrNull;
          } else if (planId.contains('strength')) {
            fallbackPlan = plans.where((p) => p.category == TrainingCategory.strength).firstOrNull;
          } else if (planId.contains('yoga')) {
            fallbackPlan = plans.where((p) => p.category == TrainingCategory.yoga).firstOrNull;
          }

          if (fallbackPlan != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrainingSessionPage(plan: fallbackPlan!)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No training plans available')));
          }
        }
      },
      loading: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Loading training plans...')));
      },
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading plans: $error')));
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({required this.title, required this.subtitle, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoriesSection extends ConsumerWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Browse by Category', style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () {
                // Navigate to all plans
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _CategoryCard(
                category: TrainingCategory.cardio,
                title: 'Cardio',
                description: 'Heart-pumping workouts',
                icon: Icons.favorite,
                color: Colors.red,
                onTap: () => _browsePlans(context, TrainingCategory.cardio),
              ),
              const SizedBox(width: 12),
              _CategoryCard(
                category: TrainingCategory.strength,
                title: 'Strength',
                description: 'Build muscle & power',
                icon: Icons.fitness_center,
                color: Colors.blue,
                onTap: () => _browsePlans(context, TrainingCategory.strength),
              ),
              const SizedBox(width: 12),
              _CategoryCard(
                category: TrainingCategory.yoga,
                title: 'Yoga',
                description: 'Flexibility & mindfulness',
                icon: Icons.self_improvement,
                color: Colors.green,
                onTap: () => _browsePlans(context, TrainingCategory.yoga),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _browsePlans(BuildContext context, TrainingCategory category) {
    // Navigate to plans list filtered by category
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Browsing ${category.name} plans...')));
  }
}

class _CategoryCard extends StatelessWidget {
  final TrainingCategory category;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({required this.category, required this.title, required this.description, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(height: 12),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(description, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecommendedPlansSection extends ConsumerWidget {
  const _RecommendedPlansSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(trainingPlansProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recommended for You', style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () {
                // Navigate to all plans
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        plansAsync.when(
          data: (plans) => plans.isNotEmpty
              ? Column(
                  children: plans
                      .take(3) // Show first 3 plans
                      .map(
                        (plan) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TrainingPlanCard(plan: plan, onTap: () => _startPlan(context, ref, plan)),
                        ),
                      )
                      .toList(),
                )
              : const _EmptyPlansWidget(),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error loading plans: $error'),
        ),
      ],
    );
  }

  void _startPlan(BuildContext context, WidgetRef ref, TrainingPlan plan) {
    // Navigate to training session with this plan
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrainingSessionPage(plan: plan)));
  }
}

class _EmptyPlansWidget extends StatelessWidget {
  const _EmptyPlansWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 48, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
          const SizedBox(height: 8),
          Text('No training plans available', style: Theme.of(context).textTheme.bodyLarge),
          Text('Check back later for new content', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
        ],
      ),
    );
  }
}
