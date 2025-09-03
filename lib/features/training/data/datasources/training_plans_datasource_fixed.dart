import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:super_brain/features/training/data/models/training_models.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';

abstract class TrainingPlansDataSource {
  Future<List<TrainingPlan>> getTrainingPlans();
  Future<List<TrainingPlan>> getTrainingPlansByCategory(String category);
  Future<List<TrainingPlan>> getTrainingPlansByDifficulty(String difficulty);
  Future<TrainingPlan?> getTrainingPlanById(String planId);
}

class LocalTrainingPlansDataSource implements TrainingPlansDataSource {
  static const String _plansAssetPath = 'assets/data/training_plans.json';

  List<TrainingPlan>? _cachedPlans;

  Future<List<TrainingPlan>> _loadPlans() async {
    if (_cachedPlans != null) return _cachedPlans!;

    try {
      final String jsonString = await rootBundle.loadString(_plansAssetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> plansJson = jsonData['training_plans'];

      _cachedPlans = plansJson.map((planJson) => TrainingPlanModel.fromJson(planJson as Map<String, dynamic>).toDomain()).toList();

      return _cachedPlans!;
    } catch (e) {
      // If asset doesn't exist, return default plans
      return _getDefaultPlans();
    }
  }

  List<TrainingPlan> _getDefaultPlans() {
    return [
      // Quick Cardio Plans
      TrainingPlan(
        id: 'cardio_quick_5',
        name: '5-Minute Cardio Burst',
        description: 'Quick cardio session to get your heart pumping',
        category: TrainingCategory.cardio,
        difficulty: TrainingDifficulty.beginner,
        estimatedDuration: 5,
        exercises: [
          Exercise(
            id: 'jumping_jacks',
            name: 'Jumping Jacks',
            description: 'Classic cardio exercise',
            type: ExerciseType.timed,
            duration: 45,
            instructions: 'Jump with feet apart while raising arms overhead, then return to starting position',
            muscleGroups: ['full-body'],
            equipment: [],
          ),
          Exercise(id: 'rest_15', name: 'Rest', description: 'Take a breather', type: ExerciseType.rest, duration: 15, muscleGroups: [], equipment: []),
          Exercise(
            id: 'high_knees',
            name: 'High Knees',
            description: 'Run in place lifting knees high',
            type: ExerciseType.timed,
            duration: 45,
            instructions: 'Run in place, bringing knees up to waist level',
            muscleGroups: ['legs', 'core'],
            equipment: [],
          ),
          Exercise(id: 'rest_15_2', name: 'Rest', description: 'Take a breather', type: ExerciseType.rest, duration: 15, muscleGroups: [], equipment: []),
          Exercise(
            id: 'burpees',
            name: 'Burpees',
            description: 'Full body explosive movement',
            type: ExerciseType.timed,
            duration: 45,
            instructions: 'Start standing, squat down, jump back to plank, jump forward, stand up and jump',
            muscleGroups: ['full-body'],
            equipment: [],
          ),
          Exercise(id: 'rest_15_3', name: 'Rest', description: 'Take a breather', type: ExerciseType.rest, duration: 15, muscleGroups: [], equipment: []),
          Exercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            description: 'Cardio exercise in plank position',
            type: ExerciseType.timed,
            duration: 45,
            instructions: 'Start in plank position and alternate bringing knees to chest quickly',
            muscleGroups: ['core', 'arms'],
            equipment: [],
          ),
          Exercise(id: 'rest_15_4', name: 'Rest', description: 'Take a breather', type: ExerciseType.rest, duration: 15, muscleGroups: [], equipment: []),
          Exercise(
            id: 'squat_jumps',
            name: 'Squat Jumps',
            description: 'Explosive squat movement',
            type: ExerciseType.timed,
            duration: 45,
            instructions: 'Squat down then jump up explosively, landing softly back in squat position',
            muscleGroups: ['legs', 'glutes'],
            equipment: [],
          ),
        ],
        tags: ['cardio', 'hiit', 'quick'],
      ),

      TrainingPlan(
        id: 'cardio_medium_15',
        name: '15-Minute HIIT Cardio',
        description: 'High-intensity interval training for a great cardio workout',
        category: TrainingCategory.cardio,
        difficulty: TrainingDifficulty.intermediate,
        estimatedDuration: 15,
        exercises: [
          Exercise(
            id: 'warmup_jacks',
            name: 'Warm-up Jumping Jacks',
            description: 'Gentle warm-up movement',
            type: ExerciseType.timed,
            duration: 120,
            instructions: 'Start with slow, controlled jumping jacks to warm up',
            muscleGroups: ['full-body'],
            equipment: [],
          ),
          Exercise(
            id: 'sprint_intervals',
            name: 'Sprint Intervals',
            description: 'High-intensity sprinting',
            type: ExerciseType.timed,
            duration: 180,
            instructions: '30 seconds sprint, 30 seconds rest, repeat 3 times',
            muscleGroups: ['legs', 'core'],
            equipment: [],
          ),
          Exercise(
            id: 'burpee_intervals',
            name: 'Burpee Intervals',
            description: 'Full body HIIT exercise',
            type: ExerciseType.timed,
            duration: 180,
            instructions: '20 seconds burpees, 40 seconds rest, repeat 3 times',
            muscleGroups: ['full-body'],
            equipment: [],
          ),
          Exercise(
            id: 'plank_jacks',
            name: 'Plank Jacks',
            description: 'Cardio in plank position',
            type: ExerciseType.timed,
            duration: 120,
            instructions: 'In plank position, jump feet apart and together',
            muscleGroups: ['core', 'arms'],
            equipment: [],
          ),
          Exercise(
            id: 'cool_down_walk',
            name: 'Cool Down Walk',
            description: 'Gentle cool down',
            type: ExerciseType.timed,
            duration: 180,
            instructions: 'Walk in place or around the room to cool down',
            muscleGroups: ['legs'],
            equipment: [],
          ),
        ],
        tags: ['cardio', 'hiit', 'intermediate'],
      ),

      // Strength Training Plans
      TrainingPlan(
        id: 'strength_upper_20',
        name: '20-Minute Upper Body Strength',
        description: 'Target your upper body muscles with bodyweight exercises',
        category: TrainingCategory.strength,
        difficulty: TrainingDifficulty.intermediate,
        estimatedDuration: 20,
        exercises: [
          Exercise(
            id: 'push_ups',
            name: 'Push-ups',
            description: 'Classic upper body exercise',
            type: ExerciseType.reps,
            duration: 180,
            targetReps: 12,
            instructions: 'Keep body straight, lower chest to ground, push back up',
            muscleGroups: ['chest', 'arms', 'core'],
            equipment: [],
          ),
          Exercise(id: 'rest_60', name: 'Rest', description: 'Recovery time', type: ExerciseType.rest, duration: 60, muscleGroups: [], equipment: []),
          Exercise(
            id: 'tricep_dips',
            name: 'Tricep Dips',
            description: 'Chair or bench dips for triceps',
            type: ExerciseType.reps,
            duration: 180,
            targetReps: 10,
            instructions: 'Use a chair or bench, lower body down using arms, push back up',
            muscleGroups: ['triceps', 'shoulders'],
            equipment: ['chair'],
          ),
          Exercise(id: 'rest_60_2', name: 'Rest', description: 'Recovery time', type: ExerciseType.rest, duration: 60, muscleGroups: [], equipment: []),
          Exercise(
            id: 'pike_push_ups',
            name: 'Pike Push-ups',
            description: 'Shoulder-focused push-up variation',
            type: ExerciseType.reps,
            duration: 180,
            targetReps: 8,
            instructions: 'Start in downward dog position, lower head toward ground, push back up',
            muscleGroups: ['shoulders', 'arms'],
            equipment: [],
          ),
          Exercise(id: 'rest_60_3', name: 'Rest', description: 'Recovery time', type: ExerciseType.rest, duration: 60, muscleGroups: [], equipment: []),
          Exercise(
            id: 'plank_up_downs',
            name: 'Plank Up-Downs',
            description: 'Dynamic plank exercise',
            type: ExerciseType.reps,
            duration: 180,
            targetReps: 10,
            instructions: 'Start in plank, lower to forearms one arm at a time, push back up',
            muscleGroups: ['core', 'arms', 'shoulders'],
            equipment: [],
          ),
        ],
        tags: ['strength', 'upper-body', 'bodyweight'],
      ),

      // Yoga/Stretching Plans
      TrainingPlan(
        id: 'yoga_morning_10',
        name: '10-Minute Morning Yoga',
        description: 'Gentle yoga flow to start your day',
        category: TrainingCategory.yoga,
        difficulty: TrainingDifficulty.beginner,
        estimatedDuration: 10,
        exercises: [
          Exercise(
            id: 'child_pose',
            name: "Child's Pose",
            description: 'Restorative starting position',
            type: ExerciseType.timed,
            duration: 60,
            instructions: 'Kneel on floor, sit back on heels, fold forward with arms extended',
            muscleGroups: ['back', 'hips'],
            equipment: ['yoga-mat'],
          ),
          Exercise(
            id: 'cat_cow',
            name: 'Cat-Cow Stretch',
            description: 'Spine mobility exercise',
            type: ExerciseType.timed,
            duration: 60,
            instructions: 'On hands and knees, alternate arching and rounding your spine',
            muscleGroups: ['spine', 'core'],
            equipment: ['yoga-mat'],
          ),
          Exercise(
            id: 'downward_dog',
            name: 'Downward Dog',
            description: 'Classic yoga pose',
            type: ExerciseType.timed,
            duration: 90,
            instructions: 'From hands and knees, lift hips up and back, straighten legs',
            muscleGroups: ['full-body'],
            equipment: ['yoga-mat'],
          ),
          Exercise(
            id: 'forward_fold',
            name: 'Standing Forward Fold',
            description: 'Hamstring and back stretch',
            type: ExerciseType.timed,
            duration: 60,
            instructions: 'Stand and fold forward, let arms hang or hold elbows',
            muscleGroups: ['hamstrings', 'back'],
            equipment: ['yoga-mat'],
          ),
          Exercise(
            id: 'mountain_pose',
            name: 'Mountain Pose',
            description: 'Grounding standing pose',
            type: ExerciseType.timed,
            duration: 60,
            instructions: 'Stand tall, feet hip-width apart, arms at sides, breathe deeply',
            muscleGroups: ['full-body'],
            equipment: ['yoga-mat'],
          ),
          Exercise(
            id: 'warrior_one',
            name: 'Warrior I',
            description: 'Strengthening standing pose',
            type: ExerciseType.timed,
            duration: 90,
            instructions: 'Step one foot back, bend front knee, raise arms overhead',
            muscleGroups: ['legs', 'core', 'arms'],
            equipment: ['yoga-mat'],
          ),
          Exercise(
            id: 'savasana',
            name: 'Savasana',
            description: 'Final relaxation',
            type: ExerciseType.timed,
            duration: 180,
            instructions: 'Lie on back, close eyes, relax completely',
            muscleGroups: [],
            equipment: ['yoga-mat'],
          ),
        ],
        tags: ['yoga', 'morning', 'flexibility'],
      ),
    ];
  }

  @override
  Future<List<TrainingPlan>> getTrainingPlans() async {
    return await _loadPlans();
  }

  @override
  Future<List<TrainingPlan>> getTrainingPlansByCategory(String category) async {
    final plans = await _loadPlans();
    return plans.where((plan) => plan.category.toString().split('.').last == category).toList();
  }

  @override
  Future<List<TrainingPlan>> getTrainingPlansByDifficulty(String difficulty) async {
    final plans = await _loadPlans();
    return plans.where((plan) => plan.difficulty.toString().split('.').last == difficulty).toList();
  }

  @override
  Future<TrainingPlan?> getTrainingPlanById(String planId) async {
    final plans = await _loadPlans();
    try {
      return plans.firstWhere((plan) => plan.id == planId);
    } catch (e) {
      return null;
    }
  }
}
