import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/morning/daily_journal/data/repositories/daily_journal_repository_impl.dart';
import 'package:super_brain/features/morning/daily_journal/domain/entities/daily_entry.dart';
import 'package:super_brain/features/morning/daily_journal/domain/repositories/daily_journal_repository.dart';
import 'package:super_brain/features/morning/daily_journal/domain/usecases/daily_journal_usecases.dart';

// Repository provider
final dailyJournalRepositoryProvider = Provider<DailyJournalRepository?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  return DailyJournalRepositoryImpl(firestore: FirebaseFirestore.instance, userId: user.uid);
});

// Use case providers
final createDailyEntryUseCaseProvider = Provider<CreateDailyEntryUseCase?>((ref) {
  final repository = ref.watch(dailyJournalRepositoryProvider);
  if (repository == null) return null;
  return CreateDailyEntryUseCase(repository);
});

final getDailyEntriesUseCaseProvider = Provider<GetDailyEntriesUseCase?>((ref) {
  final repository = ref.watch(dailyJournalRepositoryProvider);
  if (repository == null) return null;
  return GetDailyEntriesUseCase(repository);
});

final getTodaysDailyEntryUseCaseProvider = Provider<GetTodaysDailyEntryUseCase?>((ref) {
  final repository = ref.watch(dailyJournalRepositoryProvider);
  if (repository == null) return null;
  return GetTodaysDailyEntryUseCase(repository);
});

final updateDailyEntryUseCaseProvider = Provider<UpdateDailyEntryUseCase?>((ref) {
  final repository = ref.watch(dailyJournalRepositoryProvider);
  if (repository == null) return null;
  return UpdateDailyEntryUseCase(repository);
});

final deleteDailyEntryUseCaseProvider = Provider<DeleteDailyEntryUseCase?>((ref) {
  final repository = ref.watch(dailyJournalRepositoryProvider);
  if (repository == null) return null;
  return DeleteDailyEntryUseCase(repository);
});

final searchDailyEntriesUseCaseProvider = Provider<SearchDailyEntriesUseCase?>((ref) {
  final repository = ref.watch(dailyJournalRepositoryProvider);
  if (repository == null) return null;
  return SearchDailyEntriesUseCase(repository);
});

final getJournalStreakUseCaseProvider = Provider<GetJournalStreakUseCase?>((ref) {
  final repository = ref.watch(dailyJournalRepositoryProvider);
  if (repository == null) return null;
  return GetJournalStreakUseCase(repository);
});

// Data providers
final dailyEntriesProvider = FutureProvider<List<DailyEntry>>((ref) async {
  final useCase = ref.read(getDailyEntriesUseCaseProvider);
  if (useCase == null) return [];
  return await useCase.call();
});

final todaysDailyEntryProvider = FutureProvider<DailyEntry?>((ref) async {
  final useCase = ref.read(getTodaysDailyEntryUseCaseProvider);
  if (useCase == null) return null;
  return await useCase.call();
});

final journalStreakProvider = FutureProvider<int>((ref) async {
  final useCase = ref.read(getJournalStreakUseCaseProvider);
  if (useCase == null) return 0;
  return await useCase.call();
});

// Search and filter providers
final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredDailyEntriesProvider = FutureProvider<List<DailyEntry>>((ref) async {
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) {
    final baseEntries = await ref.watch(dailyEntriesProvider.future);
    return baseEntries;
  }

  final searchUseCase = ref.read(searchDailyEntriesUseCaseProvider);
  if (searchUseCase == null) return [];

  return await searchUseCase.call(query);
});

// Daily entry form state
class DailyEntryFormState {
  const DailyEntryFormState({this.content = '', this.mood, this.gratitudeList = const [], this.goalsForToday = const [], this.reflection = '', this.entryDate, this.editingEntry});

  final String content;
  final String? mood;
  final List<String> gratitudeList;
  final List<String> goalsForToday;
  final String reflection;
  final DateTime? entryDate;
  final DailyEntry? editingEntry; // Track the entry being edited

  DailyEntryFormState copyWith({
    String? content,
    String? mood,
    List<String>? gratitudeList,
    List<String>? goalsForToday,
    String? reflection,
    DateTime? entryDate,
    DailyEntry? editingEntry,
  }) {
    return DailyEntryFormState(
      content: content ?? this.content,
      mood: mood ?? this.mood,
      gratitudeList: gratitudeList ?? this.gratitudeList,
      goalsForToday: goalsForToday ?? this.goalsForToday,
      reflection: reflection ?? this.reflection,
      entryDate: entryDate ?? this.entryDate,
      editingEntry: editingEntry ?? this.editingEntry,
    );
  }
}

class DailyEntryFormNotifier extends StateNotifier<DailyEntryFormState> {
  DailyEntryFormNotifier(this.ref) : super(const DailyEntryFormState());

  final Ref ref;

  void updateContent(String content) {
    state = state.copyWith(content: content);
  }

  void updateMood(String? mood) {
    state = state.copyWith(mood: mood);
  }

  void updateGratitudeList(List<String> gratitudeList) {
    state = state.copyWith(gratitudeList: gratitudeList);
  }

  void updateGoalsForToday(List<String> goalsForToday) {
    state = state.copyWith(goalsForToday: goalsForToday);
  }

  void updateReflection(String reflection) {
    state = state.copyWith(reflection: reflection);
  }

  void updateEntryDate(DateTime? date) {
    state = state.copyWith(entryDate: date);
  }

  void setEditingEntry(DailyEntry? entry) {
    if (entry != null) {
      state = DailyEntryFormState(
        content: entry.content,
        mood: entry.mood,
        gratitudeList: List.from(entry.gratitudeList),
        goalsForToday: List.from(entry.goalsForToday),
        reflection: entry.reflection ?? '',
        entryDate: entry.entryDate,
        editingEntry: entry,
      );
    } else {
      state = const DailyEntryFormState();
    }
  }

  Future<bool> saveDailyEntry() async {
    try {
      final isEditing = state.editingEntry != null;

      if (isEditing) {
        // Update existing entry
        final updateUseCase = ref.read(updateDailyEntryUseCaseProvider);
        if (updateUseCase == null) return false;

        final updatedEntry = state.editingEntry!.copyWith(
          content: state.content,
          mood: state.mood,
          gratitudeList: state.gratitudeList,
          goalsForToday: state.goalsForToday,
          reflection: state.reflection.isEmpty ? null : state.reflection,
          entryDate: state.entryDate ?? state.editingEntry!.entryDate,
          updatedAt: DateTime.now(),
        );

        await updateUseCase.call(updatedEntry);
      } else {
        // Create new entry
        final createUseCase = ref.read(createDailyEntryUseCaseProvider);
        if (createUseCase == null) return false;

        await createUseCase.call(
          content: state.content,
          mood: state.mood,
          gratitudeList: state.gratitudeList,
          goalsForToday: state.goalsForToday,
          reflection: state.reflection.isEmpty ? null : state.reflection,
          entryDate: state.entryDate,
        );
      }

      // Refresh the entries list
      ref.invalidate(dailyEntriesProvider);
      ref.invalidate(todaysDailyEntryProvider);
      ref.invalidate(filteredDailyEntriesProvider);
      ref.invalidate(journalStreakProvider);

      // Reset the form
      state = const DailyEntryFormState();

      return true;
    } catch (e) {
      return false;
    }
  }

  void resetForm() {
    state = const DailyEntryFormState();
  }
}

final dailyEntryFormProvider = StateNotifierProvider<DailyEntryFormNotifier, DailyEntryFormState>((ref) {
  return DailyEntryFormNotifier(ref);
});
