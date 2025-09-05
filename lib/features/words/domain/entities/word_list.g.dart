// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordList _$WordListFromJson(Map<String, dynamic> json) => _WordList(
  id: json['id'] as String,
  title: json['title'] as String,
  words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
  difficulty: json['difficulty'] as String? ?? 'Moyen',
  nextReviewAt: json['nextReviewAt'] == null
      ? null
      : DateTime.parse(json['nextReviewAt'] as String),
  easiness: (json['easiness'] as num?)?.toDouble() ?? 2.5,
  interval: (json['interval'] as num?)?.toInt() ?? 1,
  reps: (json['reps'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  category: json['category'] as String?,
  isUserCreated: json['isUserCreated'] as bool? ?? false,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$WordListToJson(_WordList instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'words': instance.words,
  'difficulty': instance.difficulty,
  'nextReviewAt': instance.nextReviewAt?.toIso8601String(),
  'easiness': instance.easiness,
  'interval': instance.interval,
  'reps': instance.reps,
  'createdAt': instance.createdAt.toIso8601String(),
  'category': instance.category,
  'isUserCreated': instance.isUserCreated,
  'isActive': instance.isActive,
};

_StudySession _$StudySessionFromJson(Map<String, dynamic> json) =>
    _StudySession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      wordListId: json['wordListId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      results: (json['results'] as List<dynamic>)
          .map((e) => WordResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      finalScore: (json['finalScore'] as num?)?.toInt(),
      totalTimeSeconds: (json['totalTimeSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StudySessionToJson(_StudySession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'wordListId': instance.wordListId,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'results': instance.results,
      'isCompleted': instance.isCompleted,
      'finalScore': instance.finalScore,
      'totalTimeSeconds': instance.totalTimeSeconds,
    };

_WordResult _$WordResultFromJson(Map<String, dynamic> json) => _WordResult(
  word: json['word'] as String,
  wasCorrect: json['wasCorrect'] as bool,
  timeSpentSeconds: (json['timeSpentSeconds'] as num).toInt(),
  attempts: (json['attempts'] as num?)?.toInt(),
);

Map<String, dynamic> _$WordResultToJson(_WordResult instance) =>
    <String, dynamic>{
      'word': instance.word,
      'wasCorrect': instance.wasCorrect,
      'timeSpentSeconds': instance.timeSpentSeconds,
      'attempts': instance.attempts,
    };
