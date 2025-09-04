import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';
import 'package:super_brain/features/training/presentation/controllers/training_controllers.dart';

class TrainingSessionPage extends ConsumerWidget {
  final TrainingPlan plan;

  const TrainingSessionPage({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(activeTrainingSessionProvider);

    // Listen for session completion and show completion dialog
    ref.listen(activeTrainingSessionProvider, (previous, next) {
      if (previous?.value != null && next.value == null) {
        // Session was completed
        _showSessionCompletedDialog(context);
      }
    });

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
              Text('Erreur: $error'),
              ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Retour')),
            ],
          ),
        ),
      ),
    );
  }

  void _showSessionCompletedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.celebration, color: Colors.orange, size: 32),
            const SizedBox(width: 8),
            const Text('Entraînement Terminé !'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Excellent travail pour avoir terminé ${plan.name} !', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            Text('Vous avez terminé votre session d\'entraînement avec succès.', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to training hub
            },
            child: const Text('Terminé'),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Quitter l\'Entraînement ?'),
        content: const Text('Vos progrès seront perdus si vous quittez maintenant.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Continuer')),
          TextButton(
            onPressed: () {
              ref.read(activeTrainingSessionProvider.notifier).cancelSession();
              Navigator.of(dialogContext).pop(); // Close dialog
              Navigator.of(context).pop(); // Close session page
            },
            child: const Text('Quitter'),
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
          Text('Exercices (${plan.exercises.length})', style: Theme.of(context).textTheme.titleLarge),
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
            child: const Text('Commencer l\'Entraînement', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  void _startSession(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(currentUserProvider);
    
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez vous connecter pour commencer un entraînement')),
      );
      return;
    }

    ref.read(activeTrainingSessionProvider.notifier).startSession(currentUser.uid, plan);

    // Start timer for the first exercise if it's timed
    final firstExercise = plan.exercises.first;
    if (firstExercise.type == ExerciseType.timed || firstExercise.type == ExerciseType.rest) {
      ref.read(exerciseTimerProvider.notifier).startTimer(firstExercise.duration);
    }
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
      return Text('${exercise.duration}s repos');
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

          // Exercise timer/controls - this now handles its own buttons
          Expanded(
            child: _ExerciseTimerWidget(exercise: activeSession.currentExercise, timerState: timerState),
          ),

          const SizedBox(height: 16),

          // Simplified action buttons - only show pause/emergency stop
          _SimplifiedActionButtons(activeSession: activeSession),
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
    final progress = exercise.duration > 0 ? (exercise.duration - timerState.remainingSeconds) / exercise.duration : 0.0;

    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.bedtime, size: 32, color: Colors.orange),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(timerState.remainingSeconds),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Rest Time', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Relax and recover. The next exercise will start automatically.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Only show skip button if you want to cut rest short
            if (timerState.remainingSeconds > 5)
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(exerciseTimerProvider.notifier).stopTimer();
                  ref.read(activeTrainingSessionProvider.notifier).nextExercise();
                },
                icon: const Icon(Icons.skip_next),
                label: const Text('Skip Rest'),
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimedExerciseTimer(BuildContext context, WidgetRef ref) {
    final progress = exercise.duration > 0 ? (exercise.duration - timerState.remainingSeconds) / exercise.duration : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(timerState.remainingSeconds <= 10 ? Colors.red : Theme.of(context).colorScheme.primary),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      _formatTime(timerState.remainingSeconds),
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: timerState.remainingSeconds <= 10 ? Colors.red : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('remaining', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Exercise will advance automatically when timer completes',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Only show manual completion if timer is almost done or user wants to skip
            if (timerState.remainingSeconds <= 5 || !timerState.isRunning)
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(exerciseTimerProvider.notifier).stopTimer();
                  final actualDuration = exercise.duration - timerState.remainingSeconds;
                  ref.read(activeTrainingSessionProvider.notifier).completeCurrentExercise(actualDuration: actualDuration > 0 ? actualDuration : exercise.duration);
                },
                icon: const Icon(Icons.check),
                label: Text(timerState.remainingSeconds <= 5 ? 'Complete Early' : 'Complete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
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
            Icon(Icons.fitness_center, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text('Target: ${exercise.targetReps ?? 'Complete'} reps', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Perform the exercise at your own pace. Tap "Complete" when finished.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // For reps exercises, we'll assume they completed the target reps
                ref.read(activeTrainingSessionProvider.notifier).completeCurrentExercise(actualReps: exercise.targetReps);
              },
              icon: const Icon(Icons.check),
              label: const Text('Complete Exercise'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
            ),
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

class _SimplifiedActionButtons extends ConsumerWidget {
  final ActiveTrainingSession activeSession;

  const _SimplifiedActionButtons({required this.activeSession});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(exerciseTimerProvider);

    return Row(
      children: [
        // Pause/Resume button for timed exercises
        if (activeSession.currentExercise.type == ExerciseType.timed || activeSession.currentExercise.type == ExerciseType.rest) ...[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: timerState.isRunning ? () => ref.read(exerciseTimerProvider.notifier).pauseTimer() : () => ref.read(exerciseTimerProvider.notifier).resumeTimer(),
              icon: Icon(timerState.isRunning ? Icons.pause : Icons.play_arrow),
              label: Text(timerState.isRunning ? 'Pause' : 'Reprendre'),
            ),
          ),
          const SizedBox(width: 16),
        ],

        // Skip exercise button (emergency use)
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showSkipDialog(context, ref),
            icon: const Icon(Icons.skip_next),
            label: const Text('Passer'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
              side: BorderSide(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
      ],
    );
  }

  void _showSkipDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Passer l\'Exercice ?'),
        content: Text('Êtes-vous sûr de vouloir passer "${activeSession.currentExercise.name}" ?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Annuler')),
          TextButton(
            onPressed: () {
              ref.read(activeTrainingSessionProvider.notifier).skipExercise();
              Navigator.of(context).pop();
            },
            child: const Text('Passer'),
          ),
        ],
      ),
    );
  }
}
