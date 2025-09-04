import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';
import 'package:super_brain/features/training/domain/usecases/training_usecases.dart';
import 'package:super_brain/features/training/domain/repositories/training_repository.dart';
import 'package:super_brain/features/training/data/repositories/training_repository_impl.dart';
import 'package:super_brain/features/training/data/datasources/training_plans_datasource.dart';
import 'package:super_brain/features/training/data/datasources/training_firestore_datasource.dart';

// Training Plans Provider
final trainingPlansProvider = FutureProvider<List<TrainingPlan>>((ref) async {
  final useCase = ref.watch(getTrainingPlansUseCaseProvider);
  return await useCase();
});

final trainingPlansByCategoryProvider = FutureProvider.family<List<TrainingPlan>, TrainingCategory>((ref, category) async {
  final useCase = ref.watch(getTrainingPlansUseCaseProvider);
  return await useCase(category: category);
});

final trainingPlansByDifficultyProvider = FutureProvider.family<List<TrainingPlan>, TrainingDifficulty>((ref, difficulty) async {
  final useCase = ref.watch(getTrainingPlansUseCaseProvider);
  return await useCase(difficulty: difficulty);
});

// User Training Data Providers
final userTrainingStatsProvider = StreamProvider.family<TrainingStats?, String>((ref, userId) {
  final useCase = ref.watch(getUserTrainingStatsUseCaseProvider);
  return useCase.watch(userId);
});

final userTrainingHistoryProvider = StreamProvider.family<List<TrainingSession>, String>((ref, userId) {
  final useCase = ref.watch(getUserTrainingHistoryUseCaseProvider);
  return useCase.watch(userId);
});

// Active Training Session State
final activeTrainingSessionProvider = StateNotifierProvider<ActiveTrainingSessionController, AsyncValue<ActiveTrainingSession?>>((ref) {
  return ActiveTrainingSessionController(ref);
});

class ActiveTrainingSessionController extends StateNotifier<AsyncValue<ActiveTrainingSession?>> {
  final Ref _ref;

  ActiveTrainingSessionController(this._ref) : super(const AsyncValue.data(null));

