// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WordList {

 String get id; String get title; List<String> get words; String get difficulty; DateTime? get nextReviewAt; double get easiness; int get interval; int get reps; DateTime get createdAt; String? get category; bool get isUserCreated; bool get isActive; bool get isLearned; DateTime? get learnedAt; int get completedSessions; double get averageScore;
/// Create a copy of WordList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordListCopyWith<WordList> get copyWith => _$WordListCopyWithImpl<WordList>(this as WordList, _$identity);

  /// Serializes this WordList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordList&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.words, words)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.nextReviewAt, nextReviewAt) || other.nextReviewAt == nextReviewAt)&&(identical(other.easiness, easiness) || other.easiness == easiness)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.isUserCreated, isUserCreated) || other.isUserCreated == isUserCreated)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isLearned, isLearned) || other.isLearned == isLearned)&&(identical(other.learnedAt, learnedAt) || other.learnedAt == learnedAt)&&(identical(other.completedSessions, completedSessions) || other.completedSessions == completedSessions)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(words),difficulty,nextReviewAt,easiness,interval,reps,createdAt,category,isUserCreated,isActive,isLearned,learnedAt,completedSessions,averageScore);

@override
String toString() {
  return 'WordList(id: $id, title: $title, words: $words, difficulty: $difficulty, nextReviewAt: $nextReviewAt, easiness: $easiness, interval: $interval, reps: $reps, createdAt: $createdAt, category: $category, isUserCreated: $isUserCreated, isActive: $isActive, isLearned: $isLearned, learnedAt: $learnedAt, completedSessions: $completedSessions, averageScore: $averageScore)';
}


}

