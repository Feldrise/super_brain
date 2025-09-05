import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/morning/journal/data/repositories/dream_journal_repository_impl.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/domain/repositories/dream_journal_repository.dart';
import 'package:super_brain/features/morning/journal/domain/usecases/dream_journal_usecases.dart';

// Repository provider
final dreamJournalRepositoryProvider = Provider<DreamJournalRepository?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  return DreamJournalRepositoryImpl(firestore: FirebaseFirestore.instance, userId: user.uid);
});

// Use case providers
final createDreamEntryUseCaseProvider = Provider<CreateDreamEntryUseCase?>((ref) {
  final repository = ref.watch(dreamJournalRepositoryProvider);
  if (repository == null) return null;
  return CreateDreamEntryUseCase(repository);
});

final getDreamEntriesUseCaseProvider = Provider<GetDreamEntriesUseCase?>((ref) {
  final repository = ref.watch(dreamJournalRepositoryProvider);
  if (repository == null) return null;
  return GetDreamEntriesUseCase(repository);
});

final updateDreamEntryUseCaseProvider = Provider<UpdateDreamEntryUseCase?>((ref) {
  final repository = ref.watch(dreamJournalRepositoryProvider);
  if (repository == null) return null;
  return UpdateDreamEntryUseCase(repository);
});

final deleteDreamEntryUseCaseProvider = Provider<DeleteDreamEntryUseCase?>((ref) {
  final repository = ref.watch(dreamJournalRepositoryProvider);
  if (repository == null) return null;
  return DeleteDreamEntryUseCase(repository);
});

final searchDreamEntriesUseCaseProvider = Provider<SearchDreamEntriesUseCase?>((ref) {
  final repository = ref.watch(dreamJournalRepositoryProvider);
  if (repository == null) return null;
  return SearchDreamEntriesUseCase(repository);
});

// State providers
final dreamEntriesProvider = FutureProvider<List<DreamEntry>>((ref) async {
  final useCase = ref.read(getDreamEntriesUseCaseProvider);
  if (useCase == null) return [];
  return await useCase.call();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

// Filter providers for better organization
final selectedMoodFilterProvider = StateProvider<String?>((ref) => null);
final selectedCategoryFilterProvider = StateProvider<String?>((ref) => null);
final showLucidOnlyProvider = StateProvider<bool>((ref) => false);
final sortOrderProvider = StateProvider<DreamSortOrder>((ref) => DreamSortOrder.dateDesc);

enum DreamSortOrder {
  dateDesc('Plus récents'),
  dateAsc('Plus anciens'),
  contentLength('Plus longs'),
  lucidFirst('Lucides d\'abord');

  const DreamSortOrder(this.displayName);
  final String displayName;
}

final filteredDreamEntriesProvider = FutureProvider.autoDispose<List<DreamEntry>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final moodFilter = ref.watch(selectedMoodFilterProvider);
  final categoryFilter = ref.watch(selectedCategoryFilterProvider);
  final showLucidOnly = ref.watch(showLucidOnlyProvider);
  final sortOrder = ref.watch(sortOrderProvider);
  
  // Watch the base entries to ensure we refresh when dreams are added/updated/deleted
  final baseEntries = await ref.watch(dreamEntriesProvider.future);
  
  List<DreamEntry> entries = List.from(baseEntries);

  // Apply search filter
  if (query.isNotEmpty) {
    entries = entries.where((entry) {
      final queryLower = query.toLowerCase();
      return entry.content.toLowerCase().contains(queryLower) ||
             entry.tags.any((tag) => tag.toLowerCase().contains(queryLower));
    }).toList();
  }

  // Apply mood filter
  if (moodFilter != null) {
    entries = entries.where((entry) => entry.mood == moodFilter).toList();
  }

  // Apply category filter
  if (categoryFilter != null) {
    entries = entries.where((entry) => entry.category == categoryFilter).toList();
  }

  // Apply lucid filter
  if (showLucidOnly) {
    entries = entries.where((entry) => entry.isLucid).toList();
  }

  // Apply sorting
  switch (sortOrder) {
    case DreamSortOrder.dateDesc:
      entries.sort((a, b) => (b.dreamDate ?? b.createdAt).compareTo(a.dreamDate ?? a.createdAt));
      break;
    case DreamSortOrder.dateAsc:
      entries.sort((a, b) => (a.dreamDate ?? a.createdAt).compareTo(b.dreamDate ?? b.createdAt));
      break;
    case DreamSortOrder.contentLength:
      entries.sort((a, b) => b.content.length.compareTo(a.content.length));
      break;
    case DreamSortOrder.lucidFirst:
      entries.sort((a, b) {
        if (a.isLucid && !b.isLucid) return -1;
        if (!a.isLucid && b.isLucid) return 1;
        return (b.dreamDate ?? b.createdAt).compareTo(a.dreamDate ?? a.createdAt);
      });
      break;
  }

  return entries;
}); // Dream creation state

