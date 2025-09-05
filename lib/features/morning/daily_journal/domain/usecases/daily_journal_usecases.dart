import 'package:super_brain/features/morning/daily_journal/domain/entities/daily_entry.dart';
import 'package:super_brain/features/morning/daily_journal/domain/repositories/daily_journal_repository.dart';

class CreateDailyEntryUseCase {
  const CreateDailyEntryUseCase(this._repository);

  final DailyJournalRepository _repository;

  Future<DailyEntry> call({
    required String content,
    String? mood,
    List<String> gratitudeList = const [],
    List<String> goalsForToday = const [],
    String? reflection,
    DateTime? entryDate,
  }) async {
    final now = DateTime.now();
    final actualEntryDate = entryDate ?? DateTime(now.year, now.month, now.day);

    final entry = DailyEntry(
      id: _generateId(),
      content: content,
      mood: mood,
      gratitudeList: gratitudeList,
      goalsForToday: goalsForToday,
      reflection: reflection,
      entryDate: actualEntryDate,
      createdAt: now,
    );

    return await _repository.saveDailyEntry(entry);
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}

class GetDailyEntriesUseCase {
  const GetDailyEntriesUseCase(this._repository);

  final DailyJournalRepository _repository;

  Future<List<DailyEntry>> call() async {
    return await _repository.getAllDailyEntries();
  }
}

class GetTodaysDailyEntryUseCase {
  const GetTodaysDailyEntryUseCase(this._repository);

  final DailyJournalRepository _repository;

  Future<DailyEntry?> call() async {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return await _repository.getDailyEntryByDate(todayDate);
  }
}

class UpdateDailyEntryUseCase {
  const UpdateDailyEntryUseCase(this._repository);

  final DailyJournalRepository _repository;

  Future<DailyEntry> call(DailyEntry entry) async {
    final updatedEntry = entry.copyWith(updatedAt: DateTime.now());
    return await _repository.saveDailyEntry(updatedEntry);
  }
}

class DeleteDailyEntryUseCase {
  const DeleteDailyEntryUseCase(this._repository);

  final DailyJournalRepository _repository;

  Future<void> call(String id) async {
    await _repository.deleteDailyEntry(id);
  }
}

class SearchDailyEntriesUseCase {
  const SearchDailyEntriesUseCase(this._repository);

  final DailyJournalRepository _repository;

  Future<List<DailyEntry>> call(String query) async {
    return await _repository.searchDailyEntries(query);
  }
}

class GetJournalStreakUseCase {
  const GetJournalStreakUseCase(this._repository);

  final DailyJournalRepository _repository;

  Future<int> call() async {
    return await _repository.getJournalStreak();
  }
}
