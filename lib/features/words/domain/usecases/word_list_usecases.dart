import 'package:super_brain/features/words/domain/entities/word_list.dart';
import 'package:super_brain/features/words/domain/repositories/word_list_repository.dart';
import 'package:super_brain/features/words/domain/usecases/srs_calculator.dart';

class StudyWordListUseCase {
  final WordListRepository _repository;

  StudyWordListUseCase(this._repository);

  /// Start a study session for a word list
  Future<StudySession> startStudySession({required String userId, required WordList wordList, required StudyMode mode}) async {
    final session = StudySession(id: _generateSessionId(), userId: userId, wordListId: wordList.id, startedAt: DateTime.now(), results: []);

    await _repository.saveStudySession(session);
    return session;
  }

  /// Complete a study session and update SRS data
  Future<void> completeStudySession({required StudySession session, required List<WordResult> results, required int finalScore, required int totalTimeSeconds}) async {
    // Complete the session
    final completedSession = session.copyWith(completedAt: DateTime.now(), results: results, isCompleted: true, finalScore: finalScore, totalTimeSeconds: totalTimeSeconds);

    await _repository.saveStudySession(completedSession);

    // Calculate quality score for SRS (0-5 scale)
    final quality = _calculateQuality(results, finalScore);

    // Get the current word list to access SRS data
    final wordList = await _repository.getWordList(session.wordListId, userId: session.userId);
    if (wordList == null) {
      print('Warning: Could not find word list ${session.wordListId} for SRS update');
      return;
    }

    // Check if this is a daily word list being learned for the first time
    final isDailyList = !wordList.isUserCreated;

    if (isDailyList) {
      // For daily lists, save as learned to user's collection when they complete it
      final learnedWordList = wordList.copyWith(
        id: '${wordList.id}_learned_${session.userId}',
        isUserCreated: true,
        isLearned: finalScore >= 80, // Mark as learned if score is 80% or higher
        learnedAt: finalScore >= 80 ? DateTime.now() : null,
        completedSessions: 1,
        averageScore: finalScore.toDouble(),
        nextReviewAt: DateTime.now().add(const Duration(days: 1)), // Review again tomorrow
      );

      await _repository.saveWordList(learnedWordList, session.userId);

      // Mark as learned if score is high enough
      if (finalScore >= 80) {
        await _repository.markWordListAsLearned(learnedWordList.id, session.userId, finalScore: finalScore, sessionCount: 1);
      }
    } else {
      // For user-created lists, update existing SRS data
      final srsResult = SrsCalculator.calculateNextReview(currentEasiness: wordList.easiness, currentInterval: wordList.interval, currentReps: wordList.reps, quality: quality);

      // Update SRS data
      await _repository.updateSrsData(
        session.wordListId,
        session.userId,
        easiness: srsResult.easiness,
        interval: srsResult.interval,
        reps: srsResult.reps,
        nextReviewAt: srsResult.nextReviewAt,
      );

      // Mark as learned if this is a high-performing session
      if (finalScore >= 90 && wordList.completedSessions >= 2) {
        await _repository.markWordListAsLearned(session.wordListId, session.userId, finalScore: finalScore, sessionCount: wordList.completedSessions + 1);
      }
    }
  }

  int _calculateQuality(List<WordResult> results, int finalScore) {
    if (results.isEmpty) return 3;

    final correctCount = results.where((r) => r.wasCorrect).length;
    final accuracy = correctCount / results.length;

    // Convert accuracy to 0-5 scale
    if (accuracy >= 0.9) return 5;
    if (accuracy >= 0.8) return 4;
    if (accuracy >= 0.6) return 3;
    if (accuracy >= 0.4) return 2;
    if (accuracy >= 0.2) return 1;
    return 0;
  }

  String _generateSessionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}

class CreateWordListUseCase {
  final WordListRepository _repository;

  CreateWordListUseCase(this._repository);

  Future<WordList> createWordList({required String userId, required String title, required List<String> words, required String difficulty, String? category}) async {
    final wordList = WordList(
      id: _generateWordListId(),
      title: title,
      words: words,
      difficulty: difficulty,
      createdAt: DateTime.now(),
      category: category,
      isUserCreated: true,
      nextReviewAt: DateTime.now(), // Available for immediate review
    );

    await _repository.saveWordList(wordList, userId);
    return wordList;
  }

  String _generateWordListId() {
    return 'user_${DateTime.now().millisecondsSinceEpoch}';
  }
}

class GetDailyWordListsUseCase {
  final WordListRepository _repository;

  GetDailyWordListsUseCase(this._repository);

  Stream<List<WordList>> call() {
    return _repository.watchDailyWordLists();
  }
}

class GetUserWordListsUseCase {
  final WordListRepository _repository;

  GetUserWordListsUseCase(this._repository);

  Stream<List<WordList>> call(String userId) {
    return _repository.watchUserWordLists(userId);
  }
}

class GetDueWordListsUseCase {
  final WordListRepository _repository;

  GetDueWordListsUseCase(this._repository);

  Stream<List<WordList>> call(String userId) {
    return _repository.watchDueWordLists(userId);
  }
}

class GetLearnedWordListsUseCase {
  final WordListRepository _repository;

  GetLearnedWordListsUseCase(this._repository);

  Stream<List<WordList>> call(String userId) {
    return _repository.watchLearnedWordLists(userId);
  }
}
