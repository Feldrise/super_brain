// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DreamEntry {

 String get id; String get content; String? get mood; String? get category; bool get isLucid; bool get isRecurring; List<String> get tags; DateTime? get dreamDate; DateTime get createdAt; DateTime? get updatedAt; bool get isSynced;
/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DreamEntryCopyWith<DreamEntry> get copyWith => _$DreamEntryCopyWithImpl<DreamEntry>(this as DreamEntry, _$identity);

  /// Serializes this DreamEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DreamEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.category, category) || other.category == category)&&(identical(other.isLucid, isLucid) || other.isLucid == isLucid)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.dreamDate, dreamDate) || other.dreamDate == dreamDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,mood,category,isLucid,isRecurring,const DeepCollectionEquality().hash(tags),dreamDate,createdAt,updatedAt,isSynced);

@override
String toString() {
  return 'DreamEntry(id: $id, content: $content, mood: $mood, category: $category, isLucid: $isLucid, isRecurring: $isRecurring, tags: $tags, dreamDate: $dreamDate, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class $DreamEntryCopyWith<$Res>  {
  factory $DreamEntryCopyWith(DreamEntry value, $Res Function(DreamEntry) _then) = _$DreamEntryCopyWithImpl;
@useResult
$Res call({
 String id, String content, String? mood, String? category, bool isLucid, bool isRecurring, List<String> tags, DateTime? dreamDate, DateTime createdAt, DateTime? updatedAt, bool isSynced
});




}
/// @nodoc
class _$DreamEntryCopyWithImpl<$Res>
    implements $DreamEntryCopyWith<$Res> {
  _$DreamEntryCopyWithImpl(this._self, this._then);

  final DreamEntry _self;
  final $Res Function(DreamEntry) _then;

/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? mood = freezed,Object? category = freezed,Object? isLucid = null,Object? isRecurring = null,Object? tags = null,Object? dreamDate = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? isSynced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isLucid: null == isLucid ? _self.isLucid : isLucid // ignore: cast_nullable_to_non_nullable
as bool,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,dreamDate: freezed == dreamDate ? _self.dreamDate : dreamDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DreamEntry].
extension DreamEntryPatterns on DreamEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DreamEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DreamEntry value)  $default,){
final _that = this;
switch (_that) {
case _DreamEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DreamEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  String? mood,  String? category,  bool isLucid,  bool isRecurring,  List<String> tags,  DateTime? dreamDate,  DateTime createdAt,  DateTime? updatedAt,  bool isSynced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
return $default(_that.id,_that.content,_that.mood,_that.category,_that.isLucid,_that.isRecurring,_that.tags,_that.dreamDate,_that.createdAt,_that.updatedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  String? mood,  String? category,  bool isLucid,  bool isRecurring,  List<String> tags,  DateTime? dreamDate,  DateTime createdAt,  DateTime? updatedAt,  bool isSynced)  $default,) {final _that = this;
switch (_that) {
case _DreamEntry():
return $default(_that.id,_that.content,_that.mood,_that.category,_that.isLucid,_that.isRecurring,_that.tags,_that.dreamDate,_that.createdAt,_that.updatedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  String? mood,  String? category,  bool isLucid,  bool isRecurring,  List<String> tags,  DateTime? dreamDate,  DateTime createdAt,  DateTime? updatedAt,  bool isSynced)?  $default,) {final _that = this;
switch (_that) {
case _DreamEntry() when $default != null:
return $default(_that.id,_that.content,_that.mood,_that.category,_that.isLucid,_that.isRecurring,_that.tags,_that.dreamDate,_that.createdAt,_that.updatedAt,_that.isSynced);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DreamEntry implements DreamEntry {
  const _DreamEntry({required this.id, required this.content, this.mood, this.category, this.isLucid = false, this.isRecurring = false, final  List<String> tags = const [], this.dreamDate, required this.createdAt, this.updatedAt, this.isSynced = false}): _tags = tags;
  factory _DreamEntry.fromJson(Map<String, dynamic> json) => _$DreamEntryFromJson(json);

@override final  String id;
@override final  String content;
@override final  String? mood;
@override final  String? category;
@override@JsonKey() final  bool isLucid;
@override@JsonKey() final  bool isRecurring;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime? dreamDate;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  bool isSynced;

/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DreamEntryCopyWith<_DreamEntry> get copyWith => __$DreamEntryCopyWithImpl<_DreamEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DreamEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DreamEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.category, category) || other.category == category)&&(identical(other.isLucid, isLucid) || other.isLucid == isLucid)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.dreamDate, dreamDate) || other.dreamDate == dreamDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,mood,category,isLucid,isRecurring,const DeepCollectionEquality().hash(_tags),dreamDate,createdAt,updatedAt,isSynced);

@override
String toString() {
  return 'DreamEntry(id: $id, content: $content, mood: $mood, category: $category, isLucid: $isLucid, isRecurring: $isRecurring, tags: $tags, dreamDate: $dreamDate, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class _$DreamEntryCopyWith<$Res> implements $DreamEntryCopyWith<$Res> {
  factory _$DreamEntryCopyWith(_DreamEntry value, $Res Function(_DreamEntry) _then) = __$DreamEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, String? mood, String? category, bool isLucid, bool isRecurring, List<String> tags, DateTime? dreamDate, DateTime createdAt, DateTime? updatedAt, bool isSynced
});




}
/// @nodoc
class __$DreamEntryCopyWithImpl<$Res>
    implements _$DreamEntryCopyWith<$Res> {
  __$DreamEntryCopyWithImpl(this._self, this._then);

  final _DreamEntry _self;
  final $Res Function(_DreamEntry) _then;

/// Create a copy of DreamEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? mood = freezed,Object? category = freezed,Object? isLucid = null,Object? isRecurring = null,Object? tags = null,Object? dreamDate = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? isSynced = null,}) {
  return _then(_DreamEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isLucid: null == isLucid ? _self.isLucid : isLucid // ignore: cast_nullable_to_non_nullable
as bool,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,dreamDate: freezed == dreamDate ? _self.dreamDate : dreamDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
