import '../entities/daily_tip.dart';

abstract class TipRepository {
  /// Get the daily tip for today
  Future<DailyTip?> getDailyTip();

  /// Get all available tips
  Future<List<DailyTip>> getAllTips();

  /// Get tips by category
  Future<List<DailyTip>> getTipsByCategory(String category);

  /// Mark a tip as read
  Future<void> markTipAsRead(String tipId);

  /// Get tips history (read tips)
  Future<List<DailyTip>> getTipsHistory();

  /// Search tips by content or title
  Future<List<DailyTip>> searchTips(String query);

  /// Get random tip
  Future<DailyTip?> getRandomTip();
}
