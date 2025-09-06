import 'package:super_brain/features/reminder/domain/entities/summary.dart';

abstract class SummaryRepository {
  // Global summaries (curated content) - read-only for users
  Stream<List<Summary>> watchGlobalSummaries();
  Future<List<Summary>> getGlobalSummaries({int? limit});
  Future<Summary?> getGlobalSummaryById(String id);
}
