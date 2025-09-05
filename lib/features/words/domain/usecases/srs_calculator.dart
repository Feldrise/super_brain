import 'package:super_brain/features/words/domain/entities/word_list.dart';

/// Spaced Repetition System (SRS) calculator based on SM-2 algorithm
class SrsCalculator {
  /// Calculate next review data based on performance
  static SrsResult calculateNextReview({
    required double currentEasiness,
    required int currentInterval,
    required int currentReps,
    required int quality, // 0-5 scale (0=terrible, 5=perfect)
  }) {
    double newEasiness = currentEasiness;
    int newInterval = currentInterval;
    int newReps = currentReps;

    if (quality >= 3) {
      // Correct response
      newReps += 1;

      if (newReps == 1) {
        newInterval = 1;
      } else if (newReps == 2) {
        newInterval = 6;
      } else {
        newInterval = (currentInterval * newEasiness).round();
      }

      // Update easiness factor
      newEasiness = newEasiness + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));

      // Ensure easiness doesn't go below 1.3
      if (newEasiness < 1.3) {
        newEasiness = 1.3;
      }
    } else {
      // Incorrect response - reset repetitions but keep easiness
      newReps = 0;
      newInterval = 1;
    }

    final nextReviewAt = DateTime.now().add(Duration(days: newInterval));

    return SrsResult(easiness: newEasiness, interval: newInterval, reps: newReps, nextReviewAt: nextReviewAt);
  }

  /// Check if a word list is due for review
  static bool isDueForReview(WordList wordList) {
    if (wordList.nextReviewAt == null) return true;
    return DateTime.now().isAfter(wordList.nextReviewAt!);
  }

  /// Get the next review time in a human-readable format
  static String getNextReviewText(DateTime? nextReviewAt) {
    if (nextReviewAt == null) return 'Maintenant';

    final now = DateTime.now();
    final difference = nextReviewAt.difference(now);

    if (difference.isNegative) return 'Maintenant';

    if (difference.inDays > 0) {
      return 'Dans ${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Dans ${difference.inHours} heure${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'Dans ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'Maintenant';
    }
  }
}

class SrsResult {
  final double easiness;
  final int interval;
  final int reps;
  final DateTime nextReviewAt;

  const SrsResult({required this.easiness, required this.interval, required this.reps, required this.nextReviewAt});
}
