// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Summary {

 String get id; String get title; String get content;// Markdown content
 int get estimatedReadingTime;// in minutes
 List<String> get keyPoints;// Simple metadata
 DateTime get createdAt; bool get isActive;
/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryCopyWith<Summary> get copyWith => _$SummaryCopyWithImpl<Summary>(this as Summary, _$identity);

  /// Serializes this Summary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Summary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.estimatedReadingTime, estimatedReadingTime) || other.estimatedReadingTime == estimatedReadingTime)&&const DeepCollectionEquality().equals(other.keyPoints, keyPoints)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,estimatedReadingTime,const DeepCollectionEquality().hash(keyPoints),createdAt,isActive);

@override
String toString() {
  return 'Summary(id: $id, title: $title, content: $content, estimatedReadingTime: $estimatedReadingTime, keyPoints: $keyPoints, createdAt: $createdAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $SummaryCopyWith<$Res>  {
  factory $SummaryCopyWith(Summary value, $Res Function(Summary) _then) = _$SummaryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, int estimatedReadingTime, List<String> keyPoints, DateTime createdAt, bool isActive
});




}
/// @nodoc
class _$SummaryCopyWithImpl<$Res>
    implements $SummaryCopyWith<$Res> {
  _$SummaryCopyWithImpl(this._self, this._then);

  final Summary _self;
  final $Res Function(Summary) _then;

/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? estimatedReadingTime = null,Object? keyPoints = null,Object? createdAt = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,estimatedReadingTime: null == estimatedReadingTime ? _self.estimatedReadingTime : estimatedReadingTime // ignore: cast_nullable_to_non_nullable
as int,keyPoints: null == keyPoints ? _self.keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Summary].
extension SummaryPatterns on Summary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Summary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Summary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Summary value)  $default,){
final _that = this;
switch (_that) {
case _Summary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Summary value)?  $default,){
final _that = this;
switch (_that) {
case _Summary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String content,  int estimatedReadingTime,  List<String> keyPoints,  DateTime createdAt,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Summary() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.estimatedReadingTime,_that.keyPoints,_that.createdAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String content,  int estimatedReadingTime,  List<String> keyPoints,  DateTime createdAt,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _Summary():
return $default(_that.id,_that.title,_that.content,_that.estimatedReadingTime,_that.keyPoints,_that.createdAt,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String content,  int estimatedReadingTime,  List<String> keyPoints,  DateTime createdAt,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _Summary() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.estimatedReadingTime,_that.keyPoints,_that.createdAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Summary implements Summary {
  const _Summary({required this.id, required this.title, required this.content, this.estimatedReadingTime = 0, final  List<String> keyPoints = const [], required this.createdAt, this.isActive = true}): _keyPoints = keyPoints;
  factory _Summary.fromJson(Map<String, dynamic> json) => _$SummaryFromJson(json);

@override final  String id;
@override final  String title;
@override final  String content;
// Markdown content
@override@JsonKey() final  int estimatedReadingTime;
// in minutes
 final  List<String> _keyPoints;
// in minutes
@override@JsonKey() List<String> get keyPoints {
  if (_keyPoints is EqualUnmodifiableListView) return _keyPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keyPoints);
}

// Simple metadata
@override final  DateTime createdAt;
@override@JsonKey() final  bool isActive;

/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryCopyWith<_Summary> get copyWith => __$SummaryCopyWithImpl<_Summary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Summary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.estimatedReadingTime, estimatedReadingTime) || other.estimatedReadingTime == estimatedReadingTime)&&const DeepCollectionEquality().equals(other._keyPoints, _keyPoints)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,estimatedReadingTime,const DeepCollectionEquality().hash(_keyPoints),createdAt,isActive);

@override
String toString() {
  return 'Summary(id: $id, title: $title, content: $content, estimatedReadingTime: $estimatedReadingTime, keyPoints: $keyPoints, createdAt: $createdAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$SummaryCopyWith<$Res> implements $SummaryCopyWith<$Res> {
  factory _$SummaryCopyWith(_Summary value, $Res Function(_Summary) _then) = __$SummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, int estimatedReadingTime, List<String> keyPoints, DateTime createdAt, bool isActive
});




}
/// @nodoc
class __$SummaryCopyWithImpl<$Res>
    implements _$SummaryCopyWith<$Res> {
  __$SummaryCopyWithImpl(this._self, this._then);

  final _Summary _self;
  final $Res Function(_Summary) _then;

/// Create a copy of Summary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? estimatedReadingTime = null,Object? keyPoints = null,Object? createdAt = null,Object? isActive = null,}) {
  return _then(_Summary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,estimatedReadingTime: null == estimatedReadingTime ? _self.estimatedReadingTime : estimatedReadingTime // ignore: cast_nullable_to_non_nullable
as int,keyPoints: null == keyPoints ? _self._keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
