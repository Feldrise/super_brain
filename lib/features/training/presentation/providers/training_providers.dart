import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/training/domain/repositories/training_repository.dart';
import 'package:super_brain/features/training/data/repositories/training_repository_impl.dart';
import 'package:super_brain/features/training/data/datasources/training_plans_datasource.dart';
import 'package:super_brain/features/training/data/datasources/training_firestore_datasource.dart';

// Data Sources
final trainingPlansDataSourceProvider = Provider<TrainingPlansDataSource>((ref) {
  return LocalTrainingPlansDataSource();
});

final trainingFirestoreDataSourceProvider = Provider<TrainingFirestoreDataSource>((ref) {
  return TrainingFirestoreDataSourceImpl();
});

// Repository
final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  final plansDataSource = ref.watch(trainingPlansDataSourceProvider);
  final firestoreDataSource = ref.watch(trainingFirestoreDataSourceProvider);

  return TrainingRepositoryImpl(plansDataSource: plansDataSource, firestoreDataSource: firestoreDataSource);
});
