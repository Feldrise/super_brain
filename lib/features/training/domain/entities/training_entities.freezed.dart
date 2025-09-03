// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Exercise {

 String get id; String get name; String get description; ExerciseType get type; int get duration;// Duration in seconds for timed exercises or rest
 int? get targetReps;// Target repetitions for reps-based exercises
 String? get instructions; String? get imageUrl; String? get videoUrl; List<String> get muscleGroups; List<String> get equipment;
/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseCopyWith<Exercise> get copyWith => _$ExerciseCopyWithImpl<Exercise>(this as Exercise, _$identity);

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exercise&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other.muscleGroups, muscleGroups)&&const DeepCollectionEquality().equals(other.equipment, equipment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,duration,targetReps,instructions,imageUrl,videoUrl,const DeepCollectionEquality().hash(muscleGroups),const DeepCollectionEquality().hash(equipment));

@override
String toString() {
  return 'Exercise(id: $id, name: $name, description: $description, type: $type, duration: $duration, targetReps: $targetReps, instructions: $instructions, imageUrl: $imageUrl, videoUrl: $videoUrl, muscleGroups: $muscleGroups, equipment: $equipment)';
}


}

/// @nodoc
abstract mixin class $ExerciseCopyWith<$Res>  {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) _then) = _$ExerciseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, ExerciseType type, int duration, int? targetReps, String? instructions, String? imageUrl, String? videoUrl, List<String> muscleGroups, List<String> equipment
});




}
/// @nodoc
class _$ExerciseCopyWithImpl<$Res>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._self, this._then);

  final Exercise _self;
  final $Res Function(Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? duration = null,Object? targetReps = freezed,Object? instructions = freezed,Object? imageUrl = freezed,Object? videoUrl = freezed,Object? muscleGroups = null,Object? equipment = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,targetReps: freezed == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,muscleGroups: null == muscleGroups ? _self.muscleGroups : muscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Exercise].
extension ExercisePatterns on Exercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Exercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Exercise value)  $default,){
final _that = this;
switch (_that) {
case _Exercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Exercise value)?  $default,){
final _that = this;
switch (_that) {
case _Exercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  ExerciseType type,  int duration,  int? targetReps,  String? instructions,  String? imageUrl,  String? videoUrl,  List<String> muscleGroups,  List<String> equipment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.duration,_that.targetReps,_that.instructions,_that.imageUrl,_that.videoUrl,_that.muscleGroups,_that.equipment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  ExerciseType type,  int duration,  int? targetReps,  String? instructions,  String? imageUrl,  String? videoUrl,  List<String> muscleGroups,  List<String> equipment)  $default,) {final _that = this;
switch (_that) {
case _Exercise():
return $default(_that.id,_that.name,_that.description,_that.type,_that.duration,_that.targetReps,_that.instructions,_that.imageUrl,_that.videoUrl,_that.muscleGroups,_that.equipment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  ExerciseType type,  int duration,  int? targetReps,  String? instructions,  String? imageUrl,  String? videoUrl,  List<String> muscleGroups,  List<String> equipment)?  $default,) {final _that = this;
switch (_that) {
case _Exercise() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.duration,_that.targetReps,_that.instructions,_that.imageUrl,_that.videoUrl,_that.muscleGroups,_that.equipment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Exercise implements Exercise {
  const _Exercise({required this.id, required this.name, required this.description, required this.type, required this.duration, this.targetReps, this.instructions, this.imageUrl, this.videoUrl, final  List<String> muscleGroups = const [], final  List<String> equipment = const []}): _muscleGroups = muscleGroups,_equipment = equipment;
  factory _Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  ExerciseType type;
@override final  int duration;
// Duration in seconds for timed exercises or rest
@override final  int? targetReps;
// Target repetitions for reps-based exercises
@override final  String? instructions;
@override final  String? imageUrl;
@override final  String? videoUrl;
 final  List<String> _muscleGroups;
@override@JsonKey() List<String> get muscleGroups {
  if (_muscleGroups is EqualUnmodifiableListView) return _muscleGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_muscleGroups);
}

 final  List<String> _equipment;
@override@JsonKey() List<String> get equipment {
  if (_equipment is EqualUnmodifiableListView) return _equipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipment);
}


/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseCopyWith<_Exercise> get copyWith => __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exercise&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.targetReps, targetReps) || other.targetReps == targetReps)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other._muscleGroups, _muscleGroups)&&const DeepCollectionEquality().equals(other._equipment, _equipment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,duration,targetReps,instructions,imageUrl,videoUrl,const DeepCollectionEquality().hash(_muscleGroups),const DeepCollectionEquality().hash(_equipment));

@override
String toString() {
  return 'Exercise(id: $id, name: $name, description: $description, type: $type, duration: $duration, targetReps: $targetReps, instructions: $instructions, imageUrl: $imageUrl, videoUrl: $videoUrl, muscleGroups: $muscleGroups, equipment: $equipment)';
}


}

/// @nodoc
abstract mixin class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) _then) = __$ExerciseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, ExerciseType type, int duration, int? targetReps, String? instructions, String? imageUrl, String? videoUrl, List<String> muscleGroups, List<String> equipment
});




}
/// @nodoc
class __$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(this._self, this._then);

  final _Exercise _self;
  final $Res Function(_Exercise) _then;

