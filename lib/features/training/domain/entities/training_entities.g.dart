// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$ExerciseTypeEnumMap, json['type']),
  duration: (json['duration'] as num).toInt(),
  targetReps: (json['targetReps'] as num?)?.toInt(),
  instructions: json['instructions'] as String?,
  imageUrl: json['imageUrl'] as String?,
  videoUrl: json['videoUrl'] as String?,
  muscleGroups:
      (json['muscleGroups'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  equipment:
      (json['equipment'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': _$ExerciseTypeEnumMap[instance.type]!,
  'duration': instance.duration,
  'targetReps': instance.targetReps,
  'instructions': instance.instructions,
  'imageUrl': instance.imageUrl,
  'videoUrl': instance.videoUrl,
  'muscleGroups': instance.muscleGroups,
  'equipment': instance.equipment,
};

const _$ExerciseTypeEnumMap = {
  ExerciseType.timed: 'timed',
  ExerciseType.reps: 'reps',
  ExerciseType.rest: 'rest',
};

_TrainingPlan _$TrainingPlanFromJson(Map<String, dynamic> json) =>
    _TrainingPlan(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$TrainingCategoryEnumMap, json['category']),
      difficulty: $enumDecode(_$TrainingDifficultyEnumMap, json['difficulty']),
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TrainingPlanToJson(_TrainingPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': _$TrainingCategoryEnumMap[instance.category]!,
      'difficulty': _$TrainingDifficultyEnumMap[instance.difficulty]!,
      'estimatedDuration': instance.estimatedDuration,
      'exercises': instance.exercises,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$TrainingCategoryEnumMap = {
  TrainingCategory.cardio: 'cardio',
  TrainingCategory.strength: 'strength',
  TrainingCategory.yoga: 'yoga',
};

const _$TrainingDifficultyEnumMap = {
  TrainingDifficulty.beginner: 'beginner',
  TrainingDifficulty.intermediate: 'intermediate',
  TrainingDifficulty.advanced: 'advanced',
};

_TrainingSession _$TrainingSessionFromJson(Map<String, dynamic> json) =>
    _TrainingSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      planId: json['planId'] as String,
      planName: json['planName'] as String,
      category: $enumDecode(_$TrainingCategoryEnumMap, json['category']),
      difficulty: $enumDecode(_$TrainingDifficultyEnumMap, json['difficulty']),
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      plannedDuration: (json['plannedDuration'] as num).toInt(),
      actualDuration: (json['actualDuration'] as num?)?.toInt(),
      exerciseResults:
          (json['exerciseResults'] as List<dynamic>?)
              ?.map((e) => ExerciseResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isCompleted: json['isCompleted'] as bool? ?? false,
      userRating: (json['userRating'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TrainingSessionToJson(_TrainingSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'planId': instance.planId,
      'planName': instance.planName,
      'category': _$TrainingCategoryEnumMap[instance.category]!,
      'difficulty': _$TrainingDifficultyEnumMap[instance.difficulty]!,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'plannedDuration': instance.plannedDuration,
      'actualDuration': instance.actualDuration,
      'exerciseResults': instance.exerciseResults,
      'isCompleted': instance.isCompleted,
      'userRating': instance.userRating,
      'notes': instance.notes,
    };

_ExerciseResult _$ExerciseResultFromJson(Map<String, dynamic> json) =>
    _ExerciseResult(
      exerciseId: json['exerciseId'] as String,
      exerciseName: json['exerciseName'] as String,
      type: $enumDecode(_$ExerciseTypeEnumMap, json['type']),
      plannedDuration: (json['plannedDuration'] as num).toInt(),
      actualDuration: (json['actualDuration'] as num?)?.toInt(),
      actualReps: (json['actualReps'] as num?)?.toInt(),
      wasSkipped: json['wasSkipped'] as bool? ?? false,
      wasCompleted: json['wasCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$ExerciseResultToJson(_ExerciseResult instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'exerciseName': instance.exerciseName,
      'type': _$ExerciseTypeEnumMap[instance.type]!,
      'plannedDuration': instance.plannedDuration,
      'actualDuration': instance.actualDuration,
      'actualReps': instance.actualReps,
      'wasSkipped': instance.wasSkipped,
      'wasCompleted': instance.wasCompleted,
    };

_TrainingStats _$TrainingStatsFromJson(Map<String, dynamic> json) =>
    _TrainingStats(
      userId: json['userId'] as String,
      totalSessions: (json['totalSessions'] as num?)?.toInt() ?? 0,
      totalMinutes: (json['totalMinutes'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      lastSessionDate: json['lastSessionDate'] == null
          ? null
          : DateTime.parse(json['lastSessionDate'] as String),
      sessionsByCategory:
          (json['sessionsByCategory'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              $enumDecode(_$TrainingCategoryEnumMap, k),
              (e as num).toInt(),
            ),
          ) ??
          const {},
      sessionsByDifficulty:
          (json['sessionsByDifficulty'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              $enumDecode(_$TrainingDifficultyEnumMap, k),
              (e as num).toInt(),
            ),
          ) ??
          const {},
      completedPlanIds:
          (json['completedPlanIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map(
                (e) => TrainingAchievement.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TrainingStatsToJson(_TrainingStats instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'totalSessions': instance.totalSessions,
      'totalMinutes': instance.totalMinutes,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lastSessionDate': instance.lastSessionDate?.toIso8601String(),
      'sessionsByCategory': instance.sessionsByCategory.map(
        (k, e) => MapEntry(_$TrainingCategoryEnumMap[k]!, e),
      ),
      'sessionsByDifficulty': instance.sessionsByDifficulty.map(
        (k, e) => MapEntry(_$TrainingDifficultyEnumMap[k]!, e),
      ),
      'completedPlanIds': instance.completedPlanIds,
      'achievements': instance.achievements,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_TrainingAchievement _$TrainingAchievementFromJson(Map<String, dynamic> json) =>
    _TrainingAchievement(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$TrainingAchievementToJson(
  _TrainingAchievement instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'iconUrl': instance.iconUrl,
  'unlockedAt': instance.unlockedAt.toIso8601String(),
  'metadata': instance.metadata,
};

_ActiveTrainingSession _$ActiveTrainingSessionFromJson(
  Map<String, dynamic> json,
) => _ActiveTrainingSession(
  plan: TrainingPlan.fromJson(json['plan'] as Map<String, dynamic>),
  session: TrainingSession.fromJson(json['session'] as Map<String, dynamic>),
  currentExerciseIndex: (json['currentExerciseIndex'] as num).toInt(),
  currentExercise: Exercise.fromJson(
    json['currentExercise'] as Map<String, dynamic>,
  ),
  isResting: json['isResting'] as bool? ?? false,
  isPaused: json['isPaused'] as bool? ?? false,
  exerciseStartedAt: json['exerciseStartedAt'] == null
      ? null
      : DateTime.parse(json['exerciseStartedAt'] as String),
  sessionStartedAt: json['sessionStartedAt'] == null
      ? null
      : DateTime.parse(json['sessionStartedAt'] as String),
  completedExercises:
      (json['completedExercises'] as List<dynamic>?)
          ?.map((e) => ExerciseResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ActiveTrainingSessionToJson(
  _ActiveTrainingSession instance,
) => <String, dynamic>{
  'plan': instance.plan,
  'session': instance.session,
  'currentExerciseIndex': instance.currentExerciseIndex,
  'currentExercise': instance.currentExercise,
  'isResting': instance.isResting,
  'isPaused': instance.isPaused,
  'exerciseStartedAt': instance.exerciseStartedAt?.toIso8601String(),
  'sessionStartedAt': instance.sessionStartedAt?.toIso8601String(),
  'completedExercises': instance.completedExercises,
};
