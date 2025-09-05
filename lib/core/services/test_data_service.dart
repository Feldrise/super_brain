import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/words/domain/entities/word_list.dart';
import 'package:super_brain/features/words/data/models/word_list_models.dart';

class TestDataService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> populateTestWordLists() async {
    final testWordLists = [
      WordList(
        id: 'test_animals_1',
        title: 'Animaux sauvages - 10 mots',
        words: ['Éléphant', 'Girafe', 'Lion', 'Tigre', 'Rhinocéros', 'Hippopotame', 'Crocodile', 'Zèbre', 'Antilope', 'Léopard'],
        difficulty: 'Facile',
        category: 'Animaux',
        isUserCreated: false,
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        nextReviewAt: DateTime.now().add(const Duration(hours: 1)),
        easiness: 2.5,
        interval: 1,
        reps: 0,
      ),
      WordList(
        id: 'test_objects_1',
        title: 'Objets quotidiens - 12 mots',
        words: ['Fourchette', 'Couteau', 'Cuillère', 'Assiette', 'Verre', 'Tasse', 'Serviette', 'Nappe', 'Bougie', 'Vase', 'Miroir', 'Peigne'],
        difficulty: 'Moyen',
        category: 'Objets quotidiens',
        isUserCreated: false,
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        nextReviewAt: DateTime.now().subtract(const Duration(minutes: 30)), // Due for review
        easiness: 2.5,
        interval: 1,
        reps: 0,
      ),
      WordList(
        id: 'test_emotions_1',
        title: 'Émotions et sentiments - 8 mots',
        words: ['Joie', 'Tristesse', 'Colère', 'Peur', 'Surprise', 'Dégoût', 'Amour', 'Haine'],
        difficulty: 'Difficile',
        category: 'Émotions',
        isUserCreated: false,
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        nextReviewAt: DateTime.now().add(const Duration(days: 1)),
        easiness: 2.5,
        interval: 1,
        reps: 0,
      ),
      WordList(
        id: 'test_colors_1',
        title: 'Couleurs - 15 mots',
        words: ['Rouge', 'Bleu', 'Vert', 'Jaune', 'Orange', 'Violet', 'Rose', 'Noir', 'Blanc', 'Gris', 'Marron', 'Turquoise', 'Magenta', 'Cyan', 'Indigo'],
        difficulty: 'Facile',
        category: 'Couleurs',
        isUserCreated: false,
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        nextReviewAt: DateTime.now().add(const Duration(hours: 3)),
        easiness: 2.5,
        interval: 1,
        reps: 0,
      ),
    ];

    final batch = _firestore.batch();

    for (final wordList in testWordLists) {
      final model = WordListModel.fromDomain(wordList);
      final docRef = _firestore.collection('daily_word_lists').doc(wordList.id);

      batch.set(docRef, model.toFirestore());
    }

    await batch.commit();
    print('Successfully populated ${testWordLists.length} test word lists');
  }

  static Future<void> clearTestData() async {
    final batch = _firestore.batch();

    // Clear daily word lists
    final dailyWordLists = await _firestore.collection('daily_word_lists').where('id', whereIn: ['test_animals_1', 'test_objects_1', 'test_emotions_1', 'test_colors_1']).get();

    for (final doc in dailyWordLists.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    print('Successfully cleared test data');
  }
}
