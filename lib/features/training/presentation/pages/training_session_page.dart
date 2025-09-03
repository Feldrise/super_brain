import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';
import 'package:super_brain/features/training/presentation/controllers/training_controllers.dart';

class TrainingSessionPage extends ConsumerWidget {
  final TrainingPlan plan;

  const TrainingSessionPage({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(activeTrainingSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(plan.name),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => _showExitDialog(context, ref)),
        actions: [IconButton(icon: const Icon(Icons.pause), onPressed: () => ref.read(activeTrainingSessionProvider.notifier).pauseSession())],
      ),
      body: sessionState.when(
        data: (activeSession) {
          if (activeSession == null) {
            return _BuildSessionStartView(plan: plan);
          }
          return _BuildActiveSessionView(activeSession: activeSession);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Go Back')),
            ],
          ),
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Training?'),
        content: const Text('Your progress will be lost if you exit now.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Continue')),
          TextButton(
            onPressed: () {
              ref.read(activeTrainingSessionProvider.notifier).cancelSession();
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close session page
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}

class _BuildSessionStartView extends ConsumerWidget {
  final TrainingPlan plan;

  const _BuildSessionStartView({required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan.name, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(plan.description, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _InfoChip(icon: Icons.timer, label: '${plan.estimatedDuration} min'),
                      const SizedBox(width: 8),
                      _InfoChip(icon: Icons.fitness_center, label: plan.difficulty.name),
                      const SizedBox(width: 8),
                      _InfoChip(icon: Icons.category, label: plan.category.name),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Exercises (${plan.exercises.length})', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: plan.exercises.length,
              itemBuilder: (context, index) {
                final exercise = plan.exercises[index];
                return _ExercisePreviewCard(exercise: exercise, index: index + 1);
              },
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _startSession(context, ref),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text('Start Training', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  void _startSession(BuildContext context, WidgetRef ref) {
    const userId = 'current_user_id'; // This would come from auth
    ref.read(activeTrainingSessionProvider.notifier).startSession(userId, plan);
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.onPrimaryContainer),
          const SizedBox(width: 4),
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer)),
        ],
      ),
    );
  }
}

class _ExercisePreviewCard extends StatelessWidget {
  final Exercise exercise;
  final int index;

  const _ExercisePreviewCard({required this.exercise, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(child: Text('$index')),
        title: Text(exercise.name),
        subtitle: Text(exercise.description),
        trailing: _buildExerciseInfo(),
      ),
    );
  }

  Widget _buildExerciseInfo() {
    if (exercise.type == ExerciseType.rest) {
      return Text('${exercise.duration}s rest');
    } else if (exercise.type == ExerciseType.timed) {
      return Text('${exercise.duration}s');
    } else {
      return Text('${exercise.targetReps} reps');
    }
  }
}

class _BuildActiveSessionView extends ConsumerWidget {
  final ActiveTrainingSession activeSession;

  const _BuildActiveSessionView({required this.activeSession});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(exerciseTimerProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress indicator
          _SessionProgressIndicator(activeSession: activeSession),

          const SizedBox(height: 24),

          // Current exercise card
          _CurrentExerciseCard(exercise: activeSession.currentExercise, timerState: timerState),

          const SizedBox(height: 24),

          // Exercise timer/controls
          _ExerciseTimerWidget(exercise: activeSession.currentExercise, timerState: timerState),

          const Spacer(),

          // Action buttons
          _SessionActionButtons(activeSession: activeSession),
        ],
      ),
    );
  }
}

class _SessionProgressIndicator extends StatelessWidget {
  final ActiveTrainingSession activeSession;

  const _SessionProgressIndicator({required this.activeSession});

  @override
  Widget build(BuildContext context) {
    final progress = (activeSession.currentExerciseIndex + 1) / activeSession.plan.exercises.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Exercise ${activeSession.currentExerciseIndex + 1} of ${activeSession.plan.exercises.length}', style: Theme.of(context).textTheme.titleMedium),
            Text('${(progress * 100).round()}%', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: progress, backgroundColor: Theme.of(context).colorScheme.surfaceVariant),
      ],
    );
  }
}

class _CurrentExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final ExerciseTimerState timerState;

  const _CurrentExerciseCard({required this.exercise, required this.timerState});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(exercise.name, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(exercise.description, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
            if (exercise.instructions != null) ...[
              const SizedBox(height: 16),
              Text(
                exercise.instructions!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExerciseTimerWidget extends ConsumerWidget {
  final Exercise exercise;
  final ExerciseTimerState timerState;

  const _ExerciseTimerWidget({required this.exercise, required this.timerState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (exercise.type == ExerciseType.rest) {
      return _buildRestTimer(context, ref);
    } else if (exercise.type == ExerciseType.timed) {
      return _buildTimedExerciseTimer(context, ref);
    } else {
      return _buildRepsExerciseWidget(context, ref);
    }
  }

  Widget _buildRestTimer(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(Icons.bedtime, size: 48, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text('Rest Time', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              _formatTime(timerState.remainingSeconds),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimedExerciseTimer(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Time Remaining', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              _formatTime(timerState.remainingSeconds),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepsExerciseWidget(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Target Reps', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              '${exercise.targetReps}',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Complete ${exercise.targetReps} repetitions at your own pace', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class _SessionActionButtons extends ConsumerWidget {
  final ActiveTrainingSession activeSession;

  const _SessionActionButtons({required this.activeSession});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(exerciseTimerProvider);

    return Column(
      children: [
        if (activeSession.currentExercise.type != ExerciseType.rest) ...[
          Row(
            children: [
              Expanded(
                child: OutlinedButton(onPressed: () => ref.read(activeTrainingSessionProvider.notifier).skipExercise(), child: const Text('Skip')),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(onPressed: () => _completeExercise(ref), child: const Text('Complete')),
              ),
            ],
          ),
        ] else ...[
          // Rest period - show skip rest button
          ElevatedButton(onPressed: () => ref.read(activeTrainingSessionProvider.notifier).nextExercise(), child: const Text('Skip Rest')),
        ],
        const SizedBox(height: 8),
        if (activeSession.currentExercise.type == ExerciseType.timed || activeSession.currentExercise.type == ExerciseType.rest) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: timerState.isRunning ? () => ref.read(exerciseTimerProvider.notifier).pauseTimer() : () => ref.read(exerciseTimerProvider.notifier).resumeTimer(),
                icon: Icon(timerState.isRunning ? Icons.pause : Icons.play_arrow),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _completeExercise(WidgetRef ref) {
    ref.read(activeTrainingSessionProvider.notifier).completeCurrentExercise();
  }
}