  Future<void> startSession(String userId, TrainingPlan plan) async {
    state = const AsyncValue.loading();

    try {
      final startSessionUseCase = _ref.read(startTrainingSessionUseCaseProvider);
      final session = await startSessionUseCase(userId, plan);

      final activeSession = ActiveTrainingSession(
        plan: plan,
        session: session,
        currentExerciseIndex: 0,
        currentExercise: plan.exercises.first,
        sessionStartedAt: DateTime.now(),
        exerciseStartedAt: DateTime.now(),
      );

      state = AsyncValue.data(activeSession);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void nextExercise() {
    final currentSession = state.value;
    if (currentSession == null) return;

    final nextIndex = currentSession.currentExerciseIndex + 1;

    if (nextIndex >= currentSession.plan.exercises.length) {
      // Session completed
      _completeSession();
      return;
    }

    final nextExercise = currentSession.plan.exercises[nextIndex];
    final updatedSession = currentSession.copyWith(currentExerciseIndex: nextIndex, currentExercise: nextExercise, exerciseStartedAt: DateTime.now());

    state = AsyncValue.data(updatedSession);

    // Auto-start timer for next exercise if it's timed
    if (nextExercise.type == ExerciseType.timed || nextExercise.type == ExerciseType.rest) {
      _ref.read(exerciseTimerProvider.notifier).startTimer(nextExercise.duration);
    }
  }

  void skipExercise() {
    final currentSession = state.value;
    if (currentSession == null) return;

    // Record the skipped exercise
    final skippedResult = ExerciseResult(
      exerciseId: currentSession.currentExercise.id,
      exerciseName: currentSession.currentExercise.name,
      type: currentSession.currentExercise.type,
      plannedDuration: currentSession.currentExercise.duration,
      wasSkipped: true,
      wasCompleted: false,
    );

    final updatedResults = [...currentSession.completedExercises, skippedResult];
    final updatedSession = currentSession.copyWith(completedExercises: updatedResults);

    state = AsyncValue.data(updatedSession);
    nextExercise();
  }

  void completeCurrentExercise({int? actualDuration, int? actualReps}) {
    final currentSession = state.value;
    if (currentSession == null) return;

    final completedResult = ExerciseResult(
      exerciseId: currentSession.currentExercise.id,
      exerciseName: currentSession.currentExercise.name,
      type: currentSession.currentExercise.type,
      plannedDuration: currentSession.currentExercise.duration,
      actualDuration: actualDuration,
      actualReps: actualReps,
      wasSkipped: false,
      wasCompleted: true,
    );

    final updatedResults = [...currentSession.completedExercises, completedResult];
    final updatedSession = currentSession.copyWith(completedExercises: updatedResults);

    state = AsyncValue.data(updatedSession);
    nextExercise();
  }

  void pauseSession() {
    final currentSession = state.value;
    if (currentSession == null) return;

    final updatedSession = currentSession.copyWith(isPaused: !currentSession.isPaused);
    state = AsyncValue.data(updatedSession);
  }

  Future<void> _completeSession() async {
    final currentSession = state.value;
    if (currentSession == null) return;

    try {
      // Play completion sound
      try {
        final audioPlayer = AudioPlayer();
        await audioPlayer.play(AssetSource('sounds/session_complete.mp3'));
        audioPlayer.dispose();
      } catch (e) {
        print('Could not play session completion sound: $e');
      }

      final completeSessionUseCase = _ref.read(completeTrainingSessionUseCaseProvider);

      await completeSessionUseCase(
        currentSession.session,
        currentSession.completedExercises,
        null, // We'll add rating in a separate step
        null, // No notes for now
      );

      // Check for achievements
      final checkAchievementsUseCase = _ref.read(checkAndUnlockAchievementsUseCaseProvider);
      final statsUseCase = _ref.read(getUserTrainingStatsUseCaseProvider);
      final stats = await statsUseCase(currentSession.session.userId);

      if (stats != null) {
        await checkAchievementsUseCase(currentSession.session.userId, stats);
      }

      // Clear the active session
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void cancelSession() {
    state = const AsyncValue.data(null);
  }
}

// Timer Controller for exercise timing
final exerciseTimerProvider = StateNotifierProvider<ExerciseTimerController, ExerciseTimerState>((ref) {
  return ExerciseTimerController(ref);
});

class ExerciseTimerState {
  final int remainingSeconds;
  final bool isRunning;
  final bool isCompleted;

  const ExerciseTimerState({required this.remainingSeconds, required this.isRunning, required this.isCompleted});

  ExerciseTimerState copyWith({int? remainingSeconds, bool? isRunning, bool? isCompleted}) {
    return ExerciseTimerState(remainingSeconds: remainingSeconds ?? this.remainingSeconds, isRunning: isRunning ?? this.isRunning, isCompleted: isCompleted ?? this.isCompleted);
  }
}

class ExerciseTimerController extends StateNotifier<ExerciseTimerState> {
  Timer? _timer;
  final Ref _ref;
  final AudioPlayer _audioPlayer = AudioPlayer();

  ExerciseTimerController(this._ref) : super(const ExerciseTimerState(remainingSeconds: 0, isRunning: false, isCompleted: false));

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void startTimer(int durationSeconds) {
    _timer?.cancel();
    state = ExerciseTimerState(remainingSeconds: durationSeconds, isRunning: true, isCompleted: false);
    _runTimer();
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void resumeTimer() {
    if (state.remainingSeconds > 0) {
      state = state.copyWith(isRunning: true);
      _runTimer();
    }
  }

  void stopTimer() {
    _timer?.cancel();
    state = const ExerciseTimerState(remainingSeconds: 0, isRunning: false, isCompleted: true);
  }

  void _playSound() async {
    try {
      // await _audioPlayer.play(AssetSource('sounds/timer_complete.mp3'));
    } catch (e) {
      // Fallback to system sound or just continue silently
      print('Could not play sound: $e');
    }
  }

  void _runTimer() {
    _timer?.cancel();

    if (!state.isRunning) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final newRemaining = state.remainingSeconds - 1;

      if (newRemaining <= 0) {
        timer.cancel();
        state = state.copyWith(remainingSeconds: 0, isRunning: false, isCompleted: true);

        // Play completion sound
        _playSound();

        // Auto-advance to next exercise after a brief delay
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            final activeSession = _ref.read(activeTrainingSessionProvider).value;
            if (activeSession != null) {
              final currentExercise = activeSession.currentExercise;

              // Auto-complete current exercise based on type
              if (currentExercise.type == ExerciseType.timed) {
                _ref.read(activeTrainingSessionProvider.notifier).completeCurrentExercise(actualDuration: currentExercise.duration);
              } else if (currentExercise.type == ExerciseType.rest) {
                _ref.read(activeTrainingSessionProvider.notifier).nextExercise();
              }
            }
          }
        });
      } else {
        state = state.copyWith(remainingSeconds: newRemaining);

        // Play countdown beep for last 5 seconds
        if (newRemaining <= 5 && newRemaining > 4) {
          _playCountdownBeep();
        }
      }
    });
  }

  void _playCountdownBeep() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/countdown_beep.mp3'));
    } catch (e) {
      // Fallback - could use system beep
      print('Could not play countdown beep: $e');
    }
  }
}

// Use Case Providers (these would be defined in a separate providers file)
final getTrainingPlansUseCaseProvider = Provider<GetTrainingPlansUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return GetTrainingPlansUseCase(repository);
});

final startTrainingSessionUseCaseProvider = Provider<StartTrainingSessionUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return StartTrainingSessionUseCase(repository);
});

final completeTrainingSessionUseCaseProvider = Provider<CompleteTrainingSessionUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return CompleteTrainingSessionUseCase(repository);
});

final getUserTrainingStatsUseCaseProvider = Provider<GetUserTrainingStatsUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return GetUserTrainingStatsUseCase(repository);
});

final getUserTrainingHistoryUseCaseProvider = Provider<GetUserTrainingHistoryUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return GetUserTrainingHistoryUseCase(repository);
});

final checkAndUnlockAchievementsUseCaseProvider = Provider<CheckAndUnlockAchievementsUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return CheckAndUnlockAchievementsUseCase(repository);
});

// Data Sources
final trainingPlansDataSourceProvider = Provider<TrainingPlansDataSource>((ref) {
  return LocalTrainingPlansDataSource();
});

final trainingFirestoreDataSourceProvider = Provider<TrainingFirestoreDataSource>((ref) {
  return TrainingFirestoreDataSourceImpl();
});

// Repository Provider (this would be defined with the actual implementation)
final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  final plansDataSource = ref.watch(trainingPlansDataSourceProvider);
  final firestoreDataSource = ref.watch(trainingFirestoreDataSourceProvider);

  return TrainingRepositoryImpl(plansDataSource: plansDataSource, firestoreDataSource: firestoreDataSource);
});
