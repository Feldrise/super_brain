import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_tip.freezed.dart';
part 'daily_tip.g.dart';

@freezed
abstract class DailyTip with _$DailyTip {
  const factory DailyTip({
    required String id,
    required String title,
    required String content,
    required String category,
    required DateTime createdAt,
    @Default(false) bool isRead,
    String? imageUrl,
    List<String>? tags,
  }) = _DailyTip;

  factory DailyTip.fromJson(Map<String, dynamic> json) => _$DailyTipFromJson(json);
}

enum TipCategory { memory, concentration, productivity, health, learning, motivation, general }

extension TipCategoryExtension on TipCategory {
  String get displayName {
    switch (this) {
      case TipCategory.memory:
        return 'Mémoire';
      case TipCategory.concentration:
        return 'Concentration';
      case TipCategory.productivity:
        return 'Productivité';
      case TipCategory.health:
        return 'Santé mentale';
      case TipCategory.learning:
        return 'Apprentissage';
      case TipCategory.motivation:
        return 'Motivation';
      case TipCategory.general:
        return 'Général';
    }
  }

  String get iconName {
    switch (this) {
      case TipCategory.memory:
        return 'psychology';
      case TipCategory.concentration:
        return 'center_focus_strong';
      case TipCategory.productivity:
        return 'trending_up';
      case TipCategory.health:
        return 'favorite';
      case TipCategory.learning:
        return 'school';
      case TipCategory.motivation:
        return 'emoji_emotions';
      case TipCategory.general:
        return 'lightbulb';
    }
  }
}
