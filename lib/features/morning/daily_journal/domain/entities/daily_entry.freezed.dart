// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyEntry {

 String get id; String get content; String? get mood; List<String> get gratitudeList; List<String> get goalsForToday; String? get reflection; DateTime get entryDate;// Date of the journal entry (not creation time)
 DateTime get createdAt; DateTime? get updatedAt; bool get isSynced;
/// Create a copy of DailyEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyEntryCopyWith<DailyEntry> get copyWith => _$DailyEntryCopyWithImpl<DailyEntry>(this as DailyEntry, _$identity);

  /// Serializes this DailyEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other.gratitudeList, gratitudeList)&&const DeepCollectionEquality().equals(other.goalsForToday, goalsForToday)&&(identical(other.reflection, reflection) || other.reflection == reflection)&&(identical(other.entryDate, entryDate) || other.entryDate == entryDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,mood,const DeepCollectionEquality().hash(gratitudeList),const DeepCollectionEquality().hash(goalsForToday),reflection,entryDate,createdAt,updatedAt,isSynced);

@override
String toString() {
  return 'DailyEntry(id: $id, content: $content, mood: $mood, gratitudeList: $gratitudeList, goalsForToday: $goalsForToday, reflection: $reflection, entryDate: $entryDate, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class $DailyEntryCopyWith<$Res>  {
  factory $DailyEntryCopyWith(DailyEntry value, $Res Function(DailyEntry) _then) = _$DailyEntryCopyWithImpl;
@useResult
$Res call({
 String id, String content, String? mood, List<String> gratitudeList, List<String> goalsForToday, String? reflection, DateTime entryDate, DateTime createdAt, DateTime? updatedAt, bool isSynced
});




}
/// @nodoc
class _$DailyEntryCopyWithImpl<$Res>
    implements $DailyEntryCopyWith<$Res> {
  _$DailyEntryCopyWithImpl(this._self, this._then);

  final DailyEntry _self;
  final $Res Function(DailyEntry) _then;

/// Create a copy of DailyEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? mood = freezed,Object? gratitudeList = null,Object? goalsForToday = null,Object? reflection = freezed,Object? entryDate = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isSynced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,gratitudeList: null == gratitudeList ? _self.gratitudeList : gratitudeList // ignore: cast_nullable_to_non_nullable
as List<String>,goalsForToday: null == goalsForToday ? _self.goalsForToday : goalsForToday // ignore: cast_nullable_to_non_nullable
as List<String>,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as String?,entryDate: null == entryDate ? _self.entryDate : entryDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyEntry].
extension DailyEntryPatterns on DailyEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyEntry value)  $default,){
final _that = this;
switch (_that) {
case _DailyEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DailyEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  String? mood,  List<String> gratitudeList,  List<String> goalsForToday,  String? reflection,  DateTime entryDate,  DateTime createdAt,  DateTime? updatedAt,  bool isSynced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyEntry() when $default != null:
return $default(_that.id,_that.content,_that.mood,_that.gratitudeList,_that.goalsForToday,_that.reflection,_that.entryDate,_that.createdAt,_that.updatedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  String? mood,  List<String> gratitudeList,  List<String> goalsForToday,  String? reflection,  DateTime entryDate,  DateTime createdAt,  DateTime? updatedAt,  bool isSynced)  $default,) {final _that = this;
switch (_that) {
case _DailyEntry():
return $default(_that.id,_that.content,_that.mood,_that.gratitudeList,_that.goalsForToday,_that.reflection,_that.entryDate,_that.createdAt,_that.updatedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  String? mood,  List<String> gratitudeList,  List<String> goalsForToday,  String? reflection,  DateTime entryDate,  DateTime createdAt,  DateTime? updatedAt,  bool isSynced)?  $default,) {final _that = this;
switch (_that) {
case _DailyEntry() when $default != null:
return $default(_that.id,_that.content,_that.mood,_that.gratitudeList,_that.goalsForToday,_that.reflection,_that.entryDate,_that.createdAt,_that.updatedAt,_that.isSynced);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyEntry implements DailyEntry {
  const _DailyEntry({required this.id, required this.content, this.mood, final  List<String> gratitudeList = const [], final  List<String> goalsForToday = const [], this.reflection, required this.entryDate, required this.createdAt, this.updatedAt, this.isSynced = false}): _gratitudeList = gratitudeList,_goalsForToday = goalsForToday;
  factory _DailyEntry.fromJson(Map<String, dynamic> json) => _$DailyEntryFromJson(json);

@override final  String id;
@override final  String content;
@override final  String? mood;
 final  List<String> _gratitudeList;
@override@JsonKey() List<String> get gratitudeList {
  if (_gratitudeList is EqualUnmodifiableListView) return _gratitudeList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gratitudeList);
}

 final  List<String> _goalsForToday;
@override@JsonKey() List<String> get goalsForToday {
  if (_goalsForToday is EqualUnmodifiableListView) return _goalsForToday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goalsForToday);
}

@override final  String? reflection;
@override final  DateTime entryDate;
// Date of the journal entry (not creation time)
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  bool isSynced;

/// Create a copy of DailyEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyEntryCopyWith<_DailyEntry> get copyWith => __$DailyEntryCopyWithImpl<_DailyEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other._gratitudeList, _gratitudeList)&&const DeepCollectionEquality().equals(other._goalsForToday, _goalsForToday)&&(identical(other.reflection, reflection) || other.reflection == reflection)&&(identical(other.entryDate, entryDate) || other.entryDate == entryDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,mood,const DeepCollectionEquality().hash(_gratitudeList),const DeepCollectionEquality().hash(_goalsForToday),reflection,entryDate,createdAt,updatedAt,isSynced);

@override
String toString() {
  return 'DailyEntry(id: $id, content: $content, mood: $mood, gratitudeList: $gratitudeList, goalsForToday: $goalsForToday, reflection: $reflection, entryDate: $entryDate, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class _$DailyEntryCopyWith<$Res> implements $DailyEntryCopyWith<$Res> {
  factory _$DailyEntryCopyWith(_DailyEntry value, $Res Function(_DailyEntry) _then) = __$DailyEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, String? mood, List<String> gratitudeList, List<String> goalsForToday, String? reflection, DateTime entryDate, DateTime createdAt, DateTime? updatedAt, bool isSynced
});




}
/// @nodoc
class __$DailyEntryCopyWithImpl<$Res>
    implements _$DailyEntryCopyWith<$Res> {
  __$DailyEntryCopyWithImpl(this._self, this._then);

  final _DailyEntry _self;
  final $Res Function(_DailyEntry) _then;

/// Create a copy of DailyEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? mood = freezed,Object? gratitudeList = null,Object? goalsForToday = null,Object? reflection = freezed,Object? entryDate = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isSynced = null,}) {
  return _then(_DailyEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,gratitudeList: null == gratitudeList ? _self._gratitudeList : gratitudeList // ignore: cast_nullable_to_non_nullable
as List<String>,goalsForToday: null == goalsForToday ? _self._goalsForToday : goalsForToday // ignore: cast_nullable_to_non_nullable
as List<String>,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as String?,entryDate: null == entryDate ? _self.entryDate : entryDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
