import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/domain/repositories/dream_journal_repository.dart';

class DreamJournalRepositoryImpl implements DreamJournalRepository {
  const DreamJournalRepositoryImpl({required FirebaseFirestore firestore, required String userId}) : _firestore = firestore, _userId = userId;

  final FirebaseFirestore _firestore;
  final String _userId;

  CollectionReference get _collection => _firestore.collection('users').doc(_userId).collection('dream_entries');

  @override
  Future<List<DreamEntry>> getAllDreamEntries() async {
    try {
      final querySnapshot = await _collection.orderBy('createdAt', descending: true).get();

      return querySnapshot.docs.map((doc) => DreamEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>})).toList();
    } catch (e) {
      throw Exception('Failed to get dream entries: $e');
    }
  }

  @override
  Future<DreamEntry?> getDreamEntryById(String id) async {
    try {
      final doc = await _collection.doc(id).get();

      if (!doc.exists) return null;

      return DreamEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>});
    } catch (e) {
      throw Exception('Failed to get dream entry: $e');
    }
  }

  @override
  Future<DreamEntry> saveDreamEntry(DreamEntry entry) async {
    try {
      final data = entry.toJson();
      data.remove('id'); // Remove id from data since it's the document ID

      if (entry.id.isNotEmpty) {
        await _collection.doc(entry.id).set(data);
      } else {
        final docRef = await _collection.add(data);
        return entry.copyWith(id: docRef.id);
      }

      return entry;
    } catch (e) {
      throw Exception('Failed to save dream entry: $e');
    }
  }

  @override
  Future<void> deleteDreamEntry(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete dream entry: $e');
    }
  }

  @override
  Future<List<DreamEntry>> getDreamEntriesByDateRange(DateTime start, DateTime end) async {
    try {
      final querySnapshot = await _collection
          .where('dreamDate', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('dreamDate', isLessThanOrEqualTo: Timestamp.fromDate(end))
          .orderBy('dreamDate', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => DreamEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>})).toList();
    } catch (e) {
      throw Exception('Failed to get dream entries by date range: $e');
    }
  }

  @override
  Future<List<DreamEntry>> searchDreamEntries(String query) async {
    try {
      // Note: Firestore doesn't have full-text search, so this is a basic implementation
      // For production, you might want to use Algolia or similar
      final querySnapshot = await _collection.orderBy('createdAt', descending: true).get();

      return querySnapshot.docs
          .map((doc) => DreamEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>}))
          .where((entry) => entry.content.toLowerCase().contains(query.toLowerCase()) || entry.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())))
          .toList();
    } catch (e) {
      throw Exception('Failed to search dream entries: $e');
    }
  }

  @override
  Future<void> syncWithCloud() async {
    // Implementation for offline sync would go here
    // For now, this is a no-op since we're directly using Firestore
  }
}
