// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyEntry _$DailyEntryFromJson(Map<String, dynamic> json) => _DailyEntry(
  id: json['id'] as String,
  content: json['content'] as String,
  mood: json['mood'] as String?,
  gratitudeList:
      (json['gratitudeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  goalsForToday:
      (json['goalsForToday'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  reflection: json['reflection'] as String?,
  entryDate: DateTime.parse(json['entryDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  isSynced: json['isSynced'] as bool? ?? false,
);

Map<String, dynamic> _$DailyEntryToJson(_DailyEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'mood': instance.mood,
      'gratitudeList': instance.gratitudeList,
      'goalsForToday': instance.goalsForToday,
      'reflection': instance.reflection,
      'entryDate': instance.entryDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isSynced': instance.isSynced,
    };
