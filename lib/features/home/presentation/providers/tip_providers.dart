import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/daily_tip.dart';
import '../../domain/repositories/tip_repository.dart';
import '../../data/datasources/tip_data_source.dart';
import '../../data/repositories/tip_repository_impl.dart';

// Data source provider
final tipDataSourceProvider = Provider<TipDataSource>((ref) {
  return LocalTipDataSource();
});

// Repository provider
final tipRepositoryProvider = Provider<TipRepository>((ref) {
  final dataSource = ref.watch(tipDataSourceProvider);
  return TipRepositoryImpl(dataSource);
});

// Daily tip provider
final dailyTipProvider = FutureProvider<DailyTip?>((ref) async {
  final repository = ref.watch(tipRepositoryProvider);
  return repository.getDailyTip();
});

// All tips provider
final allTipsProvider = FutureProvider<List<DailyTip>>((ref) async {
  final repository = ref.watch(tipRepositoryProvider);
  return repository.getAllTips();
});

// Tips by category provider
final tipsByCategoryProvider = FutureProvider.family<List<DailyTip>, String>((ref, category) async {
  final repository = ref.watch(tipRepositoryProvider);
  return repository.getTipsByCategory(category);
});

// Tips search provider
final searchTipsProvider = FutureProvider.family<List<DailyTip>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final repository = ref.watch(tipRepositoryProvider);
  return repository.searchTips(query);
});

// Tips history provider
final tipsHistoryProvider = FutureProvider<List<DailyTip>>((ref) async {
  final repository = ref.watch(tipRepositoryProvider);
  return repository.getTipsHistory();
});

// Random tip provider
final randomTipProvider = FutureProvider<DailyTip?>((ref) async {
  final repository = ref.watch(tipRepositoryProvider);
  return repository.getRandomTip();
});

// Mark tip as read action
final markTipAsReadProvider = Provider<Future<void> Function(String)>((ref) {
  return (String tipId) async {
    final repository = ref.read(tipRepositoryProvider);
    await repository.markTipAsRead(tipId);

    // Invalidate related providers to refresh the UI
    ref.invalidate(dailyTipProvider);
    ref.invalidate(allTipsProvider);
    ref.invalidate(tipsHistoryProvider);
  };
});

// Current tip selection for details view
final selectedTipProvider = StateProvider<DailyTip?>((ref) => null);
