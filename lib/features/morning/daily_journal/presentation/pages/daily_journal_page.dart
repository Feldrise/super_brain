import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/morning/daily_journal/domain/entities/daily_entry.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/pages/daily_entry_page.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/providers/daily_journal_providers.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/widgets/daily_stats_header.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/widgets/daily_entry_card.dart';
import 'package:super_brain/features/morning/daily_journal/presentation/widgets/daily_empty_state.dart';

class DailyJournalPage extends ConsumerWidget {
  const DailyJournalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final theme = Theme.of(context);

    // Check if user is authenticated
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Journal Quotidien'), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text('Connexion requise', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  'Vous devez être connecté pour accéder à votre journal quotidien.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final dailyEntriesAsync = ref.watch(filteredDailyEntriesProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Quotidien'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () => _showSearchDialog(context, ref))],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DailyEntryPage())),
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle entrée'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: DailyStatsHeader()),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          dailyEntriesAsync.when(
            data: (entries) {
              if (entries.isEmpty) {
                return SliverFillRemaining(
                  child: DailyEmptyState(
                    onCreateFirst: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DailyEntryPage())),
                    hasSearchQuery: searchQuery.isNotEmpty,
                    searchQuery: searchQuery,
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.only(top: 16, bottom: 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final entry = entries[index];
                    return DailyEntryCard(
                      dailyEntry: entry,
                      onTap: () => _viewEntry(context, entry),
                      onEdit: () => _editEntry(context, entry),
                      onDelete: () => _deleteEntry(context, ref, entry),
                    );
                  }, childCount: entries.length),
                ),
              );
            },
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('Erreur de chargement', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      'Impossible de charger vos entrées de journal: $error',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: () => ref.refresh(dailyEntriesProvider), child: const Text('Réessayer')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    final currentQuery = ref.read(searchQueryProvider);
    final controller = TextEditingController(text: currentQuery);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechercher'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Mots-clés, gratitude, objectifs...', border: OutlineInputBorder()),
          autofocus: true,
          onSubmitted: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(searchQueryProvider.notifier).state = '';
              Navigator.of(context).pop();
            },
            child: const Text('Effacer'),
          ),
          TextButton(
            onPressed: () {
              ref.read(searchQueryProvider.notifier).state = controller.text;
              Navigator.of(context).pop();
            },
            child: const Text('Rechercher'),
          ),
        ],
      ),
    );
  }

  void _viewEntry(BuildContext context, DailyEntry entry) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DailyEntryPage(entry: entry, isReadOnly: true)));
  }

  void _editEntry(BuildContext context, DailyEntry entry) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DailyEntryPage(entry: entry)));
  }

  void _deleteEntry(BuildContext context, WidgetRef ref, DailyEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'entrée'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cette entrée de journal ?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Annuler')),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final deleteUseCase = ref.read(deleteDailyEntryUseCaseProvider);
              if (deleteUseCase != null) {
                try {
                  await deleteUseCase.call(entry.id);
                  ref.invalidate(dailyEntriesProvider);
                  ref.invalidate(todaysDailyEntryProvider);
                  ref.invalidate(filteredDailyEntriesProvider);
                  ref.invalidate(journalStreakProvider);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entrée supprimée')));
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la suppression: $e')));
                  }
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
