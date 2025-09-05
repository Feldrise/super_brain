import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_entry.freezed.dart';
part 'daily_entry.g.dart';

@freezed
abstract class DailyEntry with _$DailyEntry {
  const factory DailyEntry({
    required String id,
    required String content,
    String? mood,
    @Default([]) List<String> gratitudeList,
    @Default([]) List<String> goalsForToday,
    String? reflection,
    required DateTime entryDate, // Date of the journal entry (not creation time)
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isSynced,
  }) = _DailyEntry;

  factory DailyEntry.fromJson(Map<String, dynamic> json) => _$DailyEntryFromJson(json);
}

enum DailyMood {
  excellent('Excellent', '😄'),
  good('Bien', '😊'),
  neutral('Neutre', '😐'),
  tired('Fatigué', '😴'),
  stressed('Stressé', '😰'),
  anxious('Anxieux', '😟'),
  sad('Triste', '😢'),
  energetic('Énergique', '⚡');

  const DailyMood(this.label, this.emoji);

  final String label;
  final String emoji;

  static List<DailyMood> get allMoods => DailyMood.values;
}

// Morning journal prompts to help users get started
class DailyJournalPrompts {
  static const List<String> gratitudePrompts = [
    'Je suis reconnaissant pour...',
    'Aujourd\'hui j\'apprécie...',
    'Ce qui me rend heureux c\'est...',
    'Une chose positive dans ma vie est...',
    'Je suis chanceux d\'avoir...',
  ];

  static const List<String> reflectionPrompts = [
    'Comment je me sens ce matin...',
    'Mon intention pour aujourd\'hui est...',
    'Ce que j\'espère accomplir aujourd\'hui...',
    'Une leçon que j\'ai apprise récemment...',
    'Ce qui me motive actuellement...',
    'Un défi que je veux relever aujourd\'hui...',
    'Ce qui me préoccupe en ce moment...',
    'Une habitude que je veux développer...',
  ];

  static const List<String> goalPrompts = [
    'Aujourd\'hui je vais...',
    'Ma priorité principale est...',
    'Je veux me concentrer sur...',
    'Un petit pas vers mon objectif...',
    'Ce que je dois terminer aujourd\'hui...',
  ];
}
