import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/words/domain/entities/word_list.dart';
import 'package:super_brain/features/words/domain/usecases/srs_calculator.dart';
import 'package:super_brain/features/words/presentation/pages/study_session_page.dart';
import 'package:super_brain/features/words/presentation/pages/word_learning_page.dart';
import 'package:super_brain/features/words/presentation/providers/word_list_providers.dart';

class WordsSection extends ConsumerWidget {
  const WordsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Nouveaux'),
              Tab(text: 'Appris'),
              Tab(text: 'À réviser'),
            ],
          ),
          Expanded(child: TabBarView(children: [_NewWordListsTab(), _LearnedWordListsTab(), _DueWordListsTab()])),
        ],
      ),
    );
  }
}

class _NewWordListsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordListsAsync = ref.watch(allWordListsProvider);

    return wordListsAsync.when(
      data: (wordLists) {
        if (wordLists.isEmpty) {
          return const _EmptyState(icon: Icons.list_alt, title: 'Aucune nouvelle liste', subtitle: 'Les nouvelles listes de mots apparaîtront ici.');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: wordLists.length,
          itemBuilder: (context, index) {
            final wordList = wordLists[index];
            return _WordListCard(
              wordList: wordList,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WordLearningPage(wordList: wordList)));
              },
              showLearnedStatus: false,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _ErrorState(onRetry: () => ref.refresh(allWordListsProvider)),
    );
  }
}

class _LearnedWordListsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordListsAsync = ref.watch(learnedWordListsProvider);

    return wordListsAsync.when(
      data: (wordLists) {
        if (wordLists.isEmpty) {
          return const _EmptyState(icon: Icons.emoji_events, title: 'Aucune liste apprise', subtitle: 'Les listes que vous maîtrisez apparaîtront ici.');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: wordLists.length,
          itemBuilder: (context, index) {
            final wordList = wordLists[index];
            return _WordListCard(
              wordList: wordList,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StudySessionPage(wordList: wordList, mode: StudyMode.recall),
                  ),
                );
              },
              showLearnedStatus: true,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _ErrorState(onRetry: () => ref.refresh(learnedWordListsProvider)),
    );
  }
}

class _DueWordListsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordListsAsync = ref.watch(dueWordListsProvider);

    return wordListsAsync.when(
      data: (wordLists) {
        if (wordLists.isEmpty) {
          return const _EmptyState(icon: Icons.schedule, title: 'Aucune révision', subtitle: 'Les listes à réviser apparaîtront ici.');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: wordLists.length,
          itemBuilder: (context, index) {
            final wordList = wordLists[index];
            return _WordListCard(
              wordList: wordList,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StudySessionPage(wordList: wordList, mode: StudyMode.recall),
                  ),
                );
              },
              showLearnedStatus: false,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _ErrorState(onRetry: () => ref.refresh(dueWordListsProvider)),
    );
  }
}

class _WordListCard extends StatelessWidget {
  const _WordListCard({required this.wordList, required this.onTap, required this.showLearnedStatus});

  final WordList wordList;
  final VoidCallback onTap;
  final bool showLearnedStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextReviewText = SrsCalculator.getNextReviewText(wordList.nextReviewAt);
    final isDue = SrsCalculator.isDueForReview(wordList);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Row(
          children: [
            Expanded(
              child: Text(wordList.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            ),
            if (showLearnedStatus && wordList.isLearned)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      'Appris',
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.green, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Preview of first few words
            Text(
              wordList.words.take(3).join(', ') + (wordList.words.length > 3 ? '...' : ''),
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _DifficultyChip(wordList.difficulty),
                const SizedBox(width: 8),
                if (!showLearnedStatus || !wordList.isLearned) ...[
                  Icon(Icons.schedule, size: 16, color: isDue ? Colors.red : theme.colorScheme.primary),
                  const SizedBox(width: 4),
                  Text(
                    nextReviewText,
                    style: theme.textTheme.bodySmall?.copyWith(color: isDue ? Colors.red : theme.colorScheme.primary, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                ],
                if (showLearnedStatus && wordList.averageScore > 0) ...[
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '${wordList.averageScore.round()}%',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.amber.shade700, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                ],
                if (wordList.isUserCreated) Icon(Icons.person, size: 16, color: theme.colorScheme.secondary),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('${wordList.words.length} mots', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                if (showLearnedStatus && wordList.completedSessions > 0) ...[
                  const SizedBox(width: 8),
                  Text(
                    '• ${wordList.completedSessions} session${wordList.completedSessions > 1 ? 's' : ''}',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isDue && !wordList.isLearned)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
              )
            else if (wordList.isLearned)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.replay, size: 16, color: Colors.white),
              )
            else
              Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurfaceVariant),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip(this.difficulty);

  final String difficulty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color color;
    switch (difficulty.toLowerCase()) {
      case 'facile':
        color = Colors.green;
        break;
      case 'moyen':
        color = Colors.orange;
        break;
      case 'difficile':
        color = Colors.red;
        break;
      default:
        color = theme.colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        difficulty,
        style: theme.textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(title, style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text('Une erreur est survenue'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Réessayer')),
        ],
      ),
    );
  }
}
