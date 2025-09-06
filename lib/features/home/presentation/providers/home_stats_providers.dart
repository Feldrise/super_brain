import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/words/presentation/providers/word_list_providers.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/providers/daily_journal_providers.dart';
import 'package:super_brain/features/training/presentation/providers/training_providers.dart';
import 'package:super_brain/features/training/domain/usecases/training_usecases.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';

// Use cases
final getUserTrainingStatsUseCaseProvider = Provider<GetUserTrainingStatsUseCase>((ref) {
  return GetUserTrainingStatsUseCase(ref.watch(trainingRepositoryProvider));
});

// Training stats provider
final userTrainingStatsProvider = StreamProvider<TrainingStats?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();

  final useCase = ref.watch(getUserTrainingStatsUseCaseProvider);
  return useCase.watch(user.uid);
});

// Home stats data model
class HomeStats {
  final int streakCount;
  final int wordsLearned;
  final int journalStreak;
  final int trainingSessionsCount;

  const HomeStats({required this.streakCount, required this.wordsLearned, required this.journalStreak, required this.trainingSessionsCount});

  static const empty = HomeStats(streakCount: 0, wordsLearned: 0, journalStreak: 0, trainingSessionsCount: 0);
}

// Provider that aggregates stats from different features
final homeStatsProvider = FutureProvider<HomeStats>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return HomeStats.empty;

  try {
    // Get app user for streak count
    final appUserAsync = ref.watch(appUserProvider);
    final appUser = await appUserAsync.when(data: (data) => Future.value(data), loading: () => Future.value(null), error: (_, __) => Future.value(null));

    // Get learned words count
    final learnedWordsAsync = ref.watch(learnedWordListsProvider);
    final learnedWords = await learnedWordsAsync.when(data: (data) => Future.value(data), loading: () => Future.value(<dynamic>[]), error: (_, __) => Future.value(<dynamic>[]));

    // Get journal streak
    final journalStreakAsync = ref.watch(journalStreakProvider);
    final journalStreak = await journalStreakAsync.when(data: (data) => Future.value(data), loading: () => Future.value(0), error: (_, __) => Future.value(0));

    // Get training stats if available
    int trainingSessionsCount = 0;
    try {
      final trainingStatsAsync = ref.watch(userTrainingStatsProvider);
      final trainingStats = await trainingStatsAsync.when(data: (data) => Future.value(data), loading: () => Future.value(null), error: (_, __) => Future.value(null));
      trainingSessionsCount = trainingStats?.totalSessions ?? 0;
    } catch (e) {
      // Training feature might not be available
      // print('Training stats not available: $e'); // Debug only
    }

    return HomeStats(streakCount: appUser?.streakCount ?? 0, wordsLearned: learnedWords.length, journalStreak: journalStreak, trainingSessionsCount: trainingSessionsCount);
  } catch (e) {
    // print('Error loading home stats: $e'); // Debug only
    return HomeStats.empty;
  }
});

// Individual stat providers for reactive updates
final userStreakProvider = Provider<int>((ref) {
  final appUserAsync = ref.watch(appUserProvider);
  return appUserAsync.when(data: (appUser) => appUser?.streakCount ?? 0, loading: () => 0, error: (_, __) => 0);
});

final learnedWordsCountProvider = Provider<int>((ref) {
  final learnedWordsAsync = ref.watch(learnedWordListsProvider);
  return learnedWordsAsync.when(data: (learnedWords) => learnedWords.length, loading: () => 0, error: (_, __) => 0);
});