/// @nodoc
abstract mixin class $WordListCopyWith<$Res>  {
  factory $WordListCopyWith(WordList value, $Res Function(WordList) _then) = _$WordListCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<String> words, String difficulty, DateTime? nextReviewAt, double easiness, int interval, int reps, DateTime createdAt, String? category, bool isUserCreated, bool isActive, bool isLearned, DateTime? learnedAt, int completedSessions, double averageScore
});




}
/// @nodoc
class _$WordListCopyWithImpl<$Res>
    implements $WordListCopyWith<$Res> {
  _$WordListCopyWithImpl(this._self, this._then);

  final WordList _self;
  final $Res Function(WordList) _then;

/// Create a copy of WordList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? words = null,Object? difficulty = null,Object? nextReviewAt = freezed,Object? easiness = null,Object? interval = null,Object? reps = null,Object? createdAt = null,Object? category = freezed,Object? isUserCreated = null,Object? isActive = null,Object? isLearned = null,Object? learnedAt = freezed,Object? completedSessions = null,Object? averageScore = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,words: null == words ? _self.words : words // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,nextReviewAt: freezed == nextReviewAt ? _self.nextReviewAt : nextReviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,easiness: null == easiness ? _self.easiness : easiness // ignore: cast_nullable_to_non_nullable
as double,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isUserCreated: null == isUserCreated ? _self.isUserCreated : isUserCreated // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isLearned: null == isLearned ? _self.isLearned : isLearned // ignore: cast_nullable_to_non_nullable
as bool,learnedAt: freezed == learnedAt ? _self.learnedAt : learnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WordList].
extension WordListPatterns on WordList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordList value)  $default,){
final _that = this;
switch (_that) {
case _WordList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordList value)?  $default,){
final _that = this;
switch (_that) {
case _WordList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<String> words,  String difficulty,  DateTime? nextReviewAt,  double easiness,  int interval,  int reps,  DateTime createdAt,  String? category,  bool isUserCreated,  bool isActive,  bool isLearned,  DateTime? learnedAt,  int completedSessions,  double averageScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordList() when $default != null:
return $default(_that.id,_that.title,_that.words,_that.difficulty,_that.nextReviewAt,_that.easiness,_that.interval,_that.reps,_that.createdAt,_that.category,_that.isUserCreated,_that.isActive,_that.isLearned,_that.learnedAt,_that.completedSessions,_that.averageScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<String> words,  String difficulty,  DateTime? nextReviewAt,  double easiness,  int interval,  int reps,  DateTime createdAt,  String? category,  bool isUserCreated,  bool isActive,  bool isLearned,  DateTime? learnedAt,  int completedSessions,  double averageScore)  $default,) {final _that = this;
switch (_that) {
case _WordList():
return $default(_that.id,_that.title,_that.words,_that.difficulty,_that.nextReviewAt,_that.easiness,_that.interval,_that.reps,_that.createdAt,_that.category,_that.isUserCreated,_that.isActive,_that.isLearned,_that.learnedAt,_that.completedSessions,_that.averageScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<String> words,  String difficulty,  DateTime? nextReviewAt,  double easiness,  int interval,  int reps,  DateTime createdAt,  String? category,  bool isUserCreated,  bool isActive,  bool isLearned,  DateTime? learnedAt,  int completedSessions,  double averageScore)?  $default,) {final _that = this;
switch (_that) {
case _WordList() when $default != null:
return $default(_that.id,_that.title,_that.words,_that.difficulty,_that.nextReviewAt,_that.easiness,_that.interval,_that.reps,_that.createdAt,_that.category,_that.isUserCreated,_that.isActive,_that.isLearned,_that.learnedAt,_that.completedSessions,_that.averageScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordList implements WordList {
  const _WordList({required this.id, required this.title, required final  List<String> words, this.difficulty = 'Moyen', this.nextReviewAt, this.easiness = 2.5, this.interval = 1, this.reps = 0, required this.createdAt, this.category, this.isUserCreated = false, this.isActive = true, this.isLearned = false, this.learnedAt, this.completedSessions = 0, this.averageScore = 0}): _words = words;
  factory _WordList.fromJson(Map<String, dynamic> json) => _$WordListFromJson(json);

@override final  String id;
@override final  String title;
 final  List<String> _words;
@override List<String> get words {
  if (_words is EqualUnmodifiableListView) return _words;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_words);
}

@override@JsonKey() final  String difficulty;
@override final  DateTime? nextReviewAt;
@override@JsonKey() final  double easiness;
@override@JsonKey() final  int interval;
@override@JsonKey() final  int reps;
@override final  DateTime createdAt;
@override final  String? category;
@override@JsonKey() final  bool isUserCreated;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isLearned;
@override final  DateTime? learnedAt;
@override@JsonKey() final  int completedSessions;
@override@JsonKey() final  double averageScore;

/// Create a copy of WordList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordListCopyWith<_WordList> get copyWith => __$WordListCopyWithImpl<_WordList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordList&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._words, _words)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.nextReviewAt, nextReviewAt) || other.nextReviewAt == nextReviewAt)&&(identical(other.easiness, easiness) || other.easiness == easiness)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.isUserCreated, isUserCreated) || other.isUserCreated == isUserCreated)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isLearned, isLearned) || other.isLearned == isLearned)&&(identical(other.learnedAt, learnedAt) || other.learnedAt == learnedAt)&&(identical(other.completedSessions, completedSessions) || other.completedSessions == completedSessions)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_words),difficulty,nextReviewAt,easiness,interval,reps,createdAt,category,isUserCreated,isActive,isLearned,learnedAt,completedSessions,averageScore);

@override
String toString() {
  return 'WordList(id: $id, title: $title, words: $words, difficulty: $difficulty, nextReviewAt: $nextReviewAt, easiness: $easiness, interval: $interval, reps: $reps, createdAt: $createdAt, category: $category, isUserCreated: $isUserCreated, isActive: $isActive, isLearned: $isLearned, learnedAt: $learnedAt, completedSessions: $completedSessions, averageScore: $averageScore)';
}


}

/// @nodoc
abstract mixin class _$WordListCopyWith<$Res> implements $WordListCopyWith<$Res> {
  factory _$WordListCopyWith(_WordList value, $Res Function(_WordList) _then) = __$WordListCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<String> words, String difficulty, DateTime? nextReviewAt, double easiness, int interval, int reps, DateTime createdAt, String? category, bool isUserCreated, bool isActive, bool isLearned, DateTime? learnedAt, int completedSessions, double averageScore
});




}
/// @nodoc
class __$WordListCopyWithImpl<$Res>
    implements _$WordListCopyWith<$Res> {
  __$WordListCopyWithImpl(this._self, this._then);

  final _WordList _self;
  final $Res Function(_WordList) _then;

/// Create a copy of WordList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? words = null,Object? difficulty = null,Object? nextReviewAt = freezed,Object? easiness = null,Object? interval = null,Object? reps = null,Object? createdAt = null,Object? category = freezed,Object? isUserCreated = null,Object? isActive = null,Object? isLearned = null,Object? learnedAt = freezed,Object? completedSessions = null,Object? averageScore = null,}) {
  return _then(_WordList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,words: null == words ? _self._words : words // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,nextReviewAt: freezed == nextReviewAt ? _self.nextReviewAt : nextReviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,easiness: null == easiness ? _self.easiness : easiness // ignore: cast_nullable_to_non_nullable
as double,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,isUserCreated: null == isUserCreated ? _self.isUserCreated : isUserCreated // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isLearned: null == isLearned ? _self.isLearned : isLearned // ignore: cast_nullable_to_non_nullable
as bool,learnedAt: freezed == learnedAt ? _self.learnedAt : learnedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$StudySession {

 String get id; String get userId; String get wordListId; DateTime get startedAt; DateTime? get completedAt; List<WordResult> get results; bool get isCompleted; int? get finalScore; int? get totalTimeSeconds;
/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudySessionCopyWith<StudySession> get copyWith => _$StudySessionCopyWithImpl<StudySession>(this as StudySession, _$identity);

  /// Serializes this StudySession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudySession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.wordListId, wordListId) || other.wordListId == wordListId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.totalTimeSeconds, totalTimeSeconds) || other.totalTimeSeconds == totalTimeSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,wordListId,startedAt,completedAt,const DeepCollectionEquality().hash(results),isCompleted,finalScore,totalTimeSeconds);

@override
String toString() {
  return 'StudySession(id: $id, userId: $userId, wordListId: $wordListId, startedAt: $startedAt, completedAt: $completedAt, results: $results, isCompleted: $isCompleted, finalScore: $finalScore, totalTimeSeconds: $totalTimeSeconds)';
}


}

/// @nodoc
abstract mixin class $StudySessionCopyWith<$Res>  {
  factory $StudySessionCopyWith(StudySession value, $Res Function(StudySession) _then) = _$StudySessionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String wordListId, DateTime startedAt, DateTime? completedAt, List<WordResult> results, bool isCompleted, int? finalScore, int? totalTimeSeconds
});




}
/// @nodoc
class _$StudySessionCopyWithImpl<$Res>
    implements $StudySessionCopyWith<$Res> {
  _$StudySessionCopyWithImpl(this._self, this._then);

  final StudySession _self;
  final $Res Function(StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? wordListId = null,Object? startedAt = null,Object? completedAt = freezed,Object? results = null,Object? isCompleted = null,Object? finalScore = freezed,Object? totalTimeSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,wordListId: null == wordListId ? _self.wordListId : wordListId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<WordResult>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,finalScore: freezed == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int?,totalTimeSeconds: freezed == totalTimeSeconds ? _self.totalTimeSeconds : totalTimeSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudySession].
extension StudySessionPatterns on StudySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudySession value)  $default,){
final _that = this;
switch (_that) {
case _StudySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudySession value)?  $default,){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String wordListId,  DateTime startedAt,  DateTime? completedAt,  List<WordResult> results,  bool isCompleted,  int? finalScore,  int? totalTimeSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.userId,_that.wordListId,_that.startedAt,_that.completedAt,_that.results,_that.isCompleted,_that.finalScore,_that.totalTimeSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String wordListId,  DateTime startedAt,  DateTime? completedAt,  List<WordResult> results,  bool isCompleted,  int? finalScore,  int? totalTimeSeconds)  $default,) {final _that = this;
switch (_that) {
case _StudySession():
return $default(_that.id,_that.userId,_that.wordListId,_that.startedAt,_that.completedAt,_that.results,_that.isCompleted,_that.finalScore,_that.totalTimeSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String wordListId,  DateTime startedAt,  DateTime? completedAt,  List<WordResult> results,  bool isCompleted,  int? finalScore,  int? totalTimeSeconds)?  $default,) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.userId,_that.wordListId,_that.startedAt,_that.completedAt,_that.results,_that.isCompleted,_that.finalScore,_that.totalTimeSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudySession implements StudySession {
  const _StudySession({required this.id, required this.userId, required this.wordListId, required this.startedAt, this.completedAt, required final  List<WordResult> results, this.isCompleted = false, this.finalScore, this.totalTimeSeconds}): _results = results;
  factory _StudySession.fromJson(Map<String, dynamic> json) => _$StudySessionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String wordListId;
@override final  DateTime startedAt;
@override final  DateTime? completedAt;
 final  List<WordResult> _results;
@override List<WordResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override@JsonKey() final  bool isCompleted;
@override final  int? finalScore;
@override final  int? totalTimeSeconds;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudySessionCopyWith<_StudySession> get copyWith => __$StudySessionCopyWithImpl<_StudySession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudySessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudySession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.wordListId, wordListId) || other.wordListId == wordListId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.totalTimeSeconds, totalTimeSeconds) || other.totalTimeSeconds == totalTimeSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,wordListId,startedAt,completedAt,const DeepCollectionEquality().hash(_results),isCompleted,finalScore,totalTimeSeconds);

