import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/words/domain/entities/word_list.dart';
import 'package:super_brain/features/words/presentation/providers/word_list_providers.dart';
import 'package:super_brain/core/providers/auth_providers.dart';

class StudySessionPage extends ConsumerStatefulWidget {
  final WordList wordList;
  final StudyMode mode;

  const StudySessionPage({super.key, required this.wordList, this.mode = StudyMode.memorization});

  @override
  ConsumerState<StudySessionPage> createState() => _StudySessionPageState();
}

class _StudySessionPageState extends ConsumerState<StudySessionPage> {
  int _currentWordIndex = 0;
  final List<WordResult> _results = [];
  late Stopwatch _sessionStopwatch;
  late Stopwatch _wordStopwatch;
  StudySession? _currentSession;

  bool _showWord = true;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _sessionStopwatch = Stopwatch()..start();
    _wordStopwatch = Stopwatch()..start();
    _startSession();
  }

  @override
  void dispose() {
    _sessionStopwatch.stop();
    _wordStopwatch.stop();
    super.dispose();
  }

  Future<void> _startSession() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final useCase = ref.read(studyWordListUseCaseProvider);
    final session = await useCase.startStudySession(userId: user.uid, wordList: widget.wordList, mode: widget.mode);

    setState(() {
      _currentSession = session;
    });
  }

  void _recordResult(bool wasCorrect) {
    final timeSpent = _wordStopwatch.elapsed.inSeconds;
    _wordStopwatch.reset();
    _wordStopwatch.start();

    // Get the current word before incrementing the index
    final currentWord = widget.wordList.words[_currentWordIndex];
    final result = WordResult(word: currentWord, wasCorrect: wasCorrect, timeSpentSeconds: timeSpent, attempts: 1);

    setState(() {
      _results.add(result);
      _currentWordIndex++;
      _showWord = true;
      _showAnswer = false;
    });

    if (_currentWordIndex >= widget.wordList.words.length) {
      _completeSession();
    }
  }

  Future<void> _completeSession() async {
    if (_currentSession == null) return;

    _sessionStopwatch.stop();

    // Ensure we have results to calculate scores
    if (_results.isEmpty) {
      print('Warning: No results recorded for session');
      return;
    }

    final correctCount = _results.where((r) => r.wasCorrect).length;
    final accuracy = correctCount / _results.length;
    final finalScore = (accuracy * 100).round();

    try {
      final useCase = ref.read(studyWordListUseCaseProvider);
      await useCase.completeStudySession(session: _currentSession!, results: _results, finalScore: finalScore, totalTimeSeconds: _sessionStopwatch.elapsed.inSeconds);

      if (mounted) {
        _showCompletionDialog(finalScore, correctCount, _results.length);
      }
    } catch (e) {
      // print('Error completing session: $e');
      if (mounted) {
        // Still show completion dialog even if saving failed
        _showCompletionDialog(finalScore, correctCount, _results.length);
      }
    }
  }

  void _showCompletionDialog(int score, int correct, int total) {
    final isExcellent = score >= 90;
    final isGood = score >= 80;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          isExcellent
              ? 'Excellent !'
              : isGood
              ? 'Très bien !'
              : 'Bon travail !',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isExcellent
                  ? Icons.emoji_events
                  : isGood
                  ? Icons.star
                  : Icons.thumb_up,
              size: 64,
              color: isExcellent
                  ? Colors.amber
                  : isGood
                  ? Colors.green
                  : Colors.blue,
            ),
            const SizedBox(height: 16),
            Text('Score: $score%', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$correct sur $total mots corrects'),
            const SizedBox(height: 8),
            Text('Temps: ${_formatDuration(_sessionStopwatch.elapsed)}', style: Theme.of(context).textTheme.bodyMedium),
            if (widget.mode == StudyMode.recall && isGood) ...[
              const SizedBox(height: 12),
              Text(
                'Révision réussie ! Votre maîtrise s\'améliore.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green.shade700),
              ),
            ],
          ],
        ),
        actions: [
          if (!isGood && widget.mode != StudyMode.recall)
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // Restart session for poor performance
                setState(() {
                  _currentWordIndex = 0;
                  _results.clear();
                  _showWord = true;
                  _showAnswer = false;
                });
                _sessionStopwatch.reset();
                _sessionStopwatch.start();
                _wordStopwatch.reset();
                _wordStopwatch.start();
                _startSession();
              },
              child: const Text('Recommencer'),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close dialog
              Navigator.of(context).pop(); // Return to previous screen
            },
            child: const Text('Continuer'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = _currentWordIndex / widget.wordList.words.length;
    final currentWord = _currentWordIndex < widget.wordList.words.length ? widget.wordList.words[_currentWordIndex] : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wordList.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: progress, backgroundColor: theme.colorScheme.surfaceVariant, valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mot ${_currentWordIndex + 1} sur ${widget.wordList.words.length}', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                Text(
                  _formatDuration(_sessionStopwatch.elapsed),
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Word card
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
                    boxShadow: [BoxShadow(color: theme.colorScheme.shadow.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_showWord) ...[
                        Text(
                          currentWord,
                          style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Mémorisez ce mot',
                          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                      ],

                      if (_showAnswer) ...[
                        Text(
                          'Avez-vous retenu le mot ?',
                          style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Le mot était: $currentWord',
                          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Action buttons
            if (_showWord)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showWord = false;
                      _showAnswer = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Je suis prêt(e)', style: TextStyle(fontSize: 18)),
                ),
              ),

            if (_showAnswer)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _recordResult(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: theme.colorScheme.onError,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Non', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _recordResult(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Oui', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
