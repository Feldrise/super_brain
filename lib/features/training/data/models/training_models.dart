import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';

class TrainingPlanModel {
  final String id;
  final String name;
  final String description;
  final TrainingCategory category;
  final TrainingDifficulty difficulty;
  final int estimatedDuration;
  final List<Exercise> exercises;
  final String? imageUrl;
  final List<String> tags;
  final bool isActive;
  final DateTime? createdAt;

  const TrainingPlanModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.estimatedDuration,
    required this.exercises,
    this.imageUrl,
    this.tags = const [],
    this.isActive = true,
    this.createdAt,
  });

  // Convert to domain entity
  TrainingPlan toDomain() => TrainingPlan(
    id: id,
    name: name,
    description: description,
    category: category,
    difficulty: difficulty,
    estimatedDuration: estimatedDuration,
    exercises: exercises,
    imageUrl: imageUrl,
    tags: tags,
    isActive: isActive,
    createdAt: createdAt,
  );

  factory TrainingPlanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TrainingPlanModel.fromJson({'id': doc.id, ...data});
  }

  factory TrainingPlanModel.fromJson(Map<String, dynamic> json) {
    return TrainingPlanModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: TrainingCategory.values.firstWhere((e) => e.toString().split('.').last == json['category']),
      difficulty: TrainingDifficulty.values.firstWhere((e) => e.toString().split('.').last == json['difficulty']),
      estimatedDuration: json['estimatedDuration'],
      exercises: (json['exercises'] as List<dynamic>).map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>).toDomain()).toList(),
      imageUrl: json['imageUrl'],
      tags: List<String>.from(json['tags'] ?? []),
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    data.remove('id'); // Remove ID for Firestore document
    if (data['createdAt'] != null) {
      data['createdAt'] = Timestamp.fromDate(data['createdAt']);
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.toString().split('.').last,
      'difficulty': difficulty.toString().split('.').last,
      'estimatedDuration': estimatedDuration,
      'exercises': exercises.map((e) => ExerciseModel.fromDomain(e).toJson()).toList(),
      'imageUrl': imageUrl,
      'tags': tags,
      'isActive': isActive,
      'createdAt': createdAt,
    };
  }
}

class ExerciseModel {
  final String id;
  final String name;
  final String description;
  final ExerciseType type;
  final int duration;
  final int? targetReps;
  final String? instructions;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> muscleGroups;
  final List<String> equipment;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.duration,
    this.targetReps,
    this.instructions,
    this.imageUrl,
    this.videoUrl,
    this.muscleGroups = const [],
    this.equipment = const [],
  });

  // Convert to domain entity
  Exercise toDomain() => Exercise(
    id: id,
    name: name,
    description: description,
    type: type,
    duration: duration,
    targetReps: targetReps,
    instructions: instructions,
    imageUrl: imageUrl,
    videoUrl: videoUrl,
    muscleGroups: muscleGroups,
    equipment: equipment,
  );

  // Create from domain entity
  factory ExerciseModel.fromDomain(Exercise exercise) => ExerciseModel(
    id: exercise.id,
    name: exercise.name,
    description: exercise.description,
    type: exercise.type,
    duration: exercise.duration,
    targetReps: exercise.targetReps,
    instructions: exercise.instructions,
    imageUrl: exercise.imageUrl,
    videoUrl: exercise.videoUrl,
    muscleGroups: exercise.muscleGroups,
    equipment: exercise.equipment,
  );

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: ExerciseType.values.firstWhere((e) => e.toString().split('.').last == json['type']),
      duration: json['duration'],
      targetReps: json['targetReps'],
      instructions: json['instructions'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      muscleGroups: List<String>.from(json['muscleGroups'] ?? []),
      equipment: List<String>.from(json['equipment'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.toString().split('.').last,
      'duration': duration,
      'targetReps': targetReps,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'muscleGroups': muscleGroups,
      'equipment': equipment,
    };
  }
}

class TrainingSessionModel {
  final String id;
  final String userId;
  final String planId;
  final String planName;
  final TrainingCategory category;
  final TrainingDifficulty difficulty;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int plannedDuration;
  final int? actualDuration;
  final List<ExerciseResult> exerciseResults;
  final bool isCompleted;
  final int? userRating;
  final String? notes;

  const TrainingSessionModel({
    required this.id,
    required this.userId,
    required this.planId,
    required this.planName,
    required this.category,
    required this.difficulty,
    required this.startedAt,
    this.completedAt,
    required this.plannedDuration,
    this.actualDuration,
    this.exerciseResults = const [],
    this.isCompleted = false,
    this.userRating,
    this.notes,
  });

  // Convert to domain entity
  TrainingSession toDomain() => TrainingSession(
    id: id,
    userId: userId,
    planId: planId,
    planName: planName,
    category: category,
    difficulty: difficulty,
    startedAt: startedAt,
    completedAt: completedAt,
    plannedDuration: plannedDuration,
    actualDuration: actualDuration,
    exerciseResults: exerciseResults,
    isCompleted: isCompleted,
    userRating: userRating,
    notes: notes,
  );

