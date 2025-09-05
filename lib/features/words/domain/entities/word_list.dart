import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_list.freezed.dart';
part 'word_list.g.dart';

@freezed
abstract class WordList with _$WordList {
  const factory WordList({
    required String id,
    required String title,
    required List<String> words,
    @Default('Moyen') String difficulty,
    DateTime? nextReviewAt,
    @Default(2.5) double easiness,
    @Default(1) int interval,
    @Default(0) int reps,
    required DateTime createdAt,
    String? category,
    @Default(false) bool isUserCreated,
    @Default(true) bool isActive,
  }) = _WordList;

  factory WordList.fromJson(Map<String, dynamic> json) => _$WordListFromJson(json);
}

@freezed
abstract class StudySession with _$StudySession {
  const factory StudySession({
    required String id,
    required String userId,
    required String wordListId,
    required DateTime startedAt,
    DateTime? completedAt,
    required List<WordResult> results,
    @Default(false) bool isCompleted,
    int? finalScore,
    int? totalTimeSeconds,
  }) = _StudySession;

  factory StudySession.fromJson(Map<String, dynamic> json) => _$StudySessionFromJson(json);
}

@freezed
abstract class WordResult with _$WordResult {
  const factory WordResult({required String word, required bool wasCorrect, required int timeSpentSeconds, int? attempts}) = _WordResult;

  factory WordResult.fromJson(Map<String, dynamic> json) => _$WordResultFromJson(json);
}

enum StudyMode { memorization, recall, recognition }

enum WordListDifficulty { facile, moyen, difficile }

extension WordListDifficultyExtension on WordListDifficulty {
  String get displayName {
    switch (this) {
      case WordListDifficulty.facile:
        return 'Facile';
      case WordListDifficulty.moyen:
        return 'Moyen';
      case WordListDifficulty.difficile:
        return 'Difficile';
    }
  }
}
