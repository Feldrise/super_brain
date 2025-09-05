import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/words/domain/entities/word_list.dart';

class WordListModel {
  final String id;
  final String title;
  final List<String> words;
  final String difficulty;
  final DateTime? nextReviewAt;
  final double easiness;
  final int interval;
  final int reps;
  final DateTime createdAt;
  final String? category;
  final bool isUserCreated;
  final bool isActive;
  final bool isLearned;
  final DateTime? learnedAt;
  final int completedSessions;
  final double averageScore;

  const WordListModel({
    required this.id,
    required this.title,
    required this.words,
    this.difficulty = 'Moyen',
    this.nextReviewAt,
    this.easiness = 2.5,
    this.interval = 1,
    this.reps = 0,
    required this.createdAt,
    this.category,
    this.isUserCreated = false,
    this.isActive = true,
    this.isLearned = false,
    this.learnedAt,
    this.completedSessions = 0,
    this.averageScore = 0,
  });

  // Convert to domain entity
  WordList toDomain() => WordList(
    id: id,
    title: title,
    words: words,
    difficulty: difficulty,
    nextReviewAt: nextReviewAt,
    easiness: easiness,
    interval: interval,
    reps: reps,
    createdAt: createdAt,
    category: category,
    isUserCreated: isUserCreated,
    isActive: isActive,
    isLearned: isLearned,
    learnedAt: learnedAt,
    completedSessions: completedSessions,
    averageScore: averageScore,
  );

  // Create from domain entity
  factory WordListModel.fromDomain(WordList wordList) => WordListModel(
    id: wordList.id,
    title: wordList.title,
    words: wordList.words,
    difficulty: wordList.difficulty,
    nextReviewAt: wordList.nextReviewAt,
    easiness: wordList.easiness,
    interval: wordList.interval,
    reps: wordList.reps,
    createdAt: wordList.createdAt,
    category: wordList.category,
    isUserCreated: wordList.isUserCreated,
    isActive: wordList.isActive,
    isLearned: wordList.isLearned,
    learnedAt: wordList.learnedAt,
    completedSessions: wordList.completedSessions,
    averageScore: wordList.averageScore,
  );

  factory WordListModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WordListModel.fromJson({'id': doc.id, ...data});
  }

  factory WordListModel.fromJson(Map<String, dynamic> json) {
    return WordListModel(
      id: json['id'],
      title: json['title'],
      words: List<String>.from(json['words'] ?? []),
      difficulty: json['difficulty'] ?? 'Moyen',
      nextReviewAt: json['nextReviewAt'] != null ? (json['nextReviewAt'] as Timestamp).toDate() : null,
      easiness: (json['easiness'] ?? 2.5).toDouble(),
      interval: json['interval'] ?? 1,
      reps: json['reps'] ?? 0,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      category: json['category'],
      isUserCreated: json['isUserCreated'] ?? false,
      isActive: json['isActive'] ?? true,
      isLearned: json['isLearned'] ?? false,
      learnedAt: json['learnedAt'] != null ? (json['learnedAt'] as Timestamp).toDate() : null,
      completedSessions: json['completedSessions'] ?? 0,
      averageScore: (json['averageScore'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    data.remove('id'); // Remove ID for Firestore document
    if (nextReviewAt != null) {
      data['nextReviewAt'] = Timestamp.fromDate(nextReviewAt!);
    }
    data['createdAt'] = Timestamp.fromDate(createdAt);
    if (learnedAt != null) {
      data['learnedAt'] = Timestamp.fromDate(learnedAt!);
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'words': words,
      'difficulty': difficulty,
      'nextReviewAt': nextReviewAt,
      'easiness': easiness,
      'interval': interval,
      'reps': reps,
      'createdAt': createdAt,
      'category': category,
      'isUserCreated': isUserCreated,
      'isActive': isActive,
      'isLearned': isLearned,
      'learnedAt': learnedAt,
      'completedSessions': completedSessions,
      'averageScore': averageScore,
    };
  }
}

class StudySessionModel {
  final String id;
  final String userId;
  final String wordListId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final List<WordResult> results;
  final bool isCompleted;
  final int? finalScore;
  final int? totalTimeSeconds;

  const StudySessionModel({
    required this.id,
    required this.userId,
    required this.wordListId,
    required this.startedAt,
    this.completedAt,
    this.results = const [],
    this.isCompleted = false,
    this.finalScore,
    this.totalTimeSeconds,
  });

  // Convert to domain entity
  StudySession toDomain() => StudySession(
    id: id,
    userId: userId,
    wordListId: wordListId,
    startedAt: startedAt,
    completedAt: completedAt,
    results: results,
    isCompleted: isCompleted,
    finalScore: finalScore,
    totalTimeSeconds: totalTimeSeconds,
  );

  // Create from domain entity
  factory StudySessionModel.fromDomain(StudySession session) => StudySessionModel(
    id: session.id,
    userId: session.userId,
    wordListId: session.wordListId,
    startedAt: session.startedAt,
    completedAt: session.completedAt,
    results: session.results,
    isCompleted: session.isCompleted,
    finalScore: session.finalScore,
    totalTimeSeconds: session.totalTimeSeconds,
  );

  factory StudySessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return StudySessionModel.fromJson({'id': doc.id, ...data});
  }

  factory StudySessionModel.fromJson(Map<String, dynamic> json) {
    return StudySessionModel(
      id: json['id'],
      userId: json['userId'],
      wordListId: json['wordListId'],
      startedAt: (json['startedAt'] as Timestamp).toDate(),
      completedAt: json['completedAt'] != null ? (json['completedAt'] as Timestamp).toDate() : null,
      results: (json['results'] as List<dynamic>?)?.map((e) => WordResult.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      isCompleted: json['isCompleted'] ?? false,
      finalScore: json['finalScore'],
      totalTimeSeconds: json['totalTimeSeconds'],
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    data.remove('id');
    data['startedAt'] = Timestamp.fromDate(startedAt);
    if (completedAt != null) {
      data['completedAt'] = Timestamp.fromDate(completedAt!);
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'wordListId': wordListId,
      'startedAt': startedAt,
      'completedAt': completedAt,
      'results': results.map((e) => e.toJson()).toList(),
      'isCompleted': isCompleted,
      'finalScore': finalScore,
      'totalTimeSeconds': totalTimeSeconds,
    };
  }
}
