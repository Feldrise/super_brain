// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {

 String get id; String get email; String? get displayName; String? get photoURL; DateTime get createdAt; DateTime? get lastActiveAt; int get streakCount; Map<String, dynamic> get routineConfig; String? get fcmToken;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.streakCount, streakCount) || other.streakCount == streakCount)&&const DeepCollectionEquality().equals(other.routineConfig, routineConfig)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoURL,createdAt,lastActiveAt,streakCount,const DeepCollectionEquality().hash(routineConfig),fcmToken);

@override
String toString() {
  return 'AppUser(id: $id, email: $email, displayName: $displayName, photoURL: $photoURL, createdAt: $createdAt, lastActiveAt: $lastActiveAt, streakCount: $streakCount, routineConfig: $routineConfig, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? displayName, String? photoURL, DateTime createdAt, DateTime? lastActiveAt, int streakCount, Map<String, dynamic> routineConfig, String? fcmToken
});




}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? photoURL = freezed,Object? createdAt = null,Object? lastActiveAt = freezed,Object? streakCount = null,Object? routineConfig = null,Object? fcmToken = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,streakCount: null == streakCount ? _self.streakCount : streakCount // ignore: cast_nullable_to_non_nullable
as int,routineConfig: null == routineConfig ? _self.routineConfig : routineConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUser value)  $default,){
final _that = this;
switch (_that) {
case _AppUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUser value)?  $default,){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? photoURL,  DateTime createdAt,  DateTime? lastActiveAt,  int streakCount,  Map<String, dynamic> routineConfig,  String? fcmToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoURL,_that.createdAt,_that.lastActiveAt,_that.streakCount,_that.routineConfig,_that.fcmToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? photoURL,  DateTime createdAt,  DateTime? lastActiveAt,  int streakCount,  Map<String, dynamic> routineConfig,  String? fcmToken)  $default,) {final _that = this;
switch (_that) {
case _AppUser():
return $default(_that.id,_that.email,_that.displayName,_that.photoURL,_that.createdAt,_that.lastActiveAt,_that.streakCount,_that.routineConfig,_that.fcmToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? displayName,  String? photoURL,  DateTime createdAt,  DateTime? lastActiveAt,  int streakCount,  Map<String, dynamic> routineConfig,  String? fcmToken)?  $default,) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoURL,_that.createdAt,_that.lastActiveAt,_that.streakCount,_that.routineConfig,_that.fcmToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUser implements AppUser {
  const _AppUser({required this.id, required this.email, this.displayName, this.photoURL, required this.createdAt, this.lastActiveAt, this.streakCount = 0, final  Map<String, dynamic> routineConfig = const {}, this.fcmToken}): _routineConfig = routineConfig;
  factory _AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? displayName;
@override final  String? photoURL;
@override final  DateTime createdAt;
@override final  DateTime? lastActiveAt;
@override@JsonKey() final  int streakCount;
 final  Map<String, dynamic> _routineConfig;
@override@JsonKey() Map<String, dynamic> get routineConfig {
  if (_routineConfig is EqualUnmodifiableMapView) return _routineConfig;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_routineConfig);
}

@override final  String? fcmToken;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.streakCount, streakCount) || other.streakCount == streakCount)&&const DeepCollectionEquality().equals(other._routineConfig, _routineConfig)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoURL,createdAt,lastActiveAt,streakCount,const DeepCollectionEquality().hash(_routineConfig),fcmToken);

