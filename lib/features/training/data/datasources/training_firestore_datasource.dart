import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/training/data/models/training_models.dart';

abstract class TrainingFirestoreDataSource {
  Future<void> saveTrainingSession(TrainingSessionModel session);
  Future<void> updateTrainingSession(TrainingSessionModel session);
  Future<List<TrainingSessionModel>> getUserTrainingSessions(String userId, {int? limit});
  Future<TrainingSessionModel?> getTrainingSessionById(String sessionId, String userId);
  Stream<List<TrainingSessionModel>> watchUserTrainingSessions(String userId);

  Future<TrainingStatsModel?> getUserTrainingStats(String userId);
  Future<void> updateUserTrainingStats(TrainingStatsModel stats);
  Stream<TrainingStatsModel?> watchUserTrainingStats(String userId);
}

class TrainingFirestoreDataSourceImpl implements TrainingFirestoreDataSource {
  final FirebaseFirestore _firestore;

  TrainingFirestoreDataSourceImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<TrainingSessionModel> _sessionsCollection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('training_sessions')
      .withConverter<TrainingSessionModel>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data() ?? <String, dynamic>{};
          return TrainingSessionModel.fromJson({'id': snapshot.id, 'userId': userId, ...data});
        },
        toFirestore: (session, _) => session.toFirestore(),
      );

  DocumentReference<TrainingStatsModel> _statsDocument(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('training_stats')
      .doc('stats')
      .withConverter<TrainingStatsModel>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data() ?? <String, dynamic>{};
          return TrainingStatsModel.fromJson({'userId': userId, ...data});
        },
        toFirestore: (stats, _) => stats.toFirestore(),
      );

  @override
  Future<void> saveTrainingSession(TrainingSessionModel session) async {
    try {
      await _sessionsCollection(session.userId).doc(session.id).set(session);
    } catch (e) {
      throw TrainingFirestoreException('Failed to save training session: $e');
    }
  }

  @override
  Future<void> updateTrainingSession(TrainingSessionModel session) async {
    try {
      await _sessionsCollection(session.userId).doc(session.id).update(session.toFirestore());
    } catch (e) {
      throw TrainingFirestoreException('Failed to update training session: $e');
    }
  }

  @override
  Future<List<TrainingSessionModel>> getUserTrainingSessions(String userId, {int? limit}) async {
    try {
      Query<TrainingSessionModel> query = _sessionsCollection(userId).orderBy('startedAt', descending: true);

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw TrainingFirestoreException('Failed to get user training sessions: $e');
    }
  }

  @override
  Future<TrainingSessionModel?> getTrainingSessionById(String sessionId, String userId) async {
    try {
      final doc = await _sessionsCollection(userId).doc(sessionId).get();
      return doc.data();
    } catch (e) {
      throw TrainingFirestoreException('Failed to get training session: $e');
    }
  }

  @override
  Stream<List<TrainingSessionModel>> watchUserTrainingSessions(String userId) {
    return _sessionsCollection(userId).orderBy('startedAt', descending: true).limit(50).snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<TrainingStatsModel?> getUserTrainingStats(String userId) async {
    try {
      final doc = await _statsDocument(userId).get();
      if (!doc.exists) {
        // Create initial stats if they don't exist
        final initialStats = TrainingStatsModel(userId: userId, updatedAt: DateTime.now());
        await _statsDocument(userId).set(initialStats);
        return initialStats;
      }
      return doc.data();
    } catch (e) {
      throw TrainingFirestoreException('Failed to get user training stats: $e');
    }
  }

  @override
  Future<void> updateUserTrainingStats(TrainingStatsModel stats) async {
    try {
      await _statsDocument(stats.userId).set(stats, SetOptions(merge: true));
    } catch (e) {
      throw TrainingFirestoreException('Failed to update user training stats: $e');
    }
  }

  @override
  Stream<TrainingStatsModel?> watchUserTrainingStats(String userId) {
    return _statsDocument(userId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        // Create initial stats if they don't exist
        final initialStats = TrainingStatsModel(userId: userId, updatedAt: DateTime.now());
        // Don't await this, just fire and forget
        _statsDocument(userId).set(initialStats);
        return initialStats;
      }
      return snapshot.data();
    });
  }
}

class TrainingFirestoreException implements Exception {
  final String message;

  const TrainingFirestoreException(this.message);

  @override
  String toString() => 'TrainingFirestoreException: $message';
}
