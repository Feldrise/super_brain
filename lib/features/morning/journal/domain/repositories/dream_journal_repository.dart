import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';

abstract class DreamJournalRepository {
  Future<List<DreamEntry>> getAllDreamEntries();
  Future<DreamEntry?> getDreamEntryById(String id);
  Future<DreamEntry> saveDreamEntry(DreamEntry entry);
  Future<void> deleteDreamEntry(String id);
  Future<List<DreamEntry>> getDreamEntriesByDateRange(DateTime start, DateTime end);
  Future<List<DreamEntry>> searchDreamEntries(String query);
  Future<void> syncWithCloud();
}
