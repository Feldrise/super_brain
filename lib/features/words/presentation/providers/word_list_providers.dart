import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/words/data/repositories/word_list_repository_impl.dart';
import 'package:super_brain/features/words/domain/entities/word_list.dart';
import 'package:super_brain/features/words/domain/repositories/word_list_repository.dart';
import 'package:super_brain/features/words/domain/usecases/word_list_usecases.dart';

// Repository provider
final wordListRepositoryProvider = Provider<WordListRepository>((ref) {
  return WordListRepositoryImpl();
});

// Use cases providers
final studyWordListUseCaseProvider = Provider<StudyWordListUseCase>((ref) {
  return StudyWordListUseCase(ref.watch(wordListRepositoryProvider));
});

final createWordListUseCaseProvider = Provider<CreateWordListUseCase>((ref) {
  return CreateWordListUseCase(ref.watch(wordListRepositoryProvider));
});

final getDailyWordListsUseCaseProvider = Provider<GetDailyWordListsUseCase>((ref) {
  return GetDailyWordListsUseCase(ref.watch(wordListRepositoryProvider));
});

final getUserWordListsUseCaseProvider = Provider<GetUserWordListsUseCase>((ref) {
  return GetUserWordListsUseCase(ref.watch(wordListRepositoryProvider));
});

final getDueWordListsUseCaseProvider = Provider<GetDueWordListsUseCase>((ref) {
  return GetDueWordListsUseCase(ref.watch(wordListRepositoryProvider));
});

// Word lists stream providers
final dailyWordListsProvider = StreamProvider<List<WordList>>((ref) {
  print('📚 dailyWordListsProvider: Starting to fetch daily word lists');
  final useCase = ref.watch(getDailyWordListsUseCaseProvider);
  return useCase()
      .map((lists) {
        print('📚 dailyWordListsProvider: Received ${lists.length} daily word lists');
        return lists;
      })
      .handleError((error) {
        print('❌ Error in dailyWordListsProvider: $error');
      });
});

final userWordListsProvider = StreamProvider<List<WordList>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();

  final useCase = ref.watch(getUserWordListsUseCaseProvider);
  return useCase(user.uid).handleError((error) {
    print('Error in userWordListsProvider: $error');
  });
});

final dueWordListsProvider = StreamProvider<List<WordList>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();

  final useCase = ref.watch(getDueWordListsUseCaseProvider);
  return useCase(user.uid).handleError((error) {
    print('Error in dueWordListsProvider: $error');
  });
});

// Restored Firebase provider with proper error handling
final allWordListsProvider = StreamProvider<List<WordList>>((ref) {
  print('🎯 allWordListsProvider: Starting to fetch word lists from Firebase');

  final useCase = ref.watch(getDailyWordListsUseCaseProvider);

  // Create a stream that handles errors gracefully
  return useCase()
      .map((lists) {
        print('🎯 allWordListsProvider: Received ${lists.length} lists from Firebase');
        if (lists.isEmpty) {
          print('🎯 allWordListsProvider: Firebase empty, returning sample data');
          return _getSampleWordLists();
        }
        return lists;
      })
      .handleError((error, stackTrace) {
        print('❌ Error in allWordListsProvider: $error');
        print('🎯 allWordListsProvider: Stack trace: $stackTrace');
      });
});

// Backup provider that always returns sample data (for development)
final sampleWordListsProvider = Provider<List<WordList>>((ref) {
  return _getSampleWordLists();
});

// Sample data for testing when Firebase is empty
List<WordList> _getSampleWordLists() {
  return [
    WordList(
      id: 'sample_animals',
      title: 'Animaux sauvages - 10 mots',
      words: ['Éléphant', 'Girafe', 'Lion', 'Tigre', 'Rhinocéros', 'Hippopotame', 'Crocodile', 'Zèbre', 'Antilope', 'Léopard'],
      difficulty: 'Facile',
      category: 'Animaux',
      isUserCreated: false,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      nextReviewAt: DateTime.now().add(const Duration(hours: 1)),
      easiness: 2.5,
      interval: 1,
      reps: 0,
    ),
    WordList(
      id: 'sample_objects',
      title: 'Objets quotidiens - 12 mots',
      words: ['Fourchette', 'Couteau', 'Cuillère', 'Assiette', 'Verre', 'Tasse', 'Serviette', 'Nappe', 'Bougie', 'Vase', 'Miroir', 'Peigne'],
      difficulty: 'Moyen',
      category: 'Objets quotidiens',
      isUserCreated: false,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      nextReviewAt: DateTime.now().subtract(const Duration(minutes: 30)),
      easiness: 2.5,
      interval: 1,
      reps: 0,
    ),
    WordList(
      id: 'sample_colors',
      title: 'Couleurs - 8 mots',
      words: ['Rouge', 'Bleu', 'Vert', 'Jaune', 'Orange', 'Violet', 'Rose', 'Noir'],
      difficulty: 'Facile',
      category: 'Couleurs',
      isUserCreated: false,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      nextReviewAt: DateTime.now().add(const Duration(hours: 3)),
      easiness: 2.5,
      interval: 1,
      reps: 0,
    ),
  ];
}

// Study session provider
final studySessionsProvider = StreamProvider<List<StudySession>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();

  final repository = ref.watch(wordListRepositoryProvider);
  return repository.watchStudySessions(user.uid);
});
