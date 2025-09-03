import 'package:super_brain/features/training/domain/entities/training_entities.dart';
import 'package:super_brain/features/training/domain/repositories/training_repository.dart';

class GetTrainingPlansUseCase {
  final TrainingRepository _repository;

  GetTrainingPlansUseCase(this._repository);

  Future<List<TrainingPlan>> call({TrainingCategory? category, TrainingDifficulty? difficulty}) async {
    if (category != null) {
      return await _repository.getTrainingPlansByCategory(category);
    }
    if (difficulty != null) {
      return await _repository.getTrainingPlansByDifficulty(difficulty);
    }
    return await _repository.getTrainingPlans();
  }
}

class StartTrainingSessionUseCase {
  final TrainingRepository _repository;

  StartTrainingSessionUseCase(this._repository);

  Future<TrainingSession> call(String userId, TrainingPlan plan) async {
    final session = TrainingSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      planId: plan.id,
      planName: plan.name,
      category: plan.category,
      difficulty: plan.difficulty,
      startedAt: DateTime.now(),
      plannedDuration: plan.estimatedDuration * 60, // Convert minutes to seconds
      exerciseResults: [],
      isCompleted: false,
    );

    await _repository.saveTrainingSession(session);
    return session;
  }
}

class CompleteTrainingSessionUseCase {
  final TrainingRepository _repository;

  CompleteTrainingSessionUseCase(this._repository);

  Future<void> call(TrainingSession session, List<ExerciseResult> exerciseResults, int? userRating, String? notes) async {
    final completedSession = session.copyWith(
      completedAt: DateTime.now(),
      actualDuration: DateTime.now().difference(session.startedAt).inSeconds,
      exerciseResults: exerciseResults,
      isCompleted: true,
      userRating: userRating,
      notes: notes,
    );

    await _repository.updateTrainingSession(completedSession);
    await _updateUserStats(session.userId, completedSession);
  }

  Future<void> _updateUserStats(String userId, TrainingSession session) async {
    final stats = await _repository.getUserTrainingStats(userId) ?? TrainingStats(userId: userId);

    final today = DateTime.now();
    final lastSessionDate = stats.lastSessionDate;

    // Calculate streak
    int newStreak = stats.currentStreak;
    if (lastSessionDate == null) {
      newStreak = 1;
    } else {
      final daysSinceLastSession = today.difference(lastSessionDate).inDays;
      if (daysSinceLastSession == 1) {
        newStreak = stats.currentStreak + 1;
      } else if (daysSinceLastSession > 1) {
        newStreak = 1; // Reset streak
      }
      // If same day, keep current streak
    }

    // Update category counts
    final categoryStats = Map<TrainingCategory, int>.from(stats.sessionsByCategory);
    categoryStats[session.category] = (categoryStats[session.category] ?? 0) + 1;

    // Update difficulty counts
    final difficultyStats = Map<TrainingDifficulty, int>.from(stats.sessionsByDifficulty);
    difficultyStats[session.difficulty] = (difficultyStats[session.difficulty] ?? 0) + 1;

    final updatedStats = stats.copyWith(
      totalSessions: stats.totalSessions + 1,
      totalMinutes: stats.totalMinutes + (session.actualDuration ?? 0) ~/ 60,
      currentStreak: newStreak,
      longestStreak: newStreak > stats.longestStreak ? newStreak : stats.longestStreak,
      lastSessionDate: today,
      sessionsByCategory: categoryStats,
      sessionsByDifficulty: difficultyStats,
      updatedAt: DateTime.now(),
    );

    await _repository.updateUserTrainingStats(updatedStats);
  }
}

class GetUserTrainingStatsUseCase {
  final TrainingRepository _repository;

  GetUserTrainingStatsUseCase(this._repository);

  Future<TrainingStats?> call(String userId) async {
    return await _repository.getUserTrainingStats(userId);
  }

  Stream<TrainingStats?> watch(String userId) {
    return _repository.watchUserTrainingStats(userId);
  }
}

class GetUserTrainingHistoryUseCase {
  final TrainingRepository _repository;

  GetUserTrainingHistoryUseCase(this._repository);

  Future<List<TrainingSession>> call(String userId, {int? limit}) async {
    return await _repository.getUserTrainingSessions(userId, limit: limit);
  }

  Stream<List<TrainingSession>> watch(String userId) {
    return _repository.watchUserTrainingSessions(userId);
  }
}

class CheckAndUnlockAchievementsUseCase {
  final TrainingRepository _repository;

  CheckAndUnlockAchievementsUseCase(this._repository);

