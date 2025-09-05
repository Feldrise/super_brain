// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DreamEntry _$DreamEntryFromJson(Map<String, dynamic> json) => _DreamEntry(
  id: json['id'] as String,
  content: json['content'] as String,
  mood: json['mood'] as String?,
  category: json['category'] as String?,
  isLucid: json['isLucid'] as bool? ?? false,
  isRecurring: json['isRecurring'] as bool? ?? false,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  dreamDate: json['dreamDate'] == null
      ? null
      : DateTime.parse(json['dreamDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  isSynced: json['isSynced'] as bool? ?? false,
);

Map<String, dynamic> _$DreamEntryToJson(_DreamEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'mood': instance.mood,
      'category': instance.category,
      'isLucid': instance.isLucid,
      'isRecurring': instance.isRecurring,
      'tags': instance.tags,
      'dreamDate': instance.dreamDate?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isSynced': instance.isSynced,
    };
