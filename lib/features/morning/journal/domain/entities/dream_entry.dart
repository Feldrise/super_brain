import 'package:freezed_annotation/freezed_annotation.dart';

part 'dream_entry.freezed.dart';
part 'dream_entry.g.dart';

@freezed
abstract class DreamEntry with _$DreamEntry {
  const factory DreamEntry({
    required String id,
    required String content,
    String? mood,
    String? category,
    @Default(false) bool isLucid,
    @Default(false) bool isRecurring,
    @Default([]) List<String> tags,
    DateTime? dreamDate,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isSynced,
  }) = _DreamEntry;

  factory DreamEntry.fromJson(Map<String, dynamic> json) => _$DreamEntryFromJson(json);
}

enum DreamMood {
  peaceful('Paisible', '😌'),
  excited('Excité', '😄'),
  anxious('Anxieux', '😰'),
  confused('Confus', '😕'),
  happy('Heureux', '😊'),
  scary('Effrayant', '😨'),
  sad('Triste', '😢'),
  neutral('Neutre', '😐');

  const DreamMood(this.displayName, this.emoji);
  final String displayName;
  final String emoji;
}

enum DreamCategory {
  normal('Normal', '🌙'),
  lucid('Lucide', '✨'),
  nightmare('Cauchemar', '👹'),
  recurring('Récurrent', '🔄'),
  prophetic('Prophétique', '🔮'),
  flying('Vol', '🦅'),
  adventure('Aventure', '🗺️'),
  romantic('Romantique', '💕');

  const DreamCategory(this.displayName, this.emoji);
  final String displayName;
  final String emoji;
}
