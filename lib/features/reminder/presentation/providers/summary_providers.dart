import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/reminder/data/repositories/summary_repository_impl.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/domain/repositories/summary_repository.dart';
import 'package:super_brain/features/reminder/domain/usecases/summary_usecases.dart';

// Repository provider
final summaryRepositoryProvider = Provider<SummaryRepository>((ref) {
  return SummaryRepositoryImpl(firestore: FirebaseFirestore.instance);
});

// Use cases providers
final getGlobalSummariesUseCaseProvider = Provider<GetGlobalSummariesUseCase>((ref) {
  return GetGlobalSummariesUseCase(ref.watch(summaryRepositoryProvider));
});

final getSummaryByIdUseCaseProvider = Provider<GetSummaryByIdUseCase>((ref) {
  return GetSummaryByIdUseCase(ref.watch(summaryRepositoryProvider));
});

// Data providers
final globalSummariesProvider = StreamProvider<List<Summary>>((ref) {
  try {
    final useCase = ref.watch(getGlobalSummariesUseCaseProvider);
    return useCase.watch();
  } catch (e) {
    // Return empty list if there's an error
    return Stream.value(<Summary>[]);
  }
});

final summaryByIdProvider = FutureProvider.family<Summary?, String>((ref, id) {
  final useCase = ref.watch(getSummaryByIdUseCaseProvider);
  return useCase.call(id);
});
