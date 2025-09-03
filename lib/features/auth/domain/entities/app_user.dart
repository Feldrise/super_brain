import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    String? displayName,
    String? photoURL,
    required DateTime createdAt,
    DateTime? lastActiveAt,
    @Default(0) int streakCount,
    @Default({}) Map<String, dynamic> routineConfig,
    String? fcmToken,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? location,
    String? bio,
    @Default([]) List<String> interests,
    @Default(true) bool notificationsEnabled,
    @Default(true) bool morningRemindersEnabled,
    @Default(true) bool studyRemindersEnabled,
    @Default(true) bool tipOfDayEnabled,
    @Default('06:30') String morningReminderTime,
    @Default('19:00') String studyReminderTime,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
