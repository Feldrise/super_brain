import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/morning/journal/domain/entities/dream_entry.dart';
import 'package:super_brain/features/morning/journal/presentation/pages/dream_entry_page.dart';
import 'package:super_brain/features/morning/journal/presentation/providers/dream_journal_providers.dart';

class DreamJournalPage extends ConsumerWidget {
  const DreamJournalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

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
      appBar: AppBar(
        title: const Text('Journal des rêves'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(onPressed: () => _showSearchDialog(context, ref), icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          if (searchQuery.isNotEmpty) _SearchHeader(query: searchQuery),
          Expanded(
            child: dreamEntriesAsync.when(
              data: (entries) {
                if (entries.isEmpty) {
                  return _EmptyState(hasSearch: searchQuery.isNotEmpty);
                }
                return _DreamEntriesList(entries: entries);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _ErrorState(error: error.toString()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToCreateDream(context),
        icon: const Icon(Icons.add),
        label: const Text('Nouveau rêve'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  void _showSearchDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechercher'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Mots-clés, humeur, catégorie...', border: OutlineInputBorder()),
          onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(searchQueryProvider.notifier).state = '';
              Navigator.of(context).pop();
            },
            child: const Text('Effacer'),
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Fermer')),
        ],
      ),
    );
  }

  void _navigateToCreateDream(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DreamEntryPage()));
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(Icons.search, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text('Recherche: "$query"', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasSearch});

  final bool hasSearch;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(hasSearch ? Icons.search_off : Icons.bedtime_outlined, size: 80, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              hasSearch ? 'Aucun rêve trouvé' : 'Aucun rêve enregistré',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              hasSearch ? 'Essayez une autre recherche' : 'Commencez à noter vos rêves\npour explorer votre monde intérieur',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text('Erreur', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.error)),
            const SizedBox(height: 8),
            Text(error, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _DreamEntriesList extends StatelessWidget {
  const _DreamEntriesList({required this.entries});

  final List<DreamEntry> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return _DreamEntryCard(entry: entry);
      },
    );
  }
}

class _DreamEntryCard extends StatelessWidget {
  const _DreamEntryCard({required this.entry});

  final DreamEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd MMM yyyy', 'fr_FR');

    return Card(
      child: InkWell(
        onTap: () => _navigateToViewDream(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (entry.mood != null) ...[Text(_getMoodEmoji(entry.mood!), style: const TextStyle(fontSize: 20)), const SizedBox(width: 8)],
                  if (entry.category != null) ...[Text(_getCategoryEmoji(entry.category!), style: const TextStyle(fontSize: 20)), const SizedBox(width: 8)],
                  if (entry.isLucid)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.amber.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        'Lucide',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.amber[800], fontWeight: FontWeight.w500),
                      ),
                    ),
                  const Spacer(),
                  Text(dateFormat.format(entry.dreamDate ?? entry.createdAt), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
              const SizedBox(height: 12),
              Text(entry.content, style: theme.textTheme.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis),
              if (entry.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: entry.tags
                      .take(3)
                      .map((tag) => Chip(label: Text(tag), labelStyle: theme.textTheme.bodySmall, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getMoodEmoji(String mood) {
    final dreamMood = DreamMood.values.firstWhere((m) => m.name == mood, orElse: () => DreamMood.neutral);
    return dreamMood.emoji;
  }

  String _getCategoryEmoji(String category) {
    final dreamCategory = DreamCategory.values.firstWhere((c) => c.name == category, orElse: () => DreamCategory.normal);
    return dreamCategory.emoji;
  }

  void _navigateToViewDream(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DreamEntryPage(entry: entry)));
  }
}