@override
String toString() {
  return 'StudySession(id: $id, userId: $userId, wordListId: $wordListId, startedAt: $startedAt, completedAt: $completedAt, results: $results, isCompleted: $isCompleted, finalScore: $finalScore, totalTimeSeconds: $totalTimeSeconds)';
}


}

/// @nodoc
abstract mixin class _$StudySessionCopyWith<$Res> implements $StudySessionCopyWith<$Res> {
  factory _$StudySessionCopyWith(_StudySession value, $Res Function(_StudySession) _then) = __$StudySessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String wordListId, DateTime startedAt, DateTime? completedAt, List<WordResult> results, bool isCompleted, int? finalScore, int? totalTimeSeconds
});




}
/// @nodoc
class __$StudySessionCopyWithImpl<$Res>
    implements _$StudySessionCopyWith<$Res> {
  __$StudySessionCopyWithImpl(this._self, this._then);

  final _StudySession _self;
  final $Res Function(_StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? wordListId = null,Object? startedAt = null,Object? completedAt = freezed,Object? results = null,Object? isCompleted = null,Object? finalScore = freezed,Object? totalTimeSeconds = freezed,}) {
  return _then(_StudySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,wordListId: null == wordListId ? _self.wordListId : wordListId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<WordResult>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,finalScore: freezed == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as int?,totalTimeSeconds: freezed == totalTimeSeconds ? _self.totalTimeSeconds : totalTimeSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$WordResult {

 String get word; bool get wasCorrect; int get timeSpentSeconds; int? get attempts;
/// Create a copy of WordResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordResultCopyWith<WordResult> get copyWith => _$WordResultCopyWithImpl<WordResult>(this as WordResult, _$identity);

  /// Serializes this WordResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordResult&&(identical(other.word, word) || other.word == word)&&(identical(other.wasCorrect, wasCorrect) || other.wasCorrect == wasCorrect)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds)&&(identical(other.attempts, attempts) || other.attempts == attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,word,wasCorrect,timeSpentSeconds,attempts);

@override
String toString() {
  return 'WordResult(word: $word, wasCorrect: $wasCorrect, timeSpentSeconds: $timeSpentSeconds, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class $WordResultCopyWith<$Res>  {
  factory $WordResultCopyWith(WordResult value, $Res Function(WordResult) _then) = _$WordResultCopyWithImpl;
@useResult
$Res call({
 String word, bool wasCorrect, int timeSpentSeconds, int? attempts
});




}
/// @nodoc
class _$WordResultCopyWithImpl<$Res>
    implements $WordResultCopyWith<$Res> {
  _$WordResultCopyWithImpl(this._self, this._then);

  final WordResult _self;
  final $Res Function(WordResult) _then;

/// Create a copy of WordResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? wasCorrect = null,Object? timeSpentSeconds = null,Object? attempts = freezed,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,wasCorrect: null == wasCorrect ? _self.wasCorrect : wasCorrect // ignore: cast_nullable_to_non_nullable
as bool,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,attempts: freezed == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordResult].
extension WordResultPatterns on WordResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordResult value)  $default,){
final _that = this;
switch (_that) {
case _WordResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordResult value)?  $default,){
final _that = this;
switch (_that) {
case _WordResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  bool wasCorrect,  int timeSpentSeconds,  int? attempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordResult() when $default != null:
return $default(_that.word,_that.wasCorrect,_that.timeSpentSeconds,_that.attempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  bool wasCorrect,  int timeSpentSeconds,  int? attempts)  $default,) {final _that = this;
switch (_that) {
case _WordResult():
return $default(_that.word,_that.wasCorrect,_that.timeSpentSeconds,_that.attempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  bool wasCorrect,  int timeSpentSeconds,  int? attempts)?  $default,) {final _that = this;
switch (_that) {
case _WordResult() when $default != null:
return $default(_that.word,_that.wasCorrect,_that.timeSpentSeconds,_that.attempts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordResult implements WordResult {
  const _WordResult({required this.word, required this.wasCorrect, required this.timeSpentSeconds, this.attempts});
  factory _WordResult.fromJson(Map<String, dynamic> json) => _$WordResultFromJson(json);

@override final  String word;
@override final  bool wasCorrect;
@override final  int timeSpentSeconds;
@override final  int? attempts;

/// Create a copy of WordResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordResultCopyWith<_WordResult> get copyWith => __$WordResultCopyWithImpl<_WordResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordResult&&(identical(other.word, word) || other.word == word)&&(identical(other.wasCorrect, wasCorrect) || other.wasCorrect == wasCorrect)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds)&&(identical(other.attempts, attempts) || other.attempts == attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,word,wasCorrect,timeSpentSeconds,attempts);

@override
String toString() {
  return 'WordResult(word: $word, wasCorrect: $wasCorrect, timeSpentSeconds: $timeSpentSeconds, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class _$WordResultCopyWith<$Res> implements $WordResultCopyWith<$Res> {
  factory _$WordResultCopyWith(_WordResult value, $Res Function(_WordResult) _then) = __$WordResultCopyWithImpl;
@override @useResult
$Res call({
 String word, bool wasCorrect, int timeSpentSeconds, int? attempts
});




}
/// @nodoc
class __$WordResultCopyWithImpl<$Res>
    implements _$WordResultCopyWith<$Res> {
  __$WordResultCopyWithImpl(this._self, this._then);

  final _WordResult _self;
  final $Res Function(_WordResult) _then;

/// Create a copy of WordResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? wasCorrect = null,Object? timeSpentSeconds = null,Object? attempts = freezed,}) {
  return _then(_WordResult(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,wasCorrect: null == wasCorrect ? _self.wasCorrect : wasCorrect // ignore: cast_nullable_to_non_nullable
as bool,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,attempts: freezed == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
