import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/features/words/domain/entities/word_list.dart';
import 'package:super_brain/features/words/presentation/providers/word_list_providers.dart';
import 'package:super_brain/core/providers/auth_providers.dart';

class WordLearningPage extends ConsumerStatefulWidget {
  final WordList wordList;

  const WordLearningPage({super.key, required this.wordList});

  @override
  ConsumerState<WordLearningPage> createState() => _WordLearningPageState();
}

class _WordLearningPageState extends ConsumerState<WordLearningPage> {
  int _currentWordIndex = 0;
  bool _isLearningPhase = true;
  bool _isTestingPhase = false;
  bool _showingWord = true;
  final List<WordResult> _results = [];
  late Stopwatch _sessionStopwatch;
  StudySession? _currentSession;

  // Learning phase state
  Timer? _autoAdvanceTimer;
  bool _isAutoMode = true;
  final int _wordDisplayDuration = 3; // seconds

  @override
  void initState() {
    super.initState();
    _sessionStopwatch = Stopwatch()..start();

    // Use a post-frame callback to ensure the widget is fully built before starting async operations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startSession();
        // Add a small delay before starting auto-learning to prevent race conditions
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            _startAutoLearning();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _sessionStopwatch.stop();
    super.dispose();
  }

  Future<void> _startSession() async {
    if (!mounted) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    try {
      final useCase = ref.read(studyWordListUseCaseProvider);
      final session = await useCase.startStudySession(userId: user.uid, wordList: widget.wordList, mode: StudyMode.firstTime);

      if (mounted) {
        setState(() {
          _currentSession = session;
        });
      }
    } catch (e) {
      // print('Error starting session: $e');
      if (mounted) {
        // Show error dialog or handle gracefully
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors du démarrage de la session: $e')));
      }
    }
  }

  void _startAutoLearning() {
    // Cancel any existing timer first
    _autoAdvanceTimer?.cancel();

    if (_isAutoMode && _isLearningPhase && mounted && widget.wordList.words.isNotEmpty) {
      _autoAdvanceTimer = Timer(Duration(seconds: _wordDisplayDuration), () {
        if (mounted && _isLearningPhase && _isAutoMode && _currentWordIndex < widget.wordList.words.length) {
          if (_currentWordIndex < widget.wordList.words.length - 1) {
            setState(() {
              _currentWordIndex++;
            });
            _startAutoLearning();
          } else {
            _finishLearningPhase();
          }
        }
      });
    }
  }

  void _finishLearningPhase() {
    _autoAdvanceTimer?.cancel();
    if (mounted) {
      setState(() {
        _isLearningPhase = false;
        _isTestingPhase = true;
        _currentWordIndex = 0;
        _showingWord = false;
      });
    }
  }

  void _recordTestResult(bool wasCorrect) {
    if (!mounted || _currentWordIndex >= widget.wordList.words.length) return;

    final currentWord = widget.wordList.words[_currentWordIndex];
    final result = WordResult(word: currentWord, wasCorrect: wasCorrect, timeSpentSeconds: 3, attempts: 1);

    if (mounted) {
      setState(() {
        _results.add(result);
        if (_currentWordIndex < widget.wordList.words.length - 1) {
          _currentWordIndex++;
          _showingWord = false;
        } else {
          _completeSession();
        }
      });
    }
  }