  Future<List<TrainingAchievement>> call(String userId, TrainingStats stats) async {
    final newAchievements = <TrainingAchievement>[];
    final existingAchievements = await _repository.getUserAchievements(userId);
    final existingIds = existingAchievements.map((a) => a.id).toSet();

    // Check for various achievements
    final achievementsToCheck = [
      _checkFirstSessionAchievement(stats),
      _checkStreakAchievements(stats),
      _checkSessionCountAchievements(stats),
      _checkCategoryVarietyAchievements(stats),
      _checkTimeInvestedAchievements(stats),
    ].expand((list) => list).where((achievement) => !existingIds.contains(achievement.id));

    for (final achievement in achievementsToCheck) {
      await _repository.unlockAchievement(userId, achievement);
      newAchievements.add(achievement);
    }

    return newAchievements;
  }

  List<TrainingAchievement> _checkFirstSessionAchievement(TrainingStats stats) {
    if (stats.totalSessions >= 1) {
      return [
        TrainingAchievement(
          id: 'first_session',
          name: 'Getting Started',
          description: 'Complete your first training session',
          iconUrl: 'assets/achievements/first_session.png',
          unlockedAt: DateTime.now(),
        ),
      ];
    }
    return [];
  }

  List<TrainingAchievement> _checkStreakAchievements(TrainingStats stats) {
    final achievements = <TrainingAchievement>[];

    if (stats.currentStreak >= 3) {
      achievements.add(
        TrainingAchievement(
          id: 'streak_3',
          name: 'Momentum Builder',
          description: 'Complete 3 training sessions in a row',
          iconUrl: 'assets/achievements/streak_3.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    if (stats.currentStreak >= 7) {
      achievements.add(
        TrainingAchievement(
          id: 'streak_7',
          name: 'Week Warrior',
          description: 'Complete 7 training sessions in a row',
          iconUrl: 'assets/achievements/streak_7.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    if (stats.currentStreak >= 30) {
      achievements.add(
        TrainingAchievement(
          id: 'streak_30',
          name: 'Monthly Master',
          description: 'Complete 30 training sessions in a row',
          iconUrl: 'assets/achievements/streak_30.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    return achievements;
  }

  List<TrainingAchievement> _checkSessionCountAchievements(TrainingStats stats) {
    final achievements = <TrainingAchievement>[];

    if (stats.totalSessions >= 10) {
      achievements.add(
        TrainingAchievement(
          id: 'sessions_10',
          name: 'Dedicated Trainee',
          description: 'Complete 10 training sessions',
          iconUrl: 'assets/achievements/sessions_10.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    if (stats.totalSessions >= 50) {
      achievements.add(
        TrainingAchievement(
          id: 'sessions_50',
          name: 'Training Enthusiast',
          description: 'Complete 50 training sessions',
          iconUrl: 'assets/achievements/sessions_50.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    if (stats.totalSessions >= 100) {
      achievements.add(
        TrainingAchievement(
          id: 'sessions_100',
          name: 'Fitness Champion',
          description: 'Complete 100 training sessions',
          iconUrl: 'assets/achievements/sessions_100.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    return achievements;
  }

  List<TrainingAchievement> _checkCategoryVarietyAchievements(TrainingStats stats) {
    final achievements = <TrainingAchievement>[];
    final categoriesWithSessions = stats.sessionsByCategory.keys.length;

    if (categoriesWithSessions >= 2) {
      achievements.add(
        TrainingAchievement(
          id: 'variety_2',
          name: 'Well Rounded',
          description: 'Complete sessions in 2 different categories',
          iconUrl: 'assets/achievements/variety_2.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    if (categoriesWithSessions >= 3) {
      achievements.add(
        TrainingAchievement(
          id: 'variety_all',
          name: 'Master of All',
          description: 'Complete sessions in all training categories',
          iconUrl: 'assets/achievements/variety_all.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    return achievements;
  }

  List<TrainingAchievement> _checkTimeInvestedAchievements(TrainingStats stats) {
    final achievements = <TrainingAchievement>[];

    if (stats.totalMinutes >= 60) {
      achievements.add(
        TrainingAchievement(id: 'time_60', name: 'Hour Power', description: 'Complete 1 hour of training', iconUrl: 'assets/achievements/time_60.png', unlockedAt: DateTime.now()),
      );
    }

    if (stats.totalMinutes >= 300) {
      achievements.add(
        TrainingAchievement(
          id: 'time_300',
          name: 'Time Invested',
          description: 'Complete 5 hours of training',
          iconUrl: 'assets/achievements/time_300.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    if (stats.totalMinutes >= 600) {
      achievements.add(
        TrainingAchievement(
          id: 'time_600',
          name: 'Dedication Unleashed',
          description: 'Complete 10 hours of training',
          iconUrl: 'assets/achievements/time_600.png',
          unlockedAt: DateTime.now(),
        ),
      );
    }

    return achievements;
  }
}
