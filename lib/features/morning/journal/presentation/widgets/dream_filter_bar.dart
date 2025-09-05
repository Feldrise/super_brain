import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/presentation/providers/dream_journal_providers.dart';

class DreamFilterBar extends ConsumerWidget {
  const DreamFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedMood = ref.watch(selectedMoodFilterProvider);
    final selectedCategory = ref.watch(selectedCategoryFilterProvider);
    final showLucidOnly = ref.watch(showLucidOnlyProvider);

    final hasFilters = selectedMood != null || selectedCategory != null || showLucidOnly || searchQuery.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: TextEditingController(text: searchQuery)..selection = TextSelection.fromPosition(TextPosition(offset: searchQuery.length)),
              decoration: InputDecoration(
                hintText: 'Rechercher vos rêves...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty ? IconButton(onPressed: () => ref.read(searchQueryProvider.notifier).state = '', icon: const Icon(Icons.clear)) : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),

          const SizedBox(height: 12),

          // Filter Chips and Sort
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Mood Filter
                      _FilterChip(
                        label: selectedMood != null ? '${_getMoodEmoji(selectedMood)} ${_getMoodName(selectedMood)}' : 'Humeur',
                        isSelected: selectedMood != null,
                        onTap: () => _showMoodFilter(context, ref),
                      ),
                      const SizedBox(width: 8),

                      // Category Filter
                      _FilterChip(
                        label: selectedCategory != null ? '${_getCategoryEmoji(selectedCategory)} ${_getCategoryName(selectedCategory)}' : 'Catégorie',
                        isSelected: selectedCategory != null,
                        onTap: () => _showCategoryFilter(context, ref),
                      ),
                      const SizedBox(width: 8),

                      // Lucid Filter
                      _FilterChip(label: '✨ Lucides', isSelected: showLucidOnly, onTap: () => ref.read(showLucidOnlyProvider.notifier).state = !showLucidOnly),

                      if (hasFilters) ...[const SizedBox(width: 8), _FilterChip(label: 'Effacer', isSelected: false, onTap: () => _clearAllFilters(ref), icon: Icons.clear)],
                    ],
                  ),
                ),
              ),

              // Sort Button
              IconButton(onPressed: () => _showSortOptions(context, ref), icon: const Icon(Icons.sort), tooltip: 'Trier'),
            ],
          ),

          // Active Filters Summary
          if (hasFilters) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(8)),
              child: Text(
                _getFilterSummary(searchQuery, selectedMood, selectedCategory, showLucidOnly),
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getFilterSummary(String query, String? mood, String? category, bool lucidOnly) {
    final parts = <String>[];
    if (query.isNotEmpty) parts.add('Recherche: "$query"');
    if (mood != null) parts.add('Humeur: ${_getMoodName(mood)}');
    if (category != null) parts.add('Catégorie: ${_getCategoryName(category)}');
    if (lucidOnly) parts.add('Rêves lucides uniquement');
    return parts.join(' • ');
  }

  void _clearAllFilters(WidgetRef ref) {
    ref.read(searchQueryProvider.notifier).state = '';
    ref.read(selectedMoodFilterProvider.notifier).state = null;
    ref.read(selectedCategoryFilterProvider.notifier).state = null;
    ref.read(showLucidOnlyProvider.notifier).state = false;
  }

  void _showMoodFilter(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _MoodFilterSheet(
        onMoodSelected: (mood) {
          ref.read(selectedMoodFilterProvider.notifier).state = mood;
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showCategoryFilter(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _CategoryFilterSheet(
        onCategorySelected: (category) {
          ref.read(selectedCategoryFilterProvider.notifier).state = category;
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showSortOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _SortOptionsSheet(
        currentSort: ref.read(sortOrderProvider),
        onSortSelected: (sortOrder) {
          ref.read(sortOrderProvider.notifier).state = sortOrder;
          Navigator.of(context).pop();
        },
      ),
    );
  }

  String _getMoodEmoji(String mood) {
    final dreamMood = DreamMood.values.firstWhere((m) => m.name == mood, orElse: () => DreamMood.neutral);
    return dreamMood.emoji;
  }

  String _getMoodName(String mood) {
    final dreamMood = DreamMood.values.firstWhere((m) => m.name == mood, orElse: () => DreamMood.neutral);
    return dreamMood.displayName;
  }

  String _getCategoryEmoji(String category) {
    final dreamCategory = DreamCategory.values.firstWhere((c) => c.name == category, orElse: () => DreamCategory.normal);
    return dreamCategory.emoji;
  }

  String _getCategoryName(String category) {
    final dreamCategory = DreamCategory.values.firstWhere((c) => c.name == category, orElse: () => DreamCategory.normal);
    return dreamCategory.displayName;
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.isSelected, required this.onTap, this.icon});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: theme.colorScheme.primary) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 4)],
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w500 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodFilterSheet extends StatelessWidget {
  const _MoodFilterSheet({required this.onMoodSelected});

  final Function(String?) onMoodSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filtrer par humeur', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MoodOption(mood: null, label: 'Toutes les humeurs', onTap: () => onMoodSelected(null)),
              ...DreamMood.values.map((mood) => _MoodOption(mood: mood.name, label: '${mood.emoji} ${mood.displayName}', onTap: () => onMoodSelected(mood.name))),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CategoryFilterSheet extends StatelessWidget {
  const _CategoryFilterSheet({required this.onCategorySelected});

  final Function(String?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filtrer par catégorie', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MoodOption(mood: null, label: 'Toutes les catégories', onTap: () => onCategorySelected(null)),
              ...DreamCategory.values.map(
                (category) => _MoodOption(mood: category.name, label: '${category.emoji} ${category.displayName}', onTap: () => onCategorySelected(category.name)),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SortOptionsSheet extends StatelessWidget {
  const _SortOptionsSheet({required this.currentSort, required this.onSortSelected});

  final DreamSortOrder currentSort;
  final Function(DreamSortOrder) onSortSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trier par', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ...DreamSortOrder.values.map(
            (sortOrder) =>
                ListTile(title: Text(sortOrder.displayName), trailing: currentSort == sortOrder ? const Icon(Icons.check) : null, onTap: () => onSortSelected(sortOrder)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _MoodOption extends StatelessWidget {
  const _MoodOption({required this.mood, required this.label, required this.onTap});

  final String? mood;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
        child: Text(label),
      ),
    );
  }
}