  // Create from domain entity
  factory TrainingSessionModel.fromDomain(TrainingSession session) => TrainingSessionModel(
    id: session.id,
    userId: session.userId,
    planId: session.planId,
    planName: session.planName,
    category: session.category,
    difficulty: session.difficulty,
    startedAt: session.startedAt,
    completedAt: session.completedAt,
    plannedDuration: session.plannedDuration,
    actualDuration: session.actualDuration,
    exerciseResults: session.exerciseResults,
    isCompleted: session.isCompleted,
    userRating: session.userRating,
    notes: session.notes,
  );

  factory TrainingSessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TrainingSessionModel.fromJson({'id': doc.id, ...data});
  }

  factory TrainingSessionModel.fromJson(Map<String, dynamic> json) {
    return TrainingSessionModel(
      id: json['id'],
      userId: json['userId'],
      planId: json['planId'],
      planName: json['planName'],
      category: TrainingCategory.values.firstWhere((e) => e.toString().split('.').last == json['category']),
      difficulty: TrainingDifficulty.values.firstWhere((e) => e.toString().split('.').last == json['difficulty']),
      startedAt: (json['startedAt'] as Timestamp).toDate(),
      completedAt: json['completedAt'] != null ? (json['completedAt'] as Timestamp).toDate() : null,
      plannedDuration: json['plannedDuration'],
      actualDuration: json['actualDuration'],
      exerciseResults: (json['exerciseResults'] as List<dynamic>?)?.map((e) => ExerciseResultModel.fromJson(e as Map<String, dynamic>).toDomain()).toList() ?? [],
      isCompleted: json['isCompleted'] ?? false,
      userRating: json['userRating'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    data.remove('id'); // Remove ID for Firestore document
    data['startedAt'] = Timestamp.fromDate(startedAt);
    if (completedAt != null) {
      data['completedAt'] = Timestamp.fromDate(completedAt!);
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'planId': planId,
      'planName': planName,
      'category': category.toString().split('.').last,
      'difficulty': difficulty.toString().split('.').last,
      'startedAt': startedAt,
      'completedAt': completedAt,
      'plannedDuration': plannedDuration,
      'actualDuration': actualDuration,
      'exerciseResults': exerciseResults.map((e) => ExerciseResultModel.fromDomain(e).toJson()).toList(),
      'isCompleted': isCompleted,
      'userRating': userRating,
      'notes': notes,
    };
  }
}

class ExerciseResultModel {
  final String exerciseId;
  final String exerciseName;
  final ExerciseType type;
  final int plannedDuration;
  final int? actualDuration;
  final int? actualReps;
  final bool wasSkipped;
  final bool wasCompleted;

  const ExerciseResultModel({
    required this.exerciseId,
    required this.exerciseName,
    required this.type,
    required this.plannedDuration,
    this.actualDuration,
    this.actualReps,
    this.wasSkipped = false,
    this.wasCompleted = false,
  });

  // Convert to domain entity
  ExerciseResult toDomain() => ExerciseResult(
    exerciseId: exerciseId,
    exerciseName: exerciseName,
    type: type,
    plannedDuration: plannedDuration,
    actualDuration: actualDuration,
    actualReps: actualReps,
    wasSkipped: wasSkipped,
    wasCompleted: wasCompleted,
  );

  // Create from domain entity
  factory ExerciseResultModel.fromDomain(ExerciseResult result) => ExerciseResultModel(
    exerciseId: result.exerciseId,
    exerciseName: result.exerciseName,
    type: result.type,
    plannedDuration: result.plannedDuration,
    actualDuration: result.actualDuration,
    actualReps: result.actualReps,
    wasSkipped: result.wasSkipped,
    wasCompleted: result.wasCompleted,
  );

  factory ExerciseResultModel.fromJson(Map<String, dynamic> json) {
    return ExerciseResultModel(
      exerciseId: json['exerciseId'],
      exerciseName: json['exerciseName'],
      type: ExerciseType.values.firstWhere((e) => e.toString().split('.').last == json['type']),
      plannedDuration: json['plannedDuration'],
      actualDuration: json['actualDuration'],
      actualReps: json['actualReps'],
      wasSkipped: json['wasSkipped'] ?? false,
      wasCompleted: json['wasCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'type': type.toString().split('.').last,
      'plannedDuration': plannedDuration,
      'actualDuration': actualDuration,
      'actualReps': actualReps,
      'wasSkipped': wasSkipped,
      'wasCompleted': wasCompleted,
    };
  }
}

class TrainingStatsModel {
  final String userId;
  final int totalSessions;
  final int totalMinutes;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastSessionDate;
  final Map<TrainingCategory, int> sessionsByCategory;
  final Map<TrainingDifficulty, int> sessionsByDifficulty;
  final List<String> completedPlanIds;
  final List<TrainingAchievement> achievements;
  final DateTime? updatedAt;

  const TrainingStatsModel({
    required this.userId,
    this.totalSessions = 0,
    this.totalMinutes = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastSessionDate,
    this.sessionsByCategory = const {},
    this.sessionsByDifficulty = const {},
    this.completedPlanIds = const [],
    this.achievements = const [],
    this.updatedAt,
  });

  // Convert to domain entity
  TrainingStats toDomain() => TrainingStats(
    userId: userId,
    totalSessions: totalSessions,
    totalMinutes: totalMinutes,
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    lastSessionDate: lastSessionDate,
    sessionsByCategory: sessionsByCategory,
    sessionsByDifficulty: sessionsByDifficulty,
    completedPlanIds: completedPlanIds,
    achievements: achievements,
    updatedAt: updatedAt,
  );

  // Create from domain entity
  factory TrainingStatsModel.fromDomain(TrainingStats stats) => TrainingStatsModel(
    userId: stats.userId,
    totalSessions: stats.totalSessions,
    totalMinutes: stats.totalMinutes,
    currentStreak: stats.currentStreak,
    longestStreak: stats.longestStreak,
    lastSessionDate: stats.lastSessionDate,
    sessionsByCategory: stats.sessionsByCategory,
    sessionsByDifficulty: stats.sessionsByDifficulty,
    completedPlanIds: stats.completedPlanIds,
    achievements: stats.achievements,
    updatedAt: stats.updatedAt,
  );

  factory TrainingStatsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TrainingStatsModel.fromJson({'userId': doc.id, ...data});
  }

  factory TrainingStatsModel.fromJson(Map<String, dynamic> json) {
    return TrainingStatsModel(
      userId: json['userId'],
      totalSessions: json['totalSessions'] ?? 0,
      totalMinutes: json['totalMinutes'] ?? 0,
      currentStreak: json['currentStreak'] ?? 0,
      longestStreak: json['longestStreak'] ?? 0,
      lastSessionDate: json['lastSessionDate'] != null ? (json['lastSessionDate'] as Timestamp).toDate() : null,
      sessionsByCategory: Map<TrainingCategory, int>.fromEntries(
        (json['sessionsByCategory'] as Map<String, dynamic>? ?? {}).entries.map(
          (e) => MapEntry(TrainingCategory.values.firstWhere((cat) => cat.toString().split('.').last == e.key), e.value as int),
        ),
      ),
      sessionsByDifficulty: Map<TrainingDifficulty, int>.fromEntries(
        (json['sessionsByDifficulty'] as Map<String, dynamic>? ?? {}).entries.map(
          (e) => MapEntry(TrainingDifficulty.values.firstWhere((diff) => diff.toString().split('.').last == e.key), e.value as int),
        ),
      ),
      completedPlanIds: List<String>.from(json['completedPlanIds'] ?? []),
      achievements: (json['achievements'] as List<dynamic>?)?.map((e) => TrainingAchievementModel.fromJson(e as Map<String, dynamic>).toDomain()).toList() ?? [],
      updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    data.remove('userId'); // Remove userId for Firestore document
    if (lastSessionDate != null) {
      data['lastSessionDate'] = Timestamp.fromDate(lastSessionDate!);
    }
    if (updatedAt != null) {
      data['updatedAt'] = Timestamp.fromDate(updatedAt!);
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalSessions': totalSessions,
      'totalMinutes': totalMinutes,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastSessionDate': lastSessionDate,
      'sessionsByCategory': Map<String, int>.fromEntries(sessionsByCategory.entries.map((e) => MapEntry(e.key.toString().split('.').last, e.value))),
      'sessionsByDifficulty': Map<String, int>.fromEntries(sessionsByDifficulty.entries.map((e) => MapEntry(e.key.toString().split('.').last, e.value))),
      'completedPlanIds': completedPlanIds,
      'achievements': achievements.map((e) => TrainingAchievementModel.fromDomain(e).toJson()).toList(),
      'updatedAt': updatedAt,
    };
  }
}

class TrainingAchievementModel {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final DateTime unlockedAt;
  final Map<String, dynamic> metadata;

  const TrainingAchievementModel({required this.id, required this.name, required this.description, required this.iconUrl, required this.unlockedAt, this.metadata = const {}});

  // Convert to domain entity
  TrainingAchievement toDomain() => TrainingAchievement(id: id, name: name, description: description, iconUrl: iconUrl, unlockedAt: unlockedAt, metadata: metadata);

  // Create from domain entity
  factory TrainingAchievementModel.fromDomain(TrainingAchievement achievement) => TrainingAchievementModel(
    id: achievement.id,
    name: achievement.name,
    description: achievement.description,
    iconUrl: achievement.iconUrl,
    unlockedAt: achievement.unlockedAt,
    metadata: achievement.metadata,
  );

  factory TrainingAchievementModel.fromJson(Map<String, dynamic> json) {
    return TrainingAchievementModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['iconUrl'],
      unlockedAt: (json['unlockedAt'] as Timestamp).toDate(),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'iconUrl': iconUrl, 'unlockedAt': Timestamp.fromDate(unlockedAt), 'metadata': metadata};
  }
}
