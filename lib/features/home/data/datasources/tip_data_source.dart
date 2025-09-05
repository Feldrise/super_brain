import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/daily_tip.dart';

abstract class TipDataSource {
  Future<List<DailyTip>> getAllTips();
  Future<DailyTip?> getTipById(String id);
  Future<void> markTipAsRead(String tipId);
  Future<List<String>> getReadTipIds();
}

class LocalTipDataSource implements TipDataSource {
  // This would typically use SharedPreferences or local database
  // For now, we'll use an in-memory solution with tips loaded from JSON

  static List<DailyTip>? _cachedTips;
  static final Set<String> _readTipIds = <String>{};

  Future<List<DailyTip>> _loadTipsFromJson() async {
    if (_cachedTips != null) return _cachedTips!;

    try {
      final String jsonString = await rootBundle.loadString('assets/data/daily_tips.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      _cachedTips = jsonList.map((json) => DailyTip.fromJson(json as Map<String, dynamic>)).toList();
      return _cachedTips!;
    } catch (e) {
      // Fallback to hardcoded tips if JSON loading fails
      _cachedTips = _getFallbackTips();
      return _cachedTips!;
    }
  }

  List<DailyTip> _getFallbackTips() {
    return [
      DailyTip(
        id: '1',
        title: 'Technique Pomodoro',
        content:
            'Saviez-vous que faire une pause toutes les 25 minutes améliore la concentration et la mémorisation ? C\'est la technique Pomodoro ! Travaillez 25 minutes puis prenez une pause de 5 minutes.',
        category: 'productivity',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        tags: ['pomodoro', 'concentration', 'pause'],
      ),
      DailyTip(
        id: '2',
        title: 'Méthode des Loci',
        content:
            'La méthode des loci, aussi appelée "palais de mémoire", consiste à associer des informations à des lieux familiers. Imaginez-vous parcourir votre maison et placer chaque élément à mémoriser dans une pièce différente.',
        category: 'memory',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        tags: ['mémoire', 'palais', 'visualisation'],
      ),
      DailyTip(
        id: '3',
        title: 'Répétition espacée',
        content: 'Pour optimiser votre mémoire à long terme, révisez vos informations selon des intervalles croissants : 1 jour, 3 jours, 1 semaine, 2 semaines, 1 mois.',
        category: 'memory',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        tags: ['révision', 'mémoire', 'long terme'],
      ),
    ];
  }

  @override
  Future<List<DailyTip>> getAllTips() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final tips = await _loadTipsFromJson();
    return tips.map((tip) => tip.copyWith(isRead: _readTipIds.contains(tip.id))).toList();
  }

  @override
  Future<DailyTip?> getTipById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final tips = await _loadTipsFromJson();
    try {
      final tip = tips.firstWhere((t) => t.id == id);
      return tip.copyWith(isRead: _readTipIds.contains(tip.id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> markTipAsRead(String tipId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _readTipIds.add(tipId);
  }

  @override
  Future<List<String>> getReadTipIds() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _readTipIds.toList();
  }
}
