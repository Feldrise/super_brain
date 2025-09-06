import 'package:super_brain/features/reminder/domain/entities/summary.dart';
import 'package:super_brain/features/reminder/domain/repositories/summary_repository.dart';

class GetGlobalSummariesUseCase {
  final SummaryRepository _repository;

  GetGlobalSummariesUseCase(this._repository);

  Future<List<Summary>> call({int? limit}) {
    return _repository.getGlobalSummaries(limit: limit);
  }

  Stream<List<Summary>> watch() {
    return _repository.watchGlobalSummaries();
  }
}

class GetSummaryByIdUseCase {
  final SummaryRepository _repository;

  GetSummaryByIdUseCase(this._repository);

  Future<Summary?> call(String id) {
    return _repository.getGlobalSummaryById(id);
  }
}
