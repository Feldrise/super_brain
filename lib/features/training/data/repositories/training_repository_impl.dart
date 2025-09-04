import 'package:super_brain/features/training/domain/entities/training_entities.dart';
import 'package:super_brain/features/training/domain/repositories/training_repository.dart';
import 'package:super_brain/features/training/data/datasources/training_plans_datasource.dart';
import 'package:super_brain/features/training/data/datasources/training_firestore_datasource.dart';
import 'package:super_brain/features/training/data/models/training_models.dart';

class TrainingRepositoryImpl implements TrainingRepository {
  final TrainingPlansDataSource _plansDataSource;
  final TrainingFirestoreDataSource _firestoreDataSource;

  TrainingRepositoryImpl({required TrainingPlansDataSource plansDataSource, required TrainingFirestoreDataSource firestoreDataSource})
    : _plansDataSource = plansDataSource,
      _firestoreDataSource = firestoreDataSource;

  @override
  Future<List<TrainingPlan>> getTrainingPlans() async {
    return await _plansDataSource.getTrainingPlans();
  }

  @override
  Future<List<TrainingPlan>> getTrainingPlansByCategory(TrainingCategory category) async {
    return await _plansDataSource.getTrainingPlansByCategory(category.toString().split('.').last);
  }

  @override
  Future<List<TrainingPlan>> getTrainingPlansByDifficulty(TrainingDifficulty difficulty) async {
    return await _plansDataSource.getTrainingPlansByDifficulty(difficulty.toString().split('.').last);
  }

  @override
  Future<TrainingPlan?> getTrainingPlanById(String planId) async {
    return await _plansDataSource.getTrainingPlanById(planId);
  }

  @override
  Future<void> saveTrainingSession(TrainingSession session) async {
    final model = TrainingSessionModel.fromDomain(session);
    await _firestoreDataSource.saveTrainingSession(model);
  }

  @override
  Future<void> updateTrainingSession(TrainingSession session) async {
    final model = TrainingSessionModel.fromDomain(session);
    await _firestoreDataSource.updateTrainingSession(model);
  }

  @override
  Future<List<TrainingSession>> getUserTrainingSessions(String userId, {int? limit}) async {
    final models = await _firestoreDataSource.getUserTrainingSessions(userId, limit: limit);
    return models.map((model) => model.toDomain()).toList();
  }

  @override
  Future<TrainingSession?> getTrainingSessionById(String sessionId) async {
    // Note: This would need userId context - you might want to modify the interface
    throw UnimplementedError('Getting session by ID requires user context');
  }

  @override
  Stream<List<TrainingSession>> watchUserTrainingSessions(String userId) {
    return _firestoreDataSource.watchUserTrainingSessions(userId).map((models) => models.map((model) => model.toDomain()).toList());
  }

  @override
  Future<TrainingStats?> getUserTrainingStats(String userId) async {
    final model = await _firestoreDataSource.getUserTrainingStats(userId);
    return model?.toDomain();
  }

  @override
  Future<void> updateUserTrainingStats(TrainingStats stats) async {
    final model = TrainingStatsModel.fromDomain(stats);
    await _firestoreDataSource.updateUserTrainingStats(model);
  }

  @override
  Stream<TrainingStats?> watchUserTrainingStats(String userId) {
    return _firestoreDataSource.watchUserTrainingStats(userId).map((model) => model?.toDomain());
  }

  @override
  Future<List<TrainingAchievement>> getUserAchievements(String userId) async {
    final stats = await getUserTrainingStats(userId);
    return stats?.achievements ?? [];
  }

  @override
  Future<void> unlockAchievement(String userId, TrainingAchievement achievement) async {
    final currentStats = await getUserTrainingStats(userId);
    if (currentStats == null) return;

    final updatedAchievements = [...currentStats.achievements, achievement];
    final updatedStats = currentStats.copyWith(achievements: updatedAchievements, updatedAt: DateTime.now());

    await updateUserTrainingStats(updatedStats);
  }

  @override
  Future<int> getUserStreakCount(String userId) async {
    final stats = await getUserTrainingStats(userId);
    return stats?.currentStreak ?? 0;
  }

  @override
  Future<DateTime?> getLastTrainingDate(String userId) async {
    final stats = await getUserTrainingStats(userId);
    return stats?.lastSessionDate;
  }

  @override
  Future<Map<TrainingCategory, int>> getSessionCountByCategory(String userId) async {
    final stats = await getUserTrainingStats(userId);
    return stats?.sessionsByCategory ?? {};
  }
}
