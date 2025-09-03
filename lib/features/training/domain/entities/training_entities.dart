import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_entities.freezed.dart';
part 'training_entities.g.dart';

enum TrainingCategory {
  @JsonValue('cardio')
  cardio,
  @JsonValue('strength')
  strength,
  @JsonValue('yoga')
  yoga,
}

enum TrainingDifficulty {
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
}

enum ExerciseType {
  @JsonValue('timed')
  timed, // Exercise with specific duration (e.g., plank for 30s)
  @JsonValue('reps')
  reps, // Exercise with repetitions (e.g., 10 push-ups)
  @JsonValue('rest')
  rest, // Rest period between exercises
}

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    required String description,
    required ExerciseType type,
    required int duration, // Duration in seconds for timed exercises or rest
    int? targetReps, // Target repetitions for reps-based exercises
    String? instructions,
    String? imageUrl,
    String? videoUrl,
    @Default([]) List<String> muscleGroups,
    @Default([]) List<String> equipment, // Empty list means bodyweight only
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}

@freezed
abstract class TrainingPlan with _$TrainingPlan {
  const factory TrainingPlan({
    required String id,
    required String name,
    required String description,
    required TrainingCategory category,
    required TrainingDifficulty difficulty,
    required int estimatedDuration, // Total duration in minutes
    required List<Exercise> exercises,
    String? imageUrl,
    @Default([]) List<String> tags,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _TrainingPlan;

  factory TrainingPlan.fromJson(Map<String, dynamic> json) => _$TrainingPlanFromJson(json);
}

@freezed
abstract class TrainingSession with _$TrainingSession {
  const factory TrainingSession({
    required String id,
    required String userId,
    required String planId,
    required String planName,
    required TrainingCategory category,
    required TrainingDifficulty difficulty,
    required DateTime startedAt,
    DateTime? completedAt,
    required int plannedDuration, // Original planned duration in seconds
    int? actualDuration, // Actual duration completed in seconds
    @Default([]) List<ExerciseResult> exerciseResults,
    @Default(false) bool isCompleted,
    int? userRating, // User rating 1-5 after completion
    String? notes,
  }) = _TrainingSession;

  factory TrainingSession.fromJson(Map<String, dynamic> json) => _$TrainingSessionFromJson(json);
}

@freezed
abstract class ExerciseResult with _$ExerciseResult {
  const factory ExerciseResult({
    required String exerciseId,
    required String exerciseName,
    required ExerciseType type,
    required int plannedDuration,
    int? actualDuration, // How long the user actually did the exercise
    int? actualReps, // How many reps the user actually completed
    @Default(false) bool wasSkipped,
    @Default(false) bool wasCompleted,
  }) = _ExerciseResult;

  factory ExerciseResult.fromJson(Map<String, dynamic> json) => _$ExerciseResultFromJson(json);
}

@freezed
abstract class TrainingStats with _$TrainingStats {
  const factory TrainingStats({
    required String userId,
    @Default(0) int totalSessions,
    @Default(0) int totalMinutes,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    DateTime? lastSessionDate,
    @Default({}) Map<TrainingCategory, int> sessionsByCategory,
    @Default({}) Map<TrainingDifficulty, int> sessionsByDifficulty,
    @Default([]) List<String> completedPlanIds,
    @Default([]) List<TrainingAchievement> achievements,
    DateTime? updatedAt,
  }) = _TrainingStats;

  factory TrainingStats.fromJson(Map<String, dynamic> json) => _$TrainingStatsFromJson(json);
}

@freezed
abstract class TrainingAchievement with _$TrainingAchievement {
  const factory TrainingAchievement({
    required String id,
    required String name,
    required String description,
    required String iconUrl,
    required DateTime unlockedAt,
    @Default({}) Map<String, dynamic> metadata,
  }) = _TrainingAchievement;

  factory TrainingAchievement.fromJson(Map<String, dynamic> json) => _$TrainingAchievementFromJson(json);
}

// Session state for the active training session
@freezed
abstract class ActiveTrainingSession with _$ActiveTrainingSession {
  const factory ActiveTrainingSession({
    required TrainingPlan plan,
    required TrainingSession session,
    required int currentExerciseIndex,
    required Exercise currentExercise,
    @Default(false) bool isResting,
    @Default(false) bool isPaused,
    DateTime? exerciseStartedAt,
    DateTime? sessionStartedAt,
    @Default([]) List<ExerciseResult> completedExercises,
  }) = _ActiveTrainingSession;

  factory ActiveTrainingSession.fromJson(Map<String, dynamic> json) => _$ActiveTrainingSessionFromJson(json);
}
