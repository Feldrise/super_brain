import 'package:super_brain/features/morning/daily_journal/domain/entities/daily_entry.dart';

abstract class DailyJournalRepository {
  Future<List<DailyEntry>> getAllDailyEntries();
  Future<DailyEntry?> getDailyEntryById(String id);
  Future<DailyEntry?> getDailyEntryByDate(DateTime date);
  Future<DailyEntry> saveDailyEntry(DailyEntry entry);
  Future<void> deleteDailyEntry(String id);
  Future<List<DailyEntry>> getDailyEntriesByDateRange(DateTime start, DateTime end);
  Future<List<DailyEntry>> searchDailyEntries(String query);
  Future<void> syncWithCloud();
  Future<int> getJournalStreak(); // Count consecutive days with entries
}
