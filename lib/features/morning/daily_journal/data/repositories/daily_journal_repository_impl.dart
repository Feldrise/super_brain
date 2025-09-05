import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/morning/daily_journal/domain/entities/daily_entry.dart';
import 'package:super_brain/features/morning/daily_journal/domain/repositories/daily_journal_repository.dart';

class DailyJournalRepositoryImpl implements DailyJournalRepository {
  const DailyJournalRepositoryImpl({required FirebaseFirestore firestore, required String userId}) : _firestore = firestore, _userId = userId;

  final FirebaseFirestore _firestore;
  final String _userId;

  CollectionReference get _collection => _firestore.collection('users').doc(_userId).collection('daily_entries');

  @override
  Future<List<DailyEntry>> getAllDailyEntries() async {
    try {
      final querySnapshot = await _collection.orderBy('entryDate', descending: true).get();

      return querySnapshot.docs.map((doc) => DailyEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>})).toList();
    } catch (e) {
      throw Exception('Failed to get daily entries: $e');
    }
  }

  @override
  Future<DailyEntry?> getDailyEntryById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return null;

      return DailyEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>});
    } catch (e) {
      throw Exception('Failed to get daily entry: $e');
    }
  }

  @override
  Future<DailyEntry?> getDailyEntryByDate(DateTime date) async {
    try {
      // Query for entries on the specific date
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final querySnapshot = await _collection
          .where('entryDate', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('entryDate', isLessThanOrEqualTo: endOfDay.toIso8601String())
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return null;

      final doc = querySnapshot.docs.first;
      return DailyEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>});
    } catch (e) {
      throw Exception('Failed to get daily entry by date: $e');
    }
  }

  @override
  Future<DailyEntry> saveDailyEntry(DailyEntry entry) async {
    try {
      final data = entry.toJson();
      data.remove('id'); // Remove id from data to be saved

      // Convert DateTime objects to ISO8601 strings for Firestore
      data['entryDate'] = entry.entryDate.toIso8601String();
      data['createdAt'] = entry.createdAt.toIso8601String();
      if (entry.updatedAt != null) {
        data['updatedAt'] = entry.updatedAt!.toIso8601String();
      }

      if (entry.id.isEmpty || !await _entryExists(entry.id)) {
        // Create new entry
        final docRef = await _collection.add(data);
        return entry.copyWith(id: docRef.id, isSynced: true);
      } else {
        // Update existing entry
        await _collection.doc(entry.id).update(data);
        return entry.copyWith(isSynced: true);
      }
    } catch (e) {
      throw Exception('Failed to save daily entry: $e');
    }
  }

  @override
  Future<void> deleteDailyEntry(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete daily entry: $e');
    }
  }

  @override
  Future<List<DailyEntry>> getDailyEntriesByDateRange(DateTime start, DateTime end) async {
    try {
      final querySnapshot = await _collection
          .where('entryDate', isGreaterThanOrEqualTo: start.toIso8601String())
          .where('entryDate', isLessThanOrEqualTo: end.toIso8601String())
          .orderBy('entryDate', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => DailyEntry.fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>})).toList();
    } catch (e) {
      throw Exception('Failed to get daily entries by date range: $e');
    }
  }

  @override
  Future<List<DailyEntry>> searchDailyEntries(String query) async {
    try {
      final allEntries = await getAllDailyEntries();
      final queryLower = query.toLowerCase();

      return allEntries.where((entry) {
        return entry.content.toLowerCase().contains(queryLower) ||
            (entry.reflection?.toLowerCase().contains(queryLower) ?? false) ||
            entry.gratitudeList.any((item) => item.toLowerCase().contains(queryLower)) ||
            entry.goalsForToday.any((goal) => goal.toLowerCase().contains(queryLower));
      }).toList();
    } catch (e) {
      throw Exception('Failed to search daily entries: $e');
    }
  }

  @override
  Future<void> syncWithCloud() async {
    // Already using Firestore, so sync is automatic
    // This method can be used for future offline/sync logic
  }

  @override
  Future<int> getJournalStreak() async {
    try {
      final entries = await getAllDailyEntries();
      if (entries.isEmpty) return 0;

      // Sort entries by date (most recent first)
      entries.sort((a, b) => b.entryDate.compareTo(a.entryDate));

      int streak = 0;
      DateTime today = DateTime.now();
      DateTime currentDate = DateTime(today.year, today.month, today.day);

      for (final entry in entries) {
        final entryDate = DateTime(entry.entryDate.year, entry.entryDate.month, entry.entryDate.day);

        if (entryDate == currentDate) {
          streak++;
          currentDate = currentDate.subtract(const Duration(days: 1));
        } else if (entryDate == currentDate.subtract(const Duration(days: 1))) {
          // Allow for today not having an entry yet if it's still today
          if (streak == 0 && DateTime(today.year, today.month, today.day) == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
            currentDate = currentDate.subtract(const Duration(days: 1));
            if (entryDate == currentDate) {
              streak++;
              currentDate = currentDate.subtract(const Duration(days: 1));
            } else {
              break;
            }
          } else {
            break;
          }
        } else {
          break;
        }
      }

      return streak;
    } catch (e) {
      throw Exception('Failed to get journal streak: $e');
    }
  }

  Future<bool> _entryExists(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }
}