class DreamEntryFormState {
  const DreamEntryFormState({this.content = '', this.mood, this.category, this.isLucid = false, this.isRecurring = false, this.tags = const [], this.dreamDate, this.editingEntry});

  final String content;
  final String? mood;
  final String? category;
  final bool isLucid;
  final bool isRecurring;
  final List<String> tags;
  final DateTime? dreamDate;
  final DreamEntry? editingEntry; // Track the entry being edited

  DreamEntryFormState copyWith({
    String? content,
    String? mood,
    String? category,
    bool? isLucid,
    bool? isRecurring,
    List<String>? tags,
    DateTime? dreamDate,
    DreamEntry? editingEntry,
  }) {
    return DreamEntryFormState(
      content: content ?? this.content,
      mood: mood ?? this.mood,
      category: category ?? this.category,
      isLucid: isLucid ?? this.isLucid,
      isRecurring: isRecurring ?? this.isRecurring,
      tags: tags ?? this.tags,
      dreamDate: dreamDate ?? this.dreamDate,
      editingEntry: editingEntry ?? this.editingEntry,
    );
  }
}

final dreamEntryFormProvider = StateNotifierProvider<DreamEntryFormNotifier, DreamEntryFormState>((ref) {
  return DreamEntryFormNotifier(ref);
});

class DreamEntryFormNotifier extends StateNotifier<DreamEntryFormState> {
  DreamEntryFormNotifier(this.ref) : super(const DreamEntryFormState());

  final Ref ref;

  void updateContent(String content) {
    state = state.copyWith(content: content);
  }

  void updateMood(String? mood) {
    state = state.copyWith(mood: mood);
  }

  void updateCategory(String? category) {
    state = state.copyWith(category: category);
  }

  void toggleLucid() {
    state = state.copyWith(isLucid: !state.isLucid);
  }

  void toggleRecurring() {
    state = state.copyWith(isRecurring: !state.isRecurring);
  }

  void updateTags(List<String> tags) {
    state = state.copyWith(tags: tags);
  }

  void updateDreamDate(DateTime? date) {
    state = state.copyWith(dreamDate: date);
  }

  void setEditingEntry(DreamEntry? entry) {
    state = state.copyWith(editingEntry: entry);
  }

  Future<bool> saveDreamEntry() async {
    try {
      final isEditing = state.editingEntry != null;

      if (isEditing) {
        // Update existing dream
        final updateUseCase = ref.read(updateDreamEntryUseCaseProvider);
        if (updateUseCase == null) return false;

        final updatedEntry = state.editingEntry!.copyWith(
          content: state.content,
          mood: state.mood,
          category: state.category,
          isLucid: state.isLucid,
          isRecurring: state.isRecurring,
          tags: state.tags,
          dreamDate: state.dreamDate,
          updatedAt: DateTime.now(),
        );

        await updateUseCase.call(updatedEntry);
      } else {
        // Create new dream
        final createUseCase = ref.read(createDreamEntryUseCaseProvider);
        if (createUseCase == null) return false;

        await createUseCase.call(
          content: state.content,
          mood: state.mood,
          category: state.category,
          isLucid: state.isLucid,
          isRecurring: state.isRecurring,
          tags: state.tags,
          dreamDate: state.dreamDate,
        );
      }

      // Refresh the dream entries list
      ref.invalidate(dreamEntriesProvider);
      ref.invalidate(filteredDreamEntriesProvider);

      // Reset the form
      state = const DreamEntryFormState();

      return true;
    } catch (e) {
      return false;
    }
  }

  void resetForm() {
    state = const DreamEntryFormState();
  }
}
