import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/reminder/data/models/summary_models.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/domain/repositories/summary_repository.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final FirebaseFirestore _firestore;

  SummaryRepositoryImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<SummaryModel> _globalSummariesCollection() {
    return _firestore
        .collection('global_summaries')
        .withConverter<SummaryModel>(fromFirestore: (snapshot, _) => SummaryModel.fromFirestore(snapshot), toFirestore: (summary, _) => summary.toFirestore());
  }

  @override
  Stream<List<Summary>> watchGlobalSummaries() {
    try {
      return _globalSummariesCollection()
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()).toList())
          .handleError((error) {
            print('Error watching global summaries: $error');
            return <Summary>[];
          });
    } catch (e) {
      print('Error in watchGlobalSummaries: $e');
      return Stream.value(<Summary>[]);
    }
  }

  @override
  Future<List<Summary>> getGlobalSummaries({int? limit}) async {
    Query<SummaryModel> query = _globalSummariesCollection().where('isActive', isEqualTo: true).orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data().toDomain()).toList();
  }

  @override
  Future<Summary?> getGlobalSummaryById(String id) async {
    try {
      final doc = await _globalSummariesCollection().doc(id).get();
      return doc.data()?.toDomain();
    } catch (e) {
      return null;
    }
  }
}