/// Create a copy of Exercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? duration = null,Object? targetReps = freezed,Object? instructions = freezed,Object? imageUrl = freezed,Object? videoUrl = freezed,Object? muscleGroups = null,Object? equipment = null,}) {
  return _then(_Exercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,targetReps: freezed == targetReps ? _self.targetReps : targetReps // ignore: cast_nullable_to_non_nullable
as int?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,muscleGroups: null == muscleGroups ? _self._muscleGroups : muscleGroups // ignore: cast_nullable_to_non_nullable
as List<String>,equipment: null == equipment ? _self._equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$TrainingPlan {

 String get id; String get name; String get description; TrainingCategory get category; TrainingDifficulty get difficulty; int get estimatedDuration;// Total duration in minutes
 List<Exercise> get exercises; String? get imageUrl; List<String> get tags; bool get isActive; DateTime? get createdAt;
/// Create a copy of TrainingPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingPlanCopyWith<TrainingPlan> get copyWith => _$TrainingPlanCopyWithImpl<TrainingPlan>(this as TrainingPlan, _$identity);

  /// Serializes this TrainingPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&const DeepCollectionEquality().equals(other.exercises, exercises)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,difficulty,estimatedDuration,const DeepCollectionEquality().hash(exercises),imageUrl,const DeepCollectionEquality().hash(tags),isActive,createdAt);

@override
String toString() {
  return 'TrainingPlan(id: $id, name: $name, description: $description, category: $category, difficulty: $difficulty, estimatedDuration: $estimatedDuration, exercises: $exercises, imageUrl: $imageUrl, tags: $tags, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TrainingPlanCopyWith<$Res>  {
  factory $TrainingPlanCopyWith(TrainingPlan value, $Res Function(TrainingPlan) _then) = _$TrainingPlanCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, TrainingCategory category, TrainingDifficulty difficulty, int estimatedDuration, List<Exercise> exercises, String? imageUrl, List<String> tags, bool isActive, DateTime? createdAt
});




}
/// @nodoc
class _$TrainingPlanCopyWithImpl<$Res>
    implements $TrainingPlanCopyWith<$Res> {
  _$TrainingPlanCopyWithImpl(this._self, this._then);

  final TrainingPlan _self;
  final $Res Function(TrainingPlan) _then;

/// Create a copy of TrainingPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? difficulty = null,Object? estimatedDuration = null,Object? exercises = null,Object? imageUrl = freezed,Object? tags = null,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TrainingCategory,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as TrainingDifficulty,estimatedDuration: null == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingPlan].
extension TrainingPlanPatterns on TrainingPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingPlan value)  $default,){
final _that = this;
switch (_that) {
case _TrainingPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingPlan value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  TrainingCategory category,  TrainingDifficulty difficulty,  int estimatedDuration,  List<Exercise> exercises,  String? imageUrl,  List<String> tags,  bool isActive,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingPlan() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.difficulty,_that.estimatedDuration,_that.exercises,_that.imageUrl,_that.tags,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  TrainingCategory category,  TrainingDifficulty difficulty,  int estimatedDuration,  List<Exercise> exercises,  String? imageUrl,  List<String> tags,  bool isActive,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingPlan():
return $default(_that.id,_that.name,_that.description,_that.category,_that.difficulty,_that.estimatedDuration,_that.exercises,_that.imageUrl,_that.tags,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  TrainingCategory category,  TrainingDifficulty difficulty,  int estimatedDuration,  List<Exercise> exercises,  String? imageUrl,  List<String> tags,  bool isActive,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingPlan() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.difficulty,_that.estimatedDuration,_that.exercises,_that.imageUrl,_that.tags,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingPlan implements TrainingPlan {
  const _TrainingPlan({required this.id, required this.name, required this.description, required this.category, required this.difficulty, required this.estimatedDuration, required final  List<Exercise> exercises, this.imageUrl, final  List<String> tags = const [], this.isActive = true, this.createdAt}): _exercises = exercises,_tags = tags;
  factory _TrainingPlan.fromJson(Map<String, dynamic> json) => _$TrainingPlanFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  TrainingCategory category;
@override final  TrainingDifficulty difficulty;
@override final  int estimatedDuration;
// Total duration in minutes
 final  List<Exercise> _exercises;
// Total duration in minutes
@override List<Exercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@override final  String? imageUrl;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool isActive;
@override final  DateTime? createdAt;

/// Create a copy of TrainingPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingPlanCopyWith<_TrainingPlan> get copyWith => __$TrainingPlanCopyWithImpl<_TrainingPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,category,difficulty,estimatedDuration,const DeepCollectionEquality().hash(_exercises),imageUrl,const DeepCollectionEquality().hash(_tags),isActive,createdAt);

@override
String toString() {
  return 'TrainingPlan(id: $id, name: $name, description: $description, category: $category, difficulty: $difficulty, estimatedDuration: $estimatedDuration, exercises: $exercises, imageUrl: $imageUrl, tags: $tags, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingPlanCopyWith<$Res> implements $TrainingPlanCopyWith<$Res> {
  factory _$TrainingPlanCopyWith(_TrainingPlan value, $Res Function(_TrainingPlan) _then) = __$TrainingPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, TrainingCategory category, TrainingDifficulty difficulty, int estimatedDuration, List<Exercise> exercises, String? imageUrl, List<String> tags, bool isActive, DateTime? createdAt
});




}
/// @nodoc
class __$TrainingPlanCopyWithImpl<$Res>
    implements _$TrainingPlanCopyWith<$Res> {
  __$TrainingPlanCopyWithImpl(this._self, this._then);

  final _TrainingPlan _self;
  final $Res Function(_TrainingPlan) _then;

/// Create a copy of TrainingPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? category = null,Object? difficulty = null,Object? estimatedDuration = null,Object? exercises = null,Object? imageUrl = freezed,Object? tags = null,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_TrainingPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TrainingCategory,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as TrainingDifficulty,estimatedDuration: null == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TrainingSession {

 String get id; String get userId; String get planId; String get planName; TrainingCategory get category; TrainingDifficulty get difficulty; DateTime get startedAt; DateTime? get completedAt; int get plannedDuration;// Original planned duration in seconds
 int? get actualDuration;// Actual duration completed in seconds
 List<ExerciseResult> get exerciseResults; bool get isCompleted; int? get userRating;// User rating 1-5 after completion
 String? get notes;
/// Create a copy of TrainingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingSessionCopyWith<TrainingSession> get copyWith => _$TrainingSessionCopyWithImpl<TrainingSession>(this as TrainingSession, _$identity);

  /// Serializes this TrainingSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.plannedDuration, plannedDuration) || other.plannedDuration == plannedDuration)&&(identical(other.actualDuration, actualDuration) || other.actualDuration == actualDuration)&&const DeepCollectionEquality().equals(other.exerciseResults, exerciseResults)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.userRating, userRating) || other.userRating == userRating)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,planName,category,difficulty,startedAt,completedAt,plannedDuration,actualDuration,const DeepCollectionEquality().hash(exerciseResults),isCompleted,userRating,notes);

@override
String toString() {
  return 'TrainingSession(id: $id, userId: $userId, planId: $planId, planName: $planName, category: $category, difficulty: $difficulty, startedAt: $startedAt, completedAt: $completedAt, plannedDuration: $plannedDuration, actualDuration: $actualDuration, exerciseResults: $exerciseResults, isCompleted: $isCompleted, userRating: $userRating, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $TrainingSessionCopyWith<$Res>  {
  factory $TrainingSessionCopyWith(TrainingSession value, $Res Function(TrainingSession) _then) = _$TrainingSessionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String planId, String planName, TrainingCategory category, TrainingDifficulty difficulty, DateTime startedAt, DateTime? completedAt, int plannedDuration, int? actualDuration, List<ExerciseResult> exerciseResults, bool isCompleted, int? userRating, String? notes
});




}
/// @nodoc
class _$TrainingSessionCopyWithImpl<$Res>
    implements $TrainingSessionCopyWith<$Res> {
  _$TrainingSessionCopyWithImpl(this._self, this._then);

  final TrainingSession _self;
  final $Res Function(TrainingSession) _then;

/// Create a copy of TrainingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? planId = null,Object? planName = null,Object? category = null,Object? difficulty = null,Object? startedAt = null,Object? completedAt = freezed,Object? plannedDuration = null,Object? actualDuration = freezed,Object? exerciseResults = null,Object? isCompleted = null,Object? userRating = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TrainingCategory,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as TrainingDifficulty,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,plannedDuration: null == plannedDuration ? _self.plannedDuration : plannedDuration // ignore: cast_nullable_to_non_nullable
as int,actualDuration: freezed == actualDuration ? _self.actualDuration : actualDuration // ignore: cast_nullable_to_non_nullable
as int?,exerciseResults: null == exerciseResults ? _self.exerciseResults : exerciseResults // ignore: cast_nullable_to_non_nullable
as List<ExerciseResult>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,userRating: freezed == userRating ? _self.userRating : userRating // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingSession].
extension TrainingSessionPatterns on TrainingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingSession value)  $default,){
final _that = this;
switch (_that) {
case _TrainingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingSession value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String planId,  String planName,  TrainingCategory category,  TrainingDifficulty difficulty,  DateTime startedAt,  DateTime? completedAt,  int plannedDuration,  int? actualDuration,  List<ExerciseResult> exerciseResults,  bool isCompleted,  int? userRating,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingSession() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.planName,_that.category,_that.difficulty,_that.startedAt,_that.completedAt,_that.plannedDuration,_that.actualDuration,_that.exerciseResults,_that.isCompleted,_that.userRating,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String planId,  String planName,  TrainingCategory category,  TrainingDifficulty difficulty,  DateTime startedAt,  DateTime? completedAt,  int plannedDuration,  int? actualDuration,  List<ExerciseResult> exerciseResults,  bool isCompleted,  int? userRating,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _TrainingSession():
return $default(_that.id,_that.userId,_that.planId,_that.planName,_that.category,_that.difficulty,_that.startedAt,_that.completedAt,_that.plannedDuration,_that.actualDuration,_that.exerciseResults,_that.isCompleted,_that.userRating,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String planId,  String planName,  TrainingCategory category,  TrainingDifficulty difficulty,  DateTime startedAt,  DateTime? completedAt,  int plannedDuration,  int? actualDuration,  List<ExerciseResult> exerciseResults,  bool isCompleted,  int? userRating,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _TrainingSession() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.planName,_that.category,_that.difficulty,_that.startedAt,_that.completedAt,_that.plannedDuration,_that.actualDuration,_that.exerciseResults,_that.isCompleted,_that.userRating,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingSession implements TrainingSession {
  const _TrainingSession({required this.id, required this.userId, required this.planId, required this.planName, required this.category, required this.difficulty, required this.startedAt, this.completedAt, required this.plannedDuration, this.actualDuration, final  List<ExerciseResult> exerciseResults = const [], this.isCompleted = false, this.userRating, this.notes}): _exerciseResults = exerciseResults;
  factory _TrainingSession.fromJson(Map<String, dynamic> json) => _$TrainingSessionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String planId;
@override final  String planName;
@override final  TrainingCategory category;
@override final  TrainingDifficulty difficulty;
@override final  DateTime startedAt;
@override final  DateTime? completedAt;
@override final  int plannedDuration;
// Original planned duration in seconds
@override final  int? actualDuration;
// Actual duration completed in seconds
 final  List<ExerciseResult> _exerciseResults;
// Actual duration completed in seconds
@override@JsonKey() List<ExerciseResult> get exerciseResults {
  if (_exerciseResults is EqualUnmodifiableListView) return _exerciseResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exerciseResults);
}

@override@JsonKey() final  bool isCompleted;
@override final  int? userRating;
// User rating 1-5 after completion
@override final  String? notes;

/// Create a copy of TrainingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingSessionCopyWith<_TrainingSession> get copyWith => __$TrainingSessionCopyWithImpl<_TrainingSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.category, category) || other.category == category)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.plannedDuration, plannedDuration) || other.plannedDuration == plannedDuration)&&(identical(other.actualDuration, actualDuration) || other.actualDuration == actualDuration)&&const DeepCollectionEquality().equals(other._exerciseResults, _exerciseResults)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.userRating, userRating) || other.userRating == userRating)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,planName,category,difficulty,startedAt,completedAt,plannedDuration,actualDuration,const DeepCollectionEquality().hash(_exerciseResults),isCompleted,userRating,notes);

@override
String toString() {
  return 'TrainingSession(id: $id, userId: $userId, planId: $planId, planName: $planName, category: $category, difficulty: $difficulty, startedAt: $startedAt, completedAt: $completedAt, plannedDuration: $plannedDuration, actualDuration: $actualDuration, exerciseResults: $exerciseResults, isCompleted: $isCompleted, userRating: $userRating, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$TrainingSessionCopyWith<$Res> implements $TrainingSessionCopyWith<$Res> {
  factory _$TrainingSessionCopyWith(_TrainingSession value, $Res Function(_TrainingSession) _then) = __$TrainingSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String planId, String planName, TrainingCategory category, TrainingDifficulty difficulty, DateTime startedAt, DateTime? completedAt, int plannedDuration, int? actualDuration, List<ExerciseResult> exerciseResults, bool isCompleted, int? userRating, String? notes
});




}
/// @nodoc
class __$TrainingSessionCopyWithImpl<$Res>
    implements _$TrainingSessionCopyWith<$Res> {
  __$TrainingSessionCopyWithImpl(this._self, this._then);

  final _TrainingSession _self;
  final $Res Function(_TrainingSession) _then;

/// Create a copy of TrainingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? planId = null,Object? planName = null,Object? category = null,Object? difficulty = null,Object? startedAt = null,Object? completedAt = freezed,Object? plannedDuration = null,Object? actualDuration = freezed,Object? exerciseResults = null,Object? isCompleted = null,Object? userRating = freezed,Object? notes = freezed,}) {
  return _then(_TrainingSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TrainingCategory,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as TrainingDifficulty,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,plannedDuration: null == plannedDuration ? _self.plannedDuration : plannedDuration // ignore: cast_nullable_to_non_nullable
as int,actualDuration: freezed == actualDuration ? _self.actualDuration : actualDuration // ignore: cast_nullable_to_non_nullable
as int?,exerciseResults: null == exerciseResults ? _self._exerciseResults : exerciseResults // ignore: cast_nullable_to_non_nullable
as List<ExerciseResult>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,userRating: freezed == userRating ? _self.userRating : userRating // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ExerciseResult {

 String get exerciseId; String get exerciseName; ExerciseType get type; int get plannedDuration; int? get actualDuration;// How long the user actually did the exercise
 int? get actualReps;// How many reps the user actually completed
 bool get wasSkipped; bool get wasCompleted;
/// Create a copy of ExerciseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseResultCopyWith<ExerciseResult> get copyWith => _$ExerciseResultCopyWithImpl<ExerciseResult>(this as ExerciseResult, _$identity);

  /// Serializes this ExerciseResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseResult&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.type, type) || other.type == type)&&(identical(other.plannedDuration, plannedDuration) || other.plannedDuration == plannedDuration)&&(identical(other.actualDuration, actualDuration) || other.actualDuration == actualDuration)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.wasSkipped, wasSkipped) || other.wasSkipped == wasSkipped)&&(identical(other.wasCompleted, wasCompleted) || other.wasCompleted == wasCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,exerciseName,type,plannedDuration,actualDuration,actualReps,wasSkipped,wasCompleted);

@override
String toString() {
  return 'ExerciseResult(exerciseId: $exerciseId, exerciseName: $exerciseName, type: $type, plannedDuration: $plannedDuration, actualDuration: $actualDuration, actualReps: $actualReps, wasSkipped: $wasSkipped, wasCompleted: $wasCompleted)';
}


}

/// @nodoc
abstract mixin class $ExerciseResultCopyWith<$Res>  {
  factory $ExerciseResultCopyWith(ExerciseResult value, $Res Function(ExerciseResult) _then) = _$ExerciseResultCopyWithImpl;
@useResult
$Res call({
 String exerciseId, String exerciseName, ExerciseType type, int plannedDuration, int? actualDuration, int? actualReps, bool wasSkipped, bool wasCompleted
});




}
/// @nodoc
class _$ExerciseResultCopyWithImpl<$Res>
    implements $ExerciseResultCopyWith<$Res> {
  _$ExerciseResultCopyWithImpl(this._self, this._then);

  final ExerciseResult _self;
  final $Res Function(ExerciseResult) _then;

/// Create a copy of ExerciseResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseId = null,Object? exerciseName = null,Object? type = null,Object? plannedDuration = null,Object? actualDuration = freezed,Object? actualReps = freezed,Object? wasSkipped = null,Object? wasCompleted = null,}) {
  return _then(_self.copyWith(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType,plannedDuration: null == plannedDuration ? _self.plannedDuration : plannedDuration // ignore: cast_nullable_to_non_nullable
as int,actualDuration: freezed == actualDuration ? _self.actualDuration : actualDuration // ignore: cast_nullable_to_non_nullable
as int?,actualReps: freezed == actualReps ? _self.actualReps : actualReps // ignore: cast_nullable_to_non_nullable
as int?,wasSkipped: null == wasSkipped ? _self.wasSkipped : wasSkipped // ignore: cast_nullable_to_non_nullable
as bool,wasCompleted: null == wasCompleted ? _self.wasCompleted : wasCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseResult].
extension ExerciseResultPatterns on ExerciseResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseResult value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseResult value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseId,  String exerciseName,  ExerciseType type,  int plannedDuration,  int? actualDuration,  int? actualReps,  bool wasSkipped,  bool wasCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseResult() when $default != null:
return $default(_that.exerciseId,_that.exerciseName,_that.type,_that.plannedDuration,_that.actualDuration,_that.actualReps,_that.wasSkipped,_that.wasCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseId,  String exerciseName,  ExerciseType type,  int plannedDuration,  int? actualDuration,  int? actualReps,  bool wasSkipped,  bool wasCompleted)  $default,) {final _that = this;
switch (_that) {
case _ExerciseResult():
return $default(_that.exerciseId,_that.exerciseName,_that.type,_that.plannedDuration,_that.actualDuration,_that.actualReps,_that.wasSkipped,_that.wasCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseId,  String exerciseName,  ExerciseType type,  int plannedDuration,  int? actualDuration,  int? actualReps,  bool wasSkipped,  bool wasCompleted)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseResult() when $default != null:
return $default(_that.exerciseId,_that.exerciseName,_that.type,_that.plannedDuration,_that.actualDuration,_that.actualReps,_that.wasSkipped,_that.wasCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseResult implements ExerciseResult {
  const _ExerciseResult({required this.exerciseId, required this.exerciseName, required this.type, required this.plannedDuration, this.actualDuration, this.actualReps, this.wasSkipped = false, this.wasCompleted = false});
  factory _ExerciseResult.fromJson(Map<String, dynamic> json) => _$ExerciseResultFromJson(json);

@override final  String exerciseId;
@override final  String exerciseName;
@override final  ExerciseType type;
@override final  int plannedDuration;
@override final  int? actualDuration;
// How long the user actually did the exercise
@override final  int? actualReps;
// How many reps the user actually completed
@override@JsonKey() final  bool wasSkipped;
@override@JsonKey() final  bool wasCompleted;

/// Create a copy of ExerciseResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseResultCopyWith<_ExerciseResult> get copyWith => __$ExerciseResultCopyWithImpl<_ExerciseResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseResult&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.type, type) || other.type == type)&&(identical(other.plannedDuration, plannedDuration) || other.plannedDuration == plannedDuration)&&(identical(other.actualDuration, actualDuration) || other.actualDuration == actualDuration)&&(identical(other.actualReps, actualReps) || other.actualReps == actualReps)&&(identical(other.wasSkipped, wasSkipped) || other.wasSkipped == wasSkipped)&&(identical(other.wasCompleted, wasCompleted) || other.wasCompleted == wasCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,exerciseName,type,plannedDuration,actualDuration,actualReps,wasSkipped,wasCompleted);

@override
String toString() {
  return 'ExerciseResult(exerciseId: $exerciseId, exerciseName: $exerciseName, type: $type, plannedDuration: $plannedDuration, actualDuration: $actualDuration, actualReps: $actualReps, wasSkipped: $wasSkipped, wasCompleted: $wasCompleted)';
}


}

/// @nodoc
abstract mixin class _$ExerciseResultCopyWith<$Res> implements $ExerciseResultCopyWith<$Res> {
  factory _$ExerciseResultCopyWith(_ExerciseResult value, $Res Function(_ExerciseResult) _then) = __$ExerciseResultCopyWithImpl;
@override @useResult
$Res call({
 String exerciseId, String exerciseName, ExerciseType type, int plannedDuration, int? actualDuration, int? actualReps, bool wasSkipped, bool wasCompleted
});




}
/// @nodoc
class __$ExerciseResultCopyWithImpl<$Res>
    implements _$ExerciseResultCopyWith<$Res> {
  __$ExerciseResultCopyWithImpl(this._self, this._then);

  final _ExerciseResult _self;
  final $Res Function(_ExerciseResult) _then;

/// Create a copy of ExerciseResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseId = null,Object? exerciseName = null,Object? type = null,Object? plannedDuration = null,Object? actualDuration = freezed,Object? actualReps = freezed,Object? wasSkipped = null,Object? wasCompleted = null,}) {
  return _then(_ExerciseResult(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ExerciseType,plannedDuration: null == plannedDuration ? _self.plannedDuration : plannedDuration // ignore: cast_nullable_to_non_nullable
as int,actualDuration: freezed == actualDuration ? _self.actualDuration : actualDuration // ignore: cast_nullable_to_non_nullable
as int?,actualReps: freezed == actualReps ? _self.actualReps : actualReps // ignore: cast_nullable_to_non_nullable
as int?,wasSkipped: null == wasSkipped ? _self.wasSkipped : wasSkipped // ignore: cast_nullable_to_non_nullable
as bool,wasCompleted: null == wasCompleted ? _self.wasCompleted : wasCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TrainingStats {

 String get userId; int get totalSessions; int get totalMinutes; int get currentStreak; int get longestStreak; DateTime? get lastSessionDate; Map<TrainingCategory, int> get sessionsByCategory; Map<TrainingDifficulty, int> get sessionsByDifficulty; List<String> get completedPlanIds; List<TrainingAchievement> get achievements; DateTime? get updatedAt;
/// Create a copy of TrainingStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingStatsCopyWith<TrainingStats> get copyWith => _$TrainingStatsCopyWithImpl<TrainingStats>(this as TrainingStats, _$identity);

  /// Serializes this TrainingStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingStats&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastSessionDate, lastSessionDate) || other.lastSessionDate == lastSessionDate)&&const DeepCollectionEquality().equals(other.sessionsByCategory, sessionsByCategory)&&const DeepCollectionEquality().equals(other.sessionsByDifficulty, sessionsByDifficulty)&&const DeepCollectionEquality().equals(other.completedPlanIds, completedPlanIds)&&const DeepCollectionEquality().equals(other.achievements, achievements)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,totalSessions,totalMinutes,currentStreak,longestStreak,lastSessionDate,const DeepCollectionEquality().hash(sessionsByCategory),const DeepCollectionEquality().hash(sessionsByDifficulty),const DeepCollectionEquality().hash(completedPlanIds),const DeepCollectionEquality().hash(achievements),updatedAt);

@override
String toString() {
  return 'TrainingStats(userId: $userId, totalSessions: $totalSessions, totalMinutes: $totalMinutes, currentStreak: $currentStreak, longestStreak: $longestStreak, lastSessionDate: $lastSessionDate, sessionsByCategory: $sessionsByCategory, sessionsByDifficulty: $sessionsByDifficulty, completedPlanIds: $completedPlanIds, achievements: $achievements, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TrainingStatsCopyWith<$Res>  {
  factory $TrainingStatsCopyWith(TrainingStats value, $Res Function(TrainingStats) _then) = _$TrainingStatsCopyWithImpl;
@useResult
$Res call({
 String userId, int totalSessions, int totalMinutes, int currentStreak, int longestStreak, DateTime? lastSessionDate, Map<TrainingCategory, int> sessionsByCategory, Map<TrainingDifficulty, int> sessionsByDifficulty, List<String> completedPlanIds, List<TrainingAchievement> achievements, DateTime? updatedAt
});




}
/// @nodoc
class _$TrainingStatsCopyWithImpl<$Res>
    implements $TrainingStatsCopyWith<$Res> {
  _$TrainingStatsCopyWithImpl(this._self, this._then);

  final TrainingStats _self;
  final $Res Function(TrainingStats) _then;

/// Create a copy of TrainingStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? totalSessions = null,Object? totalMinutes = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastSessionDate = freezed,Object? sessionsByCategory = null,Object? sessionsByDifficulty = null,Object? completedPlanIds = null,Object? achievements = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastSessionDate: freezed == lastSessionDate ? _self.lastSessionDate : lastSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionsByCategory: null == sessionsByCategory ? _self.sessionsByCategory : sessionsByCategory // ignore: cast_nullable_to_non_nullable
as Map<TrainingCategory, int>,sessionsByDifficulty: null == sessionsByDifficulty ? _self.sessionsByDifficulty : sessionsByDifficulty // ignore: cast_nullable_to_non_nullable
as Map<TrainingDifficulty, int>,completedPlanIds: null == completedPlanIds ? _self.completedPlanIds : completedPlanIds // ignore: cast_nullable_to_non_nullable
as List<String>,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<TrainingAchievement>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingStats].
extension TrainingStatsPatterns on TrainingStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingStats value)  $default,){
final _that = this;
switch (_that) {
case _TrainingStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingStats value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int totalSessions,  int totalMinutes,  int currentStreak,  int longestStreak,  DateTime? lastSessionDate,  Map<TrainingCategory, int> sessionsByCategory,  Map<TrainingDifficulty, int> sessionsByDifficulty,  List<String> completedPlanIds,  List<TrainingAchievement> achievements,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingStats() when $default != null:
return $default(_that.userId,_that.totalSessions,_that.totalMinutes,_that.currentStreak,_that.longestStreak,_that.lastSessionDate,_that.sessionsByCategory,_that.sessionsByDifficulty,_that.completedPlanIds,_that.achievements,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int totalSessions,  int totalMinutes,  int currentStreak,  int longestStreak,  DateTime? lastSessionDate,  Map<TrainingCategory, int> sessionsByCategory,  Map<TrainingDifficulty, int> sessionsByDifficulty,  List<String> completedPlanIds,  List<TrainingAchievement> achievements,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingStats():
return $default(_that.userId,_that.totalSessions,_that.totalMinutes,_that.currentStreak,_that.longestStreak,_that.lastSessionDate,_that.sessionsByCategory,_that.sessionsByDifficulty,_that.completedPlanIds,_that.achievements,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int totalSessions,  int totalMinutes,  int currentStreak,  int longestStreak,  DateTime? lastSessionDate,  Map<TrainingCategory, int> sessionsByCategory,  Map<TrainingDifficulty, int> sessionsByDifficulty,  List<String> completedPlanIds,  List<TrainingAchievement> achievements,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingStats() when $default != null:
return $default(_that.userId,_that.totalSessions,_that.totalMinutes,_that.currentStreak,_that.longestStreak,_that.lastSessionDate,_that.sessionsByCategory,_that.sessionsByDifficulty,_that.completedPlanIds,_that.achievements,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingStats implements TrainingStats {
  const _TrainingStats({required this.userId, this.totalSessions = 0, this.totalMinutes = 0, this.currentStreak = 0, this.longestStreak = 0, this.lastSessionDate, final  Map<TrainingCategory, int> sessionsByCategory = const {}, final  Map<TrainingDifficulty, int> sessionsByDifficulty = const {}, final  List<String> completedPlanIds = const [], final  List<TrainingAchievement> achievements = const [], this.updatedAt}): _sessionsByCategory = sessionsByCategory,_sessionsByDifficulty = sessionsByDifficulty,_completedPlanIds = completedPlanIds,_achievements = achievements;
  factory _TrainingStats.fromJson(Map<String, dynamic> json) => _$TrainingStatsFromJson(json);

@override final  String userId;
@override@JsonKey() final  int totalSessions;
@override@JsonKey() final  int totalMinutes;
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int longestStreak;
@override final  DateTime? lastSessionDate;
 final  Map<TrainingCategory, int> _sessionsByCategory;
@override@JsonKey() Map<TrainingCategory, int> get sessionsByCategory {
  if (_sessionsByCategory is EqualUnmodifiableMapView) return _sessionsByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sessionsByCategory);
}

 final  Map<TrainingDifficulty, int> _sessionsByDifficulty;
@override@JsonKey() Map<TrainingDifficulty, int> get sessionsByDifficulty {
  if (_sessionsByDifficulty is EqualUnmodifiableMapView) return _sessionsByDifficulty;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sessionsByDifficulty);
}

 final  List<String> _completedPlanIds;
@override@JsonKey() List<String> get completedPlanIds {
  if (_completedPlanIds is EqualUnmodifiableListView) return _completedPlanIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedPlanIds);
}

 final  List<TrainingAchievement> _achievements;
@override@JsonKey() List<TrainingAchievement> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}

@override final  DateTime? updatedAt;

/// Create a copy of TrainingStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingStatsCopyWith<_TrainingStats> get copyWith => __$TrainingStatsCopyWithImpl<_TrainingStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingStats&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastSessionDate, lastSessionDate) || other.lastSessionDate == lastSessionDate)&&const DeepCollectionEquality().equals(other._sessionsByCategory, _sessionsByCategory)&&const DeepCollectionEquality().equals(other._sessionsByDifficulty, _sessionsByDifficulty)&&const DeepCollectionEquality().equals(other._completedPlanIds, _completedPlanIds)&&const DeepCollectionEquality().equals(other._achievements, _achievements)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,totalSessions,totalMinutes,currentStreak,longestStreak,lastSessionDate,const DeepCollectionEquality().hash(_sessionsByCategory),const DeepCollectionEquality().hash(_sessionsByDifficulty),const DeepCollectionEquality().hash(_completedPlanIds),const DeepCollectionEquality().hash(_achievements),updatedAt);

@override
String toString() {
  return 'TrainingStats(userId: $userId, totalSessions: $totalSessions, totalMinutes: $totalMinutes, currentStreak: $currentStreak, longestStreak: $longestStreak, lastSessionDate: $lastSessionDate, sessionsByCategory: $sessionsByCategory, sessionsByDifficulty: $sessionsByDifficulty, completedPlanIds: $completedPlanIds, achievements: $achievements, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingStatsCopyWith<$Res> implements $TrainingStatsCopyWith<$Res> {
  factory _$TrainingStatsCopyWith(_TrainingStats value, $Res Function(_TrainingStats) _then) = __$TrainingStatsCopyWithImpl;
@override @useResult
$Res call({
 String userId, int totalSessions, int totalMinutes, int currentStreak, int longestStreak, DateTime? lastSessionDate, Map<TrainingCategory, int> sessionsByCategory, Map<TrainingDifficulty, int> sessionsByDifficulty, List<String> completedPlanIds, List<TrainingAchievement> achievements, DateTime? updatedAt
});




}
/// @nodoc
class __$TrainingStatsCopyWithImpl<$Res>
    implements _$TrainingStatsCopyWith<$Res> {
  __$TrainingStatsCopyWithImpl(this._self, this._then);

  final _TrainingStats _self;
  final $Res Function(_TrainingStats) _then;

/// Create a copy of TrainingStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? totalSessions = null,Object? totalMinutes = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastSessionDate = freezed,Object? sessionsByCategory = null,Object? sessionsByDifficulty = null,Object? completedPlanIds = null,Object? achievements = null,Object? updatedAt = freezed,}) {
  return _then(_TrainingStats(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastSessionDate: freezed == lastSessionDate ? _self.lastSessionDate : lastSessionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionsByCategory: null == sessionsByCategory ? _self._sessionsByCategory : sessionsByCategory // ignore: cast_nullable_to_non_nullable
as Map<TrainingCategory, int>,sessionsByDifficulty: null == sessionsByDifficulty ? _self._sessionsByDifficulty : sessionsByDifficulty // ignore: cast_nullable_to_non_nullable
as Map<TrainingDifficulty, int>,completedPlanIds: null == completedPlanIds ? _self._completedPlanIds : completedPlanIds // ignore: cast_nullable_to_non_nullable
as List<String>,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<TrainingAchievement>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TrainingAchievement {

 String get id; String get name; String get description; String get iconUrl; DateTime get unlockedAt; Map<String, dynamic> get metadata;
/// Create a copy of TrainingAchievement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingAchievementCopyWith<TrainingAchievement> get copyWith => _$TrainingAchievementCopyWithImpl<TrainingAchievement>(this as TrainingAchievement, _$identity);

  /// Serializes this TrainingAchievement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingAchievement&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,iconUrl,unlockedAt,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'TrainingAchievement(id: $id, name: $name, description: $description, iconUrl: $iconUrl, unlockedAt: $unlockedAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $TrainingAchievementCopyWith<$Res>  {
  factory $TrainingAchievementCopyWith(TrainingAchievement value, $Res Function(TrainingAchievement) _then) = _$TrainingAchievementCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String iconUrl, DateTime unlockedAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$TrainingAchievementCopyWithImpl<$Res>
    implements $TrainingAchievementCopyWith<$Res> {
  _$TrainingAchievementCopyWithImpl(this._self, this._then);

  final TrainingAchievement _self;
  final $Res Function(TrainingAchievement) _then;

/// Create a copy of TrainingAchievement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? iconUrl = null,Object? unlockedAt = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconUrl: null == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String,unlockedAt: null == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingAchievement].
extension TrainingAchievementPatterns on TrainingAchievement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingAchievement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingAchievement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingAchievement value)  $default,){
final _that = this;
switch (_that) {
case _TrainingAchievement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingAchievement value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingAchievement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String iconUrl,  DateTime unlockedAt,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingAchievement() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.iconUrl,_that.unlockedAt,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String iconUrl,  DateTime unlockedAt,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _TrainingAchievement():
return $default(_that.id,_that.name,_that.description,_that.iconUrl,_that.unlockedAt,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String iconUrl,  DateTime unlockedAt,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _TrainingAchievement() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.iconUrl,_that.unlockedAt,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingAchievement implements TrainingAchievement {
  const _TrainingAchievement({required this.id, required this.name, required this.description, required this.iconUrl, required this.unlockedAt, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _TrainingAchievement.fromJson(Map<String, dynamic> json) => _$TrainingAchievementFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String iconUrl;
@override final  DateTime unlockedAt;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of TrainingAchievement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingAchievementCopyWith<_TrainingAchievement> get copyWith => __$TrainingAchievementCopyWithImpl<_TrainingAchievement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingAchievementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingAchievement&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,iconUrl,unlockedAt,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'TrainingAchievement(id: $id, name: $name, description: $description, iconUrl: $iconUrl, unlockedAt: $unlockedAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$TrainingAchievementCopyWith<$Res> implements $TrainingAchievementCopyWith<$Res> {
  factory _$TrainingAchievementCopyWith(_TrainingAchievement value, $Res Function(_TrainingAchievement) _then) = __$TrainingAchievementCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String iconUrl, DateTime unlockedAt, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$TrainingAchievementCopyWithImpl<$Res>
    implements _$TrainingAchievementCopyWith<$Res> {
  __$TrainingAchievementCopyWithImpl(this._self, this._then);

  final _TrainingAchievement _self;
  final $Res Function(_TrainingAchievement) _then;

/// Create a copy of TrainingAchievement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? iconUrl = null,Object? unlockedAt = null,Object? metadata = null,}) {
  return _then(_TrainingAchievement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconUrl: null == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String,unlockedAt: null == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$ActiveTrainingSession {

 TrainingPlan get plan; TrainingSession get session; int get currentExerciseIndex; Exercise get currentExercise; bool get isResting; bool get isPaused; DateTime? get exerciseStartedAt; DateTime? get sessionStartedAt; List<ExerciseResult> get completedExercises;
/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveTrainingSessionCopyWith<ActiveTrainingSession> get copyWith => _$ActiveTrainingSessionCopyWithImpl<ActiveTrainingSession>(this as ActiveTrainingSession, _$identity);

  /// Serializes this ActiveTrainingSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveTrainingSession&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.session, session) || other.session == session)&&(identical(other.currentExerciseIndex, currentExerciseIndex) || other.currentExerciseIndex == currentExerciseIndex)&&(identical(other.currentExercise, currentExercise) || other.currentExercise == currentExercise)&&(identical(other.isResting, isResting) || other.isResting == isResting)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.exerciseStartedAt, exerciseStartedAt) || other.exerciseStartedAt == exerciseStartedAt)&&(identical(other.sessionStartedAt, sessionStartedAt) || other.sessionStartedAt == sessionStartedAt)&&const DeepCollectionEquality().equals(other.completedExercises, completedExercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,session,currentExerciseIndex,currentExercise,isResting,isPaused,exerciseStartedAt,sessionStartedAt,const DeepCollectionEquality().hash(completedExercises));

@override
String toString() {
  return 'ActiveTrainingSession(plan: $plan, session: $session, currentExerciseIndex: $currentExerciseIndex, currentExercise: $currentExercise, isResting: $isResting, isPaused: $isPaused, exerciseStartedAt: $exerciseStartedAt, sessionStartedAt: $sessionStartedAt, completedExercises: $completedExercises)';
}


}

/// @nodoc
abstract mixin class $ActiveTrainingSessionCopyWith<$Res>  {
  factory $ActiveTrainingSessionCopyWith(ActiveTrainingSession value, $Res Function(ActiveTrainingSession) _then) = _$ActiveTrainingSessionCopyWithImpl;
@useResult
$Res call({
 TrainingPlan plan, TrainingSession session, int currentExerciseIndex, Exercise currentExercise, bool isResting, bool isPaused, DateTime? exerciseStartedAt, DateTime? sessionStartedAt, List<ExerciseResult> completedExercises
});


$TrainingPlanCopyWith<$Res> get plan;$TrainingSessionCopyWith<$Res> get session;$ExerciseCopyWith<$Res> get currentExercise;

}
/// @nodoc
class _$ActiveTrainingSessionCopyWithImpl<$Res>
    implements $ActiveTrainingSessionCopyWith<$Res> {
  _$ActiveTrainingSessionCopyWithImpl(this._self, this._then);

  final ActiveTrainingSession _self;
  final $Res Function(ActiveTrainingSession) _then;

/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,Object? session = null,Object? currentExerciseIndex = null,Object? currentExercise = null,Object? isResting = null,Object? isPaused = null,Object? exerciseStartedAt = freezed,Object? sessionStartedAt = freezed,Object? completedExercises = null,}) {
  return _then(_self.copyWith(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as TrainingPlan,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TrainingSession,currentExerciseIndex: null == currentExerciseIndex ? _self.currentExerciseIndex : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
as int,currentExercise: null == currentExercise ? _self.currentExercise : currentExercise // ignore: cast_nullable_to_non_nullable
as Exercise,isResting: null == isResting ? _self.isResting : isResting // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,exerciseStartedAt: freezed == exerciseStartedAt ? _self.exerciseStartedAt : exerciseStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionStartedAt: freezed == sessionStartedAt ? _self.sessionStartedAt : sessionStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedExercises: null == completedExercises ? _self.completedExercises : completedExercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseResult>,
  ));
}
/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingPlanCopyWith<$Res> get plan {
  
  return $TrainingPlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingSessionCopyWith<$Res> get session {
  
  return $TrainingSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get currentExercise {
  
  return $ExerciseCopyWith<$Res>(_self.currentExercise, (value) {
    return _then(_self.copyWith(currentExercise: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveTrainingSession].
extension ActiveTrainingSessionPatterns on ActiveTrainingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveTrainingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveTrainingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveTrainingSession value)  $default,){
final _that = this;
switch (_that) {
case _ActiveTrainingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveTrainingSession value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveTrainingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrainingPlan plan,  TrainingSession session,  int currentExerciseIndex,  Exercise currentExercise,  bool isResting,  bool isPaused,  DateTime? exerciseStartedAt,  DateTime? sessionStartedAt,  List<ExerciseResult> completedExercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveTrainingSession() when $default != null:
return $default(_that.plan,_that.session,_that.currentExerciseIndex,_that.currentExercise,_that.isResting,_that.isPaused,_that.exerciseStartedAt,_that.sessionStartedAt,_that.completedExercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrainingPlan plan,  TrainingSession session,  int currentExerciseIndex,  Exercise currentExercise,  bool isResting,  bool isPaused,  DateTime? exerciseStartedAt,  DateTime? sessionStartedAt,  List<ExerciseResult> completedExercises)  $default,) {final _that = this;
switch (_that) {
case _ActiveTrainingSession():
return $default(_that.plan,_that.session,_that.currentExerciseIndex,_that.currentExercise,_that.isResting,_that.isPaused,_that.exerciseStartedAt,_that.sessionStartedAt,_that.completedExercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrainingPlan plan,  TrainingSession session,  int currentExerciseIndex,  Exercise currentExercise,  bool isResting,  bool isPaused,  DateTime? exerciseStartedAt,  DateTime? sessionStartedAt,  List<ExerciseResult> completedExercises)?  $default,) {final _that = this;
switch (_that) {
case _ActiveTrainingSession() when $default != null:
return $default(_that.plan,_that.session,_that.currentExerciseIndex,_that.currentExercise,_that.isResting,_that.isPaused,_that.exerciseStartedAt,_that.sessionStartedAt,_that.completedExercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveTrainingSession implements ActiveTrainingSession {
  const _ActiveTrainingSession({required this.plan, required this.session, required this.currentExerciseIndex, required this.currentExercise, this.isResting = false, this.isPaused = false, this.exerciseStartedAt, this.sessionStartedAt, final  List<ExerciseResult> completedExercises = const []}): _completedExercises = completedExercises;
  factory _ActiveTrainingSession.fromJson(Map<String, dynamic> json) => _$ActiveTrainingSessionFromJson(json);

@override final  TrainingPlan plan;
@override final  TrainingSession session;
@override final  int currentExerciseIndex;
@override final  Exercise currentExercise;
@override@JsonKey() final  bool isResting;
@override@JsonKey() final  bool isPaused;
@override final  DateTime? exerciseStartedAt;
@override final  DateTime? sessionStartedAt;
 final  List<ExerciseResult> _completedExercises;
@override@JsonKey() List<ExerciseResult> get completedExercises {
  if (_completedExercises is EqualUnmodifiableListView) return _completedExercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedExercises);
}


/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveTrainingSessionCopyWith<_ActiveTrainingSession> get copyWith => __$ActiveTrainingSessionCopyWithImpl<_ActiveTrainingSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveTrainingSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveTrainingSession&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.session, session) || other.session == session)&&(identical(other.currentExerciseIndex, currentExerciseIndex) || other.currentExerciseIndex == currentExerciseIndex)&&(identical(other.currentExercise, currentExercise) || other.currentExercise == currentExercise)&&(identical(other.isResting, isResting) || other.isResting == isResting)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.exerciseStartedAt, exerciseStartedAt) || other.exerciseStartedAt == exerciseStartedAt)&&(identical(other.sessionStartedAt, sessionStartedAt) || other.sessionStartedAt == sessionStartedAt)&&const DeepCollectionEquality().equals(other._completedExercises, _completedExercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,session,currentExerciseIndex,currentExercise,isResting,isPaused,exerciseStartedAt,sessionStartedAt,const DeepCollectionEquality().hash(_completedExercises));

@override
String toString() {
  return 'ActiveTrainingSession(plan: $plan, session: $session, currentExerciseIndex: $currentExerciseIndex, currentExercise: $currentExercise, isResting: $isResting, isPaused: $isPaused, exerciseStartedAt: $exerciseStartedAt, sessionStartedAt: $sessionStartedAt, completedExercises: $completedExercises)';
}


}

/// @nodoc
abstract mixin class _$ActiveTrainingSessionCopyWith<$Res> implements $ActiveTrainingSessionCopyWith<$Res> {
  factory _$ActiveTrainingSessionCopyWith(_ActiveTrainingSession value, $Res Function(_ActiveTrainingSession) _then) = __$ActiveTrainingSessionCopyWithImpl;
@override @useResult
$Res call({
 TrainingPlan plan, TrainingSession session, int currentExerciseIndex, Exercise currentExercise, bool isResting, bool isPaused, DateTime? exerciseStartedAt, DateTime? sessionStartedAt, List<ExerciseResult> completedExercises
});


@override $TrainingPlanCopyWith<$Res> get plan;@override $TrainingSessionCopyWith<$Res> get session;@override $ExerciseCopyWith<$Res> get currentExercise;

}
/// @nodoc
class __$ActiveTrainingSessionCopyWithImpl<$Res>
    implements _$ActiveTrainingSessionCopyWith<$Res> {
  __$ActiveTrainingSessionCopyWithImpl(this._self, this._then);

  final _ActiveTrainingSession _self;
  final $Res Function(_ActiveTrainingSession) _then;

/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? session = null,Object? currentExerciseIndex = null,Object? currentExercise = null,Object? isResting = null,Object? isPaused = null,Object? exerciseStartedAt = freezed,Object? sessionStartedAt = freezed,Object? completedExercises = null,}) {
  return _then(_ActiveTrainingSession(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as TrainingPlan,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TrainingSession,currentExerciseIndex: null == currentExerciseIndex ? _self.currentExerciseIndex : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
as int,currentExercise: null == currentExercise ? _self.currentExercise : currentExercise // ignore: cast_nullable_to_non_nullable
as Exercise,isResting: null == isResting ? _self.isResting : isResting // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,exerciseStartedAt: freezed == exerciseStartedAt ? _self.exerciseStartedAt : exerciseStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionStartedAt: freezed == sessionStartedAt ? _self.sessionStartedAt : sessionStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedExercises: null == completedExercises ? _self._completedExercises : completedExercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseResult>,
  ));
}

/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingPlanCopyWith<$Res> get plan {
  
  return $TrainingPlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingSessionCopyWith<$Res> get session {
  
  return $TrainingSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of ActiveTrainingSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get currentExercise {
  
  return $ExerciseCopyWith<$Res>(_self.currentExercise, (value) {
    return _then(_self.copyWith(currentExercise: value));
  });
}
}

// dart format on
