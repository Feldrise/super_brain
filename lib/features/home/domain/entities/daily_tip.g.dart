// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyTip _$DailyTipFromJson(Map<String, dynamic> json) => _DailyTip(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  category: json['category'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isRead: json['isRead'] as bool? ?? false,
  imageUrl: json['imageUrl'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$DailyTipToJson(_DailyTip instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'category': instance.category,
  'createdAt': instance.createdAt.toIso8601String(),
  'isRead': instance.isRead,
  'imageUrl': instance.imageUrl,
  'tags': instance.tags,
};