@override
String toString() {
  return 'AppUser(id: $id, email: $email, displayName: $displayName, photoURL: $photoURL, createdAt: $createdAt, lastActiveAt: $lastActiveAt, streakCount: $streakCount, routineConfig: $routineConfig, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? displayName, String? photoURL, DateTime createdAt, DateTime? lastActiveAt, int streakCount, Map<String, dynamic> routineConfig, String? fcmToken
});




}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? photoURL = freezed,Object? createdAt = null,Object? lastActiveAt = freezed,Object? streakCount = null,Object? routineConfig = null,Object? fcmToken = freezed,}) {
  return _then(_AppUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,streakCount: null == streakCount ? _self.streakCount : streakCount // ignore: cast_nullable_to_non_nullable
as int,routineConfig: null == routineConfig ? _self._routineConfig : routineConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserProfile {

 String get id; String get email; String? get displayName; String? get photoURL; String? get phoneNumber; DateTime? get dateOfBirth; String? get location; String? get bio; List<String> get interests; bool get notificationsEnabled; bool get morningRemindersEnabled; bool get studyRemindersEnabled; bool get tipOfDayEnabled; String get morningReminderTime; String get studyReminderTime; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.location, location) || other.location == location)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.morningRemindersEnabled, morningRemindersEnabled) || other.morningRemindersEnabled == morningRemindersEnabled)&&(identical(other.studyRemindersEnabled, studyRemindersEnabled) || other.studyRemindersEnabled == studyRemindersEnabled)&&(identical(other.tipOfDayEnabled, tipOfDayEnabled) || other.tipOfDayEnabled == tipOfDayEnabled)&&(identical(other.morningReminderTime, morningReminderTime) || other.morningReminderTime == morningReminderTime)&&(identical(other.studyReminderTime, studyReminderTime) || other.studyReminderTime == studyReminderTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoURL,phoneNumber,dateOfBirth,location,bio,const DeepCollectionEquality().hash(interests),notificationsEnabled,morningRemindersEnabled,studyRemindersEnabled,tipOfDayEnabled,morningReminderTime,studyReminderTime,createdAt,updatedAt);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, displayName: $displayName, photoURL: $photoURL, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, location: $location, bio: $bio, interests: $interests, notificationsEnabled: $notificationsEnabled, morningRemindersEnabled: $morningRemindersEnabled, studyRemindersEnabled: $studyRemindersEnabled, tipOfDayEnabled: $tipOfDayEnabled, morningReminderTime: $morningReminderTime, studyReminderTime: $studyReminderTime, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? displayName, String? photoURL, String? phoneNumber, DateTime? dateOfBirth, String? location, String? bio, List<String> interests, bool notificationsEnabled, bool morningRemindersEnabled, bool studyRemindersEnabled, bool tipOfDayEnabled, String morningReminderTime, String studyReminderTime, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? photoURL = freezed,Object? phoneNumber = freezed,Object? dateOfBirth = freezed,Object? location = freezed,Object? bio = freezed,Object? interests = null,Object? notificationsEnabled = null,Object? morningRemindersEnabled = null,Object? studyRemindersEnabled = null,Object? tipOfDayEnabled = null,Object? morningReminderTime = null,Object? studyReminderTime = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,morningRemindersEnabled: null == morningRemindersEnabled ? _self.morningRemindersEnabled : morningRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,studyRemindersEnabled: null == studyRemindersEnabled ? _self.studyRemindersEnabled : studyRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,tipOfDayEnabled: null == tipOfDayEnabled ? _self.tipOfDayEnabled : tipOfDayEnabled // ignore: cast_nullable_to_non_nullable
as bool,morningReminderTime: null == morningReminderTime ? _self.morningReminderTime : morningReminderTime // ignore: cast_nullable_to_non_nullable
as String,studyReminderTime: null == studyReminderTime ? _self.studyReminderTime : studyReminderTime // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? photoURL,  String? phoneNumber,  DateTime? dateOfBirth,  String? location,  String? bio,  List<String> interests,  bool notificationsEnabled,  bool morningRemindersEnabled,  bool studyRemindersEnabled,  bool tipOfDayEnabled,  String morningReminderTime,  String studyReminderTime,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoURL,_that.phoneNumber,_that.dateOfBirth,_that.location,_that.bio,_that.interests,_that.notificationsEnabled,_that.morningRemindersEnabled,_that.studyRemindersEnabled,_that.tipOfDayEnabled,_that.morningReminderTime,_that.studyReminderTime,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? photoURL,  String? phoneNumber,  DateTime? dateOfBirth,  String? location,  String? bio,  List<String> interests,  bool notificationsEnabled,  bool morningRemindersEnabled,  bool studyRemindersEnabled,  bool tipOfDayEnabled,  String morningReminderTime,  String studyReminderTime,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.email,_that.displayName,_that.photoURL,_that.phoneNumber,_that.dateOfBirth,_that.location,_that.bio,_that.interests,_that.notificationsEnabled,_that.morningRemindersEnabled,_that.studyRemindersEnabled,_that.tipOfDayEnabled,_that.morningReminderTime,_that.studyReminderTime,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? displayName,  String? photoURL,  String? phoneNumber,  DateTime? dateOfBirth,  String? location,  String? bio,  List<String> interests,  bool notificationsEnabled,  bool morningRemindersEnabled,  bool studyRemindersEnabled,  bool tipOfDayEnabled,  String morningReminderTime,  String studyReminderTime,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoURL,_that.phoneNumber,_that.dateOfBirth,_that.location,_that.bio,_that.interests,_that.notificationsEnabled,_that.morningRemindersEnabled,_that.studyRemindersEnabled,_that.tipOfDayEnabled,_that.morningReminderTime,_that.studyReminderTime,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, required this.email, this.displayName, this.photoURL, this.phoneNumber, this.dateOfBirth, this.location, this.bio, final  List<String> interests = const [], this.notificationsEnabled = true, this.morningRemindersEnabled = true, this.studyRemindersEnabled = true, this.tipOfDayEnabled = true, this.morningReminderTime = '06:30', this.studyReminderTime = '19:00', required this.createdAt, this.updatedAt}): _interests = interests;
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? displayName;
@override final  String? photoURL;
@override final  String? phoneNumber;
@override final  DateTime? dateOfBirth;
@override final  String? location;
@override final  String? bio;
 final  List<String> _interests;
