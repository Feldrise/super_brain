import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/training/domain/entities/training_entities.dart';
import 'package:super_brain/features/training/presentation/controllers/training_controllers.dart';
import 'package:super_brain/features/training/presentation/widgets/training_plan_card.dart';
import 'package:super_brain/features/training/presentation/pages/training_session_page.dart';

class TrainingPlansPage extends ConsumerStatefulWidget {
  final TrainingCategory? filterCategory;
  final TrainingDifficulty? filterDifficulty;

  const TrainingPlansPage({super.key, this.filterCategory, this.filterDifficulty});

  @override
  ConsumerState<TrainingPlansPage> createState() => _TrainingPlansPageState();
}

class _TrainingPlansPageState extends ConsumerState<TrainingPlansPage> {
  TrainingCategory? _selectedCategory;
  TrainingDifficulty? _selectedDifficulty;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.filterCategory;
    _selectedDifficulty = widget.filterDifficulty;
  }

  @override
  Widget build(BuildContext context) {
    final plansAsync = ref.watch(trainingPlansProvider);

    return Scaffold(
      appBar: AppBar(title: Text(_getTitle()), elevation: 0),
      body: Column(
        children: [
          // Search and Filter Section
          _SearchAndFiltersSection(
            searchQuery: _searchQuery,
            selectedCategory: _selectedCategory,
            selectedDifficulty: _selectedDifficulty,
            onSearchChanged: (query) => setState(() => _searchQuery = query),
            onCategoryChanged: (category) => setState(() => _selectedCategory = category),
            onDifficultyChanged: (difficulty) => setState(() => _selectedDifficulty = difficulty),
            onClearFilters: _clearFilters,
          ),

          // Plans List
          Expanded(
            child: plansAsync.when(
              data: (plans) {
                final filteredPlans = _filterPlans(plans);

                if (filteredPlans.isEmpty) {
                  return _EmptyPlansWidget(hasFilters: _hasFilters());
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filteredPlans.length,
                  itemBuilder: (context, index) {
                    final plan = filteredPlans[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TrainingPlanCard(plan: plan, onTap: () => _startPlan(context, plan)),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Theme.of(context).colorScheme.error),
                    const SizedBox(height: 16),
                    Text('Erreur lors du chargement des plans', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text('$error', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: () => ref.invalidate(trainingPlansProvider), child: const Text('Réessayer')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    if (widget.filterCategory != null) {
      return 'Plans ${widget.filterCategory!.name.toUpperCase()}';
    }
    if (widget.filterDifficulty != null) {
      return 'Plans ${widget.filterDifficulty!.name.toUpperCase()}';
    }
    return 'Tous les Plans d\'Entraînement';
  }

  List<TrainingPlan> _filterPlans(List<TrainingPlan> plans) {
    return plans.where((plan) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!plan.name.toLowerCase().contains(query) && !plan.description.toLowerCase().contains(query) && !plan.tags.any((tag) => tag.toLowerCase().contains(query))) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != null && plan.category != _selectedCategory) {
        return false;
      }

      // Difficulty filter
      if (_selectedDifficulty != null && plan.difficulty != _selectedDifficulty) {
        return false;
      }

      return plan.isActive;
    }).toList();
  }

  bool _hasFilters() {
    return _searchQuery.isNotEmpty || _selectedCategory != null || _selectedDifficulty != null;
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedCategory = widget.filterCategory; // Keep initial filter if any
      _selectedDifficulty = widget.filterDifficulty; // Keep initial filter if any
    });
  }

  void _startPlan(BuildContext context, TrainingPlan plan) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrainingSessionPage(plan: plan)));
  }
}

class _SearchAndFiltersSection extends StatelessWidget {
  final String searchQuery;
  final TrainingCategory? selectedCategory;
  final TrainingDifficulty? selectedDifficulty;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<TrainingCategory?> onCategoryChanged;
  final ValueChanged<TrainingDifficulty?> onDifficultyChanged;
  final VoidCallback onClearFilters;

  const _SearchAndFiltersSection({
    required this.searchQuery,
    required this.selectedCategory,
    required this.selectedDifficulty,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onDifficultyChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search Bar
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Rechercher des plans d\'entraînement...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: () => onSearchChanged('')) : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),

          const SizedBox(height: 16),

          // Filter Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Category Filters
                ...TrainingCategory.values.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(category.name.toUpperCase()),
                      selected: selectedCategory == category,
                      onSelected: (selected) => onCategoryChanged(selected ? category : null),
                      avatar: Icon(_getCategoryIcon(category), size: 16),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Difficulty Filters
                ...TrainingDifficulty.values.map(
                  (difficulty) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(difficulty.name.toUpperCase()),
                      selected: selectedDifficulty == difficulty,
                      onSelected: (selected) => onDifficultyChanged(selected ? difficulty : null),
                      avatar: Icon(_getDifficultyIcon(difficulty), size: 16),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Clear Filters
                if (_hasAnyFilters()) ActionChip(label: const Text('EFFACER'), onPressed: onClearFilters, avatar: const Icon(Icons.clear, size: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _hasAnyFilters() {
    return searchQuery.isNotEmpty || selectedCategory != null || selectedDifficulty != null;
  }

  IconData _getCategoryIcon(TrainingCategory category) {
    switch (category) {
      case TrainingCategory.cardio:
        return Icons.favorite;
      case TrainingCategory.strength:
        return Icons.fitness_center;
      case TrainingCategory.yoga:
        return Icons.self_improvement;
    }
  }

  IconData _getDifficultyIcon(TrainingDifficulty difficulty) {
    switch (difficulty) {
      case TrainingDifficulty.beginner:
        return Icons.looks_one;
      case TrainingDifficulty.intermediate:
        return Icons.looks_two;
      case TrainingDifficulty.advanced:
        return Icons.looks_3;
    }
  }
}

class _EmptyPlansWidget extends StatelessWidget {
  final bool hasFilters;

  const _EmptyPlansWidget({required this.hasFilters});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(hasFilters ? Icons.search_off : Icons.fitness_center, size: 64, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              hasFilters ? 'Aucun plan ne correspond à vos filtres' : 'Aucun plan d\'entraînement disponible',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              hasFilters ? 'Essayez d\'ajuster votre recherche ou vos filtres' : 'Revenez plus tard pour du nouveau contenu d\'entraînement',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
              textAlign: TextAlign.center,
            ),
            if (hasFilters) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {}, // This would call clear filters
                child: const Text('Effacer les Filtres'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
