import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/domain/repositories/dream_journal_repository.dart';

class CreateDreamEntryUseCase {
  const CreateDreamEntryUseCase(this._repository);

  final DreamJournalRepository _repository;

  Future<DreamEntry> call({
    required String content,
    String? mood,
    String? category,
    bool isLucid = false,
    bool isRecurring = false,
    List<String> tags = const [],
    DateTime? dreamDate,
  }) async {
    final now = DateTime.now();
    final entry = DreamEntry(
      id: _generateId(),
      content: content,
      mood: mood,
      category: category,
      isLucid: isLucid,
      isRecurring: isRecurring,
      tags: tags,
      dreamDate: dreamDate ?? now,
      createdAt: now,
    );

    return await _repository.saveDreamEntry(entry);
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}

class GetDreamEntriesUseCase {
  const GetDreamEntriesUseCase(this._repository);

  final DreamJournalRepository _repository;

  Future<List<DreamEntry>> call() async {
    return await _repository.getAllDreamEntries();
  }
}

class UpdateDreamEntryUseCase {
  const UpdateDreamEntryUseCase(this._repository);

  final DreamJournalRepository _repository;

  Future<DreamEntry> call(DreamEntry entry) async {
    final updatedEntry = entry.copyWith(updatedAt: DateTime.now());
    return await _repository.saveDreamEntry(updatedEntry);
  }
}

class DeleteDreamEntryUseCase {
  const DeleteDreamEntryUseCase(this._repository);

  final DreamJournalRepository _repository;

  Future<void> call(String id) async {
    await _repository.deleteDreamEntry(id);
  }
}

class SearchDreamEntriesUseCase {
  const SearchDreamEntriesUseCase(this._repository);

  final DreamJournalRepository _repository;

  Future<List<DreamEntry>> call(String query) async {
    return await _repository.searchDreamEntries(query);
  }
}
