// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Summary _$SummaryFromJson(Map<String, dynamic> json) => _Summary(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  estimatedReadingTime: (json['estimatedReadingTime'] as num?)?.toInt() ?? 0,
  keyPoints:
      (json['keyPoints'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$SummaryToJson(_Summary instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'estimatedReadingTime': instance.estimatedReadingTime,
  'keyPoints': instance.keyPoints,
  'createdAt': instance.createdAt.toIso8601String(),
  'isActive': instance.isActive,
};