@override@JsonKey() List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  bool morningRemindersEnabled;
@override@JsonKey() final  bool studyRemindersEnabled;
@override@JsonKey() final  bool tipOfDayEnabled;
@override@JsonKey() final  String morningReminderTime;
@override@JsonKey() final  String studyReminderTime;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.location, location) || other.location == location)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.morningRemindersEnabled, morningRemindersEnabled) || other.morningRemindersEnabled == morningRemindersEnabled)&&(identical(other.studyRemindersEnabled, studyRemindersEnabled) || other.studyRemindersEnabled == studyRemindersEnabled)&&(identical(other.tipOfDayEnabled, tipOfDayEnabled) || other.tipOfDayEnabled == tipOfDayEnabled)&&(identical(other.morningReminderTime, morningReminderTime) || other.morningReminderTime == morningReminderTime)&&(identical(other.studyReminderTime, studyReminderTime) || other.studyReminderTime == studyReminderTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoURL,phoneNumber,dateOfBirth,location,bio,const DeepCollectionEquality().hash(_interests),notificationsEnabled,morningRemindersEnabled,studyRemindersEnabled,tipOfDayEnabled,morningReminderTime,studyReminderTime,createdAt,updatedAt);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, displayName: $displayName, photoURL: $photoURL, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, location: $location, bio: $bio, interests: $interests, notificationsEnabled: $notificationsEnabled, morningRemindersEnabled: $morningRemindersEnabled, studyRemindersEnabled: $studyRemindersEnabled, tipOfDayEnabled: $tipOfDayEnabled, morningReminderTime: $morningReminderTime, studyReminderTime: $studyReminderTime, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? displayName, String? photoURL, String? phoneNumber, DateTime? dateOfBirth, String? location, String? bio, List<String> interests, bool notificationsEnabled, bool morningRemindersEnabled, bool studyRemindersEnabled, bool tipOfDayEnabled, String morningReminderTime, String studyReminderTime, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? photoURL = freezed,Object? phoneNumber = freezed,Object? dateOfBirth = freezed,Object? location = freezed,Object? bio = freezed,Object? interests = null,Object? notificationsEnabled = null,Object? morningRemindersEnabled = null,Object? studyRemindersEnabled = null,Object? tipOfDayEnabled = null,Object? morningReminderTime = null,Object? studyReminderTime = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,morningRemindersEnabled: null == morningRemindersEnabled ? _self.morningRemindersEnabled : morningRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,studyRemindersEnabled: null == studyRemindersEnabled ? _self.studyRemindersEnabled : studyRemindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,tipOfDayEnabled: null == tipOfDayEnabled ? _self.tipOfDayEnabled : tipOfDayEnabled // ignore: cast_nullable_to_non_nullable
as bool,morningReminderTime: null == morningReminderTime ? _self.morningReminderTime : morningReminderTime // ignore: cast_nullable_to_non_nullable
as String,studyReminderTime: null == studyReminderTime ? _self.studyReminderTime : studyReminderTime // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
