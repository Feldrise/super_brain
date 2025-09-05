import '../../domain/entities/daily_tip.dart';
import '../../domain/repositories/tip_repository.dart';
import '../datasources/tip_data_source.dart';

class TipRepositoryImpl implements TipRepository {
  final TipDataSource _dataSource;

  const TipRepositoryImpl(this._dataSource);

  @override
  Future<DailyTip?> getDailyTip() async {
    final allTips = await _dataSource.getAllTips();
    if (allTips.isEmpty) return null;

    // Get today's tip based on the day of the year
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    final tipIndex = dayOfYear % allTips.length;

    return allTips[tipIndex];
  }

  @override
  Future<List<DailyTip>> getAllTips() async {
    return _dataSource.getAllTips();
  }

  @override
  Future<List<DailyTip>> getTipsByCategory(String category) async {
    final allTips = await _dataSource.getAllTips();
    return allTips.where((tip) => tip.category == category).toList();
  }

  @override
  Future<void> markTipAsRead(String tipId) async {
    await _dataSource.markTipAsRead(tipId);
  }

  @override
  Future<List<DailyTip>> getTipsHistory() async {
    final allTips = await _dataSource.getAllTips();
    return allTips.where((tip) => tip.isRead).toList();
  }

  @override
  Future<List<DailyTip>> searchTips(String query) async {
    final allTips = await _dataSource.getAllTips();
    final lowercaseQuery = query.toLowerCase();

    return allTips
        .where(
          (tip) =>
              tip.title.toLowerCase().contains(lowercaseQuery) ||
              tip.content.toLowerCase().contains(lowercaseQuery) ||
              (tip.tags?.any((tag) => tag.toLowerCase().contains(lowercaseQuery)) ?? false),
        )
        .toList();
  }

  @override
  Future<DailyTip?> getRandomTip() async {
    final allTips = await _dataSource.getAllTips();
    if (allTips.isEmpty) return null;

    final randomIndex = DateTime.now().millisecondsSinceEpoch % allTips.length;
    return allTips[randomIndex];
  }
}
