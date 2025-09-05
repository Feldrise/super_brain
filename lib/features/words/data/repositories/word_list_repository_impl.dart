import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/words/data/models/word_list_models.dart';
import 'package:super_brain/features/words/domain/entities/word_list.dart';
import 'package:super_brain/features/words/domain/repositories/word_list_repository.dart';

class WordListRepositoryImpl implements WordListRepository {
  final FirebaseFirestore _firestore;

  WordListRepositoryImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<WordListModel> _userWordListsCollection(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('word_lists')
        .withConverter<WordListModel>(fromFirestore: (snapshot, _) => WordListModel.fromFirestore(snapshot), toFirestore: (wordList, _) => wordList.toFirestore());
  }

  CollectionReference<WordListModel> _dailyWordListsCollection() {
    return _firestore
        .collection('daily_word_lists')
        .withConverter<WordListModel>(fromFirestore: (snapshot, _) => WordListModel.fromFirestore(snapshot), toFirestore: (wordList, _) => wordList.toFirestore());
  }

  CollectionReference<StudySessionModel> _studySessionsCollection(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('study_sessions')
        .withConverter<StudySessionModel>(fromFirestore: (snapshot, _) => StudySessionModel.fromFirestore(snapshot), toFirestore: (session, _) => session.toFirestore());
  }

  @override
  Stream<List<WordList>> watchUserWordLists(String userId) {
    return _userWordListsCollection(
      userId,
    ).where('isActive', isEqualTo: true).orderBy('createdAt', descending: true).snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()).toList());
  }

  @override
  Stream<List<WordList>> watchDueWordLists(String userId) {
    return _userWordListsCollection(userId)
        .where('isActive', isEqualTo: true)
        .where('nextReviewAt', isLessThanOrEqualTo: Timestamp.now())
        .orderBy('nextReviewAt')
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()).toList());
  }

  @override
  Stream<List<WordList>> watchDailyWordLists() {
    return _dailyWordListsCollection()
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()).toList());
  }

  @override
  Future<WordList?> getWordList(String id, {String? userId}) async {
    // First try to get from daily word lists
    try {
      final dailyDoc = await _dailyWordListsCollection().doc(id).get();
      if (dailyDoc.exists) {
        return dailyDoc.data()?.toDomain();
      }
    } catch (e) {
      print('Error fetching from daily word lists: $e');
    }

    // If not found in daily and userId is provided, try user word lists
    if (userId != null) {
      try {
        final userDoc = await _userWordListsCollection(userId).doc(id).get();
        if (userDoc.exists) {
          return userDoc.data()?.toDomain();
        }
      } catch (e) {
        print('Error fetching from user word lists: $e');
      }
    }

    return null;
  }

  @override
  Future<void> saveWordList(WordList wordList, String userId) async {
    final model = WordListModel.fromDomain(wordList);

    if (wordList.isUserCreated) {
      await _userWordListsCollection(userId).doc(wordList.id).set(model);
    } else {
      // This would be for admin/system created daily lists
      await _dailyWordListsCollection().doc(wordList.id).set(model);
    }
  }

  @override
  Future<void> deleteWordList(String id, String userId) async {
    await _userWordListsCollection(userId).doc(id).delete();
  }

  @override
  Future<void> updateSrsData(String wordListId, String userId, {required double easiness, required int interval, required int reps, required DateTime nextReviewAt}) async {
    await _userWordListsCollection(userId).doc(wordListId).update({'easiness': easiness, 'interval': interval, 'reps': reps, 'nextReviewAt': Timestamp.fromDate(nextReviewAt)});
  }

  @override
  Future<void> saveStudySession(StudySession session) async {
    final model = StudySessionModel.fromDomain(session);
    await _studySessionsCollection(session.userId).doc(session.id).set(model);
  }

  @override
  Stream<List<StudySession>> watchStudySessions(String userId) {
    return _studySessionsCollection(
      userId,
    ).orderBy('startedAt', descending: true).limit(50).snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()).toList());
  }
}
