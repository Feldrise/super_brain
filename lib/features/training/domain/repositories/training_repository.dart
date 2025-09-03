import 'package:super_brain/features/training/domain/entities/training_entities.dart';

abstract class TrainingRepository {
  // Training Plans
  Future<List<TrainingPlan>> getTrainingPlans();
  Future<List<TrainingPlan>> getTrainingPlansByCategory(TrainingCategory category);
  Future<List<TrainingPlan>> getTrainingPlansByDifficulty(TrainingDifficulty difficulty);
  Future<TrainingPlan?> getTrainingPlanById(String planId);

  // Training Sessions
  Future<void> saveTrainingSession(TrainingSession session);
  Future<void> updateTrainingSession(TrainingSession session);
  Future<List<TrainingSession>> getUserTrainingSessions(String userId, {int? limit});
  Future<TrainingSession?> getTrainingSessionById(String sessionId);
  Stream<List<TrainingSession>> watchUserTrainingSessions(String userId);

  // Training Stats
  Future<TrainingStats?> getUserTrainingStats(String userId);
  Future<void> updateUserTrainingStats(TrainingStats stats);
  Stream<TrainingStats?> watchUserTrainingStats(String userId);

  // Achievements
  Future<List<TrainingAchievement>> getUserAchievements(String userId);
  Future<void> unlockAchievement(String userId, TrainingAchievement achievement);

  // Quick stats
  Future<int> getUserStreakCount(String userId);
  Future<DateTime?> getLastTrainingDate(String userId);
  Future<Map<TrainingCategory, int>> getSessionCountByCategory(String userId);
}
