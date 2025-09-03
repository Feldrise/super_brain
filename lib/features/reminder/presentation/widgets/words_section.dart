import 'package:flutter/material.dart';

class WordsSection extends StatelessWidget {
  const WordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration - word lists for memory training
    final wordLists = [
      {
        'title': 'Liste animaux - 15 mots',
        'words': ['Éléphant', 'Papillon', 'Renard', 'Dauphin', 'Hibou'],
        'totalWords': 15,
        'nextReview': 'Dans 2 heures',
        'difficulty': 'Facile',
      },
      {
        'title': 'Objets quotidiens - 20 mots',
        'words': ['Fourchette', 'Parapluie', 'Clavier', 'Bouteille', 'Miroir'],
        'totalWords': 20,
        'nextReview': 'Dans 1 jour',
        'difficulty': 'Moyen',
      },
      {
        'title': 'Mots abstraits - 12 mots',
        'words': ['Liberté', 'Courage', 'Harmonie', 'Mystère', 'Passion'],
        'totalWords': 12,
        'nextReview': 'Dans 3 jours',
        'difficulty': 'Difficile',
      },
    ];

    if (wordLists.isEmpty) {
      return const _EmptyState(icon: Icons.list_alt, title: 'Aucune liste à réviser', subtitle: 'Créez vos premières listes de mots pour entraîner votre mémoire !');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wordLists.length,
      itemBuilder: (context, index) {
        final wordList = wordLists[index];
        return _WordListCard(
          title: wordList['title']! as String,
          words: wordList['words']! as List<String>,
          totalWords: wordList['totalWords']! as int,
          nextReview: wordList['nextReview']! as String,
          difficulty: wordList['difficulty']! as String,
          onTap: () {
            // TODO: Start memory training for this word list
          },
        );
      },
    );
  }
}

class _WordListCard extends StatelessWidget {
  const _WordListCard({required this.title, required this.words, required this.totalWords, required this.nextReview, required this.difficulty, required this.onTap});

  final String title;
  final List<String> words;
  final int totalWords;
  final String nextReview;
  final String difficulty;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Preview of first few words
            Text(
              words.take(3).join(', ') + (words.length > 3 ? '...' : ''),
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _DifficultyChip(difficulty),
                const SizedBox(width: 8),
                Icon(Icons.schedule, size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  nextReview,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurfaceVariant)],
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