  Future<void> _completeSession() async {
    if (_currentSession == null || !mounted) return;

    _sessionStopwatch.stop();

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
        _showCompletionDialog(finalScore, correctCount, _results.length);
      }
    }
  }

  void _showCompletionDialog(int score, int correct, int total) {
    if (!mounted) return;

    final isLearned = score >= 80;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(isLearned ? 'Félicitations !' : 'Bon travail !'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isLearned ? Icons.emoji_events : Icons.thumb_up, size: 64, color: isLearned ? Colors.amber : Colors.blue),
            const SizedBox(height: 16),
            Text('Score: $score%', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$correct sur $total mots corrects'),
            const SizedBox(height: 8),
            Text(
              isLearned ? 'Cette liste est maintenant ajoutée à vos listes apprises !' : 'Continuez à vous entraîner pour maîtriser cette liste.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          if (!isLearned)
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _restartSession();
              },
              child: const Text('Recommencer'),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Continuer'),
          ),
        ],
      ),
    );
  }

  void _restartSession() {
    _autoAdvanceTimer?.cancel();

    if (mounted) {
      setState(() {
        _currentWordIndex = 0;
        _isLearningPhase = true;
        _isTestingPhase = false;
        _showingWord = true;
        _results.clear();
        _currentSession = null;
      });
      _sessionStopwatch.reset();
      _sessionStopwatch.start();

      // Restart with a small delay to ensure state is properly set
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          _startSession();
          _startAutoLearning();
        }
      });
    }
  }

  void _toggleAutoMode() {
    _autoAdvanceTimer?.cancel();

    if (mounted) {
      setState(() {
        _isAutoMode = !_isAutoMode;
      });

      if (_isAutoMode && _isLearningPhase) {
        _startAutoLearning();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || widget.wordList.words.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Ensure currentWordIndex is within bounds
    if (_currentWordIndex >= widget.wordList.words.length) {
      _currentWordIndex = widget.wordList.words.length - 1;
    }

    final theme = Theme.of(context);
    final currentWord = widget.wordList.words[_currentWordIndex];

    if (_isLearningPhase) {
      return _buildLearningPhase(context, theme, currentWord);
    } else if (_isTestingPhase) {
      return _buildTestingPhase(context, theme, currentWord);
    } else {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }

  Widget _buildLearningPhase(BuildContext context, ThemeData theme, String currentWord) {
    final progress = (_currentWordIndex + 1) / widget.wordList.words.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Apprentissage - ${widget.wordList.title}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: progress, backgroundColor: theme.colorScheme.surfaceVariant, valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary)),
        ),
        actions: [IconButton(onPressed: _toggleAutoMode, icon: Icon(_isAutoMode ? Icons.pause : Icons.play_arrow), tooltip: _isAutoMode ? 'Mode manuel' : 'Mode automatique')],
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Phase d\'apprentissage',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Word display
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [theme.colorScheme.primaryContainer.withOpacity(0.8), theme.colorScheme.secondaryContainer.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: theme.colorScheme.shadow.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentWord,
                        style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimaryContainer),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Mémorisez ce mot',
                        style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8)),
                        textAlign: TextAlign.center,
                      ),
                      if (_isAutoMode) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Avancement automatique...',
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6), fontStyle: FontStyle.italic),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Navigation buttons
            Row(
              children: [
                if (_currentWordIndex > 0)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _autoAdvanceTimer?.cancel();
                        if (mounted && _currentWordIndex > 0) {
                          setState(() {
                            _currentWordIndex--;
                          });
                          if (_isAutoMode && _isLearningPhase) _startAutoLearning();
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Précédent'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                if (_currentWordIndex > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _autoAdvanceTimer?.cancel();
                      if (mounted && _currentWordIndex < widget.wordList.words.length) {
                        if (_currentWordIndex < widget.wordList.words.length - 1) {
                          setState(() {
                            _currentWordIndex++;
                          });
                          if (_isAutoMode && _isLearningPhase) _startAutoLearning();
                        } else {
                          _finishLearningPhase();
                        }
                      }
                    },
                    icon: Icon(_currentWordIndex < widget.wordList.words.length - 1 ? Icons.arrow_forward : Icons.quiz),
                    label: Text(_currentWordIndex < widget.wordList.words.length - 1 ? 'Suivant' : 'Tester mes connaissances'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestingPhase(BuildContext context, ThemeData theme, String currentWord) {
    final progress = (_currentWordIndex + 1) / widget.wordList.words.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Test - ${widget.wordList.title}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: progress, backgroundColor: theme.colorScheme.surfaceVariant, valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
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
                Text(
                  'Question ${_currentWordIndex + 1} sur ${widget.wordList.words.length}',
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Phase de test',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.orange.shade700, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Test content
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.orange.withOpacity(0.3), width: 2),
                    boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_showingWord) ...[
                        Icon(Icons.quiz, size: 48, color: Colors.orange),
                        const SizedBox(height: 24),
                        Text(
                          'Vous souvenez-vous de ce mot ?',
                          style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                _showingWord = true;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Révéler le mot', style: TextStyle(fontSize: 16)),
                        ),
                      ],

                      if (_showingWord) ...[
                        Text(
                          currentWord,
                          style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.orange),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'L\'aviez-vous retenu ?',
                          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Answer buttons
            if (_showingWord)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _recordTestResult(false),
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
                      onPressed: () => _recordTestResult(true),
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
