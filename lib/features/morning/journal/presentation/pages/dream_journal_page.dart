import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/presentation/pages/dream_entry_page.dart';
import 'package:super_brain/features/morning/journal/presentation/providers/dream_journal_providers.dart';
import 'package:super_brain/features/morning/journal/presentation/widgets/dream_stats_header.dart';
import 'package:super_brain/features/morning/journal/presentation/widgets/dream_filter_bar.dart';
import 'package:super_brain/features/morning/journal/presentation/widgets/dream_entry_card.dart';
import 'package:super_brain/features/morning/journal/presentation/widgets/dream_empty_state.dart';

class DreamJournalPage extends ConsumerWidget {
  const DreamJournalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final theme = Theme.of(context);

    // Check if user is authenticated
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Journal des rêves'), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
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
                  'Vous devez être connecté pour accéder à votre journal des rêves.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final dreamEntriesAsync = ref.watch(filteredDreamEntriesProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            title: const Text('Journal de Rêves'),
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: theme.colorScheme.surface,
            elevation: 0,
            floating: true,
            snap: true,
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DreamEntryPage())),
                icon: const Icon(Icons.add),
                tooltip: 'Nouveau rêve',
              ),
            ],
          ),

          // Stats Header
          const SliverToBoxAdapter(child: DreamStatsHeader()),

          // Filter Bar
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(child: DreamFilterBar()),

          // Content
          dreamEntriesAsync.when(
            data: (dreams) {
              if (dreams.isEmpty) {
                return SliverFillRemaining(
                  child: DreamEmptyState(
                    onCreateFirst: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DreamEntryPage())),
                    hasSearchQuery: searchQuery.isNotEmpty,
                    searchQuery: searchQuery,
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.only(top: 16, bottom: 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final dream = dreams[index];
                    return DreamEntryCard(
                      dreamEntry: dream,
                      onTap: () => _viewDream(context, dream),
                      onEdit: () => _editDream(context, dream),
                      onDelete: () => _deleteDream(context, ref, dream),
                    );
                  }, childCount: dreams.length),
                ),
              );
            },
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
                    const SizedBox(height: 16),
                    Text('Erreur lors du chargement', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(error.toString(), style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(onPressed: () => ref.refresh(filteredDreamEntriesProvider), child: const Text('Réessayer')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DreamEntryPage())),
        icon: const Icon(Icons.add),
        label: const Text('Nouveau rêve'),
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }

  void _viewDream(BuildContext context, DreamEntry dream) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DreamEntryPage(entry: dream)));
  }

  void _editDream(BuildContext context, DreamEntry dream) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DreamEntryPage(entry: dream)));
  }

  void _deleteDream(BuildContext context, WidgetRef ref, DreamEntry dream) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le rêve'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer ce rêve ? '
          'Cette action ne peut pas être annulée.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Annuler')),
          FilledButton(
            onPressed: () async {
              try {
                final deleteUseCase = ref.read(deleteDreamEntryUseCaseProvider);
                if (deleteUseCase != null) {
                  await deleteUseCase.call(dream.id);

                  // Refresh the dream entries list
                  ref.invalidate(dreamEntriesProvider);
                  ref.invalidate(filteredDreamEntriesProvider);

                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rêve supprimé'), behavior: SnackBarBehavior.floating));
                  }
                } else {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Erreur: utilisateur non connecté'), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating));
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Erreur lors de la suppression'), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating));
                }
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error, foregroundColor: Theme.of(context).colorScheme.onError),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
