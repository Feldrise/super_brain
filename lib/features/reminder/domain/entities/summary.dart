import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary.freezed.dart';
part 'summary.g.dart';

@freezed
abstract class Summary with _$Summary {
  const factory Summary({
    required String id,
    required String title,
    required String content, // Markdown content
    @Default(0) int estimatedReadingTime, // in minutes
    @Default([]) List<String> keyPoints,
    // Simple metadata
    required DateTime createdAt,
    @Default(true) bool isActive,
  }) = _Summary;

  factory Summary.fromJson(Map<String, dynamic> json) => _$SummaryFromJson(json);
}
