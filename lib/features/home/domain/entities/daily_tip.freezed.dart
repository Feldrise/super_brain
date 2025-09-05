// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_tip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyTip {

 String get id; String get title; String get content; String get category; DateTime get createdAt; bool get isRead; String? get imageUrl; List<String>? get tags;
/// Create a copy of DailyTip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyTipCopyWith<DailyTip> get copyWith => _$DailyTipCopyWithImpl<DailyTip>(this as DailyTip, _$identity);

  /// Serializes this DailyTip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyTip&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.category, category) || other.category == category)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,category,createdAt,isRead,imageUrl,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'DailyTip(id: $id, title: $title, content: $content, category: $category, createdAt: $createdAt, isRead: $isRead, imageUrl: $imageUrl, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $DailyTipCopyWith<$Res>  {
  factory $DailyTipCopyWith(DailyTip value, $Res Function(DailyTip) _then) = _$DailyTipCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, String category, DateTime createdAt, bool isRead, String? imageUrl, List<String>? tags
});




}
/// @nodoc
class _$DailyTipCopyWithImpl<$Res>
    implements $DailyTipCopyWith<$Res> {
  _$DailyTipCopyWithImpl(this._self, this._then);

  final DailyTip _self;
  final $Res Function(DailyTip) _then;

/// Create a copy of DailyTip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? category = null,Object? createdAt = null,Object? isRead = null,Object? imageUrl = freezed,Object? tags = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyTip].
extension DailyTipPatterns on DailyTip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyTip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyTip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyTip value)  $default,){
final _that = this;
switch (_that) {
case _DailyTip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyTip value)?  $default,){
final _that = this;
switch (_that) {
case _DailyTip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String content,  String category,  DateTime createdAt,  bool isRead,  String? imageUrl,  List<String>? tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyTip() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.category,_that.createdAt,_that.isRead,_that.imageUrl,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String content,  String category,  DateTime createdAt,  bool isRead,  String? imageUrl,  List<String>? tags)  $default,) {final _that = this;
switch (_that) {
case _DailyTip():
return $default(_that.id,_that.title,_that.content,_that.category,_that.createdAt,_that.isRead,_that.imageUrl,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String content,  String category,  DateTime createdAt,  bool isRead,  String? imageUrl,  List<String>? tags)?  $default,) {final _that = this;
switch (_that) {
case _DailyTip() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.category,_that.createdAt,_that.isRead,_that.imageUrl,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyTip implements DailyTip {
  const _DailyTip({required this.id, required this.title, required this.content, required this.category, required this.createdAt, this.isRead = false, this.imageUrl, final  List<String>? tags}): _tags = tags;
  factory _DailyTip.fromJson(Map<String, dynamic> json) => _$DailyTipFromJson(json);

@override final  String id;
@override final  String title;
@override final  String content;
@override final  String category;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isRead;
@override final  String? imageUrl;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of DailyTip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyTipCopyWith<_DailyTip> get copyWith => __$DailyTipCopyWithImpl<_DailyTip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyTipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyTip&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.category, category) || other.category == category)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,category,createdAt,isRead,imageUrl,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'DailyTip(id: $id, title: $title, content: $content, category: $category, createdAt: $createdAt, isRead: $isRead, imageUrl: $imageUrl, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$DailyTipCopyWith<$Res> implements $DailyTipCopyWith<$Res> {
  factory _$DailyTipCopyWith(_DailyTip value, $Res Function(_DailyTip) _then) = __$DailyTipCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, String category, DateTime createdAt, bool isRead, String? imageUrl, List<String>? tags
});




}
/// @nodoc
class __$DailyTipCopyWithImpl<$Res>
    implements _$DailyTipCopyWith<$Res> {
  __$DailyTipCopyWithImpl(this._self, this._then);

  final _DailyTip _self;
  final $Res Function(_DailyTip) _then;

/// Create a copy of DailyTip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? category = null,Object? createdAt = null,Object? isRead = null,Object? imageUrl = freezed,Object? tags = freezed,}) {
  return _then(_DailyTip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
