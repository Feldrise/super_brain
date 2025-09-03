// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
  streakCount: (json['streakCount'] as num?)?.toInt() ?? 0,
  routineConfig: json['routineConfig'] as Map<String, dynamic>? ?? const {},
  fcmToken: json['fcmToken'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
  'streakCount': instance.streakCount,
  'routineConfig': instance.routineConfig,
  'fcmToken': instance.fcmToken,
};

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  location: json['location'] as String?,
  bio: json['bio'] as String?,
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  morningRemindersEnabled: json['morningRemindersEnabled'] as bool? ?? true,
  studyRemindersEnabled: json['studyRemindersEnabled'] as bool? ?? true,
  tipOfDayEnabled: json['tipOfDayEnabled'] as bool? ?? true,
  morningReminderTime: json['morningReminderTime'] as String? ?? '06:30',
  studyReminderTime: json['studyReminderTime'] as String? ?? '19:00',
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'location': instance.location,
      'bio': instance.bio,
      'interests': instance.interests,
      'notificationsEnabled': instance.notificationsEnabled,
      'morningRemindersEnabled': instance.morningRemindersEnabled,
      'studyRemindersEnabled': instance.studyRemindersEnabled,
      'tipOfDayEnabled': instance.tipOfDayEnabled,
      'morningReminderTime': instance.morningReminderTime,
      'studyReminderTime': instance.studyReminderTime,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
