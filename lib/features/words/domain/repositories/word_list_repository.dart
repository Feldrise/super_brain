import 'package:super_brain/features/words/domain/entities/word_list.dart';

abstract class WordListRepository {
  /// Get all word lists for a user
  Stream<List<WordList>> watchUserWordLists(String userId);

  /// Get word lists that are due for review
  Stream<List<WordList>> watchDueWordLists(String userId);

  /// Get daily word lists (curated content)
  Stream<List<WordList>> watchDailyWordLists();

  /// Get a specific word list
  Future<WordList?> getWordList(String id, {String? userId});

  /// Create or update a word list
  Future<void> saveWordList(WordList wordList, String userId);

  /// Delete a word list
  Future<void> deleteWordList(String id, String userId);

  /// Update SRS data after study session
  Future<void> updateSrsData(String wordListId, String userId, {required double easiness, required int interval, required int reps, required DateTime nextReviewAt});

  /// Save study session results
  Future<void> saveStudySession(StudySession session);

  /// Get study session history
  Stream<List<StudySession>> watchStudySessions(String userId);
}
