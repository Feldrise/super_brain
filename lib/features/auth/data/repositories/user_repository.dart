import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/auth/domain/entities/app_user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<AppUser> get _usersCollection => _firestore
      .collection('users')
      .withConverter<AppUser>(
        fromFirestore: (snapshot, _) => AppUser.fromJson({'id': snapshot.id, ...snapshot.data()!}),
        toFirestore: (user, _) {
          final data = user.toJson();
          data.remove('id'); // Remove id since it's the document ID
          return data;
        },
      );

  CollectionReference<UserProfile> _userProfilesCollection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('profile')
      .withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson({
          'id': userId, // Use the actual user ID, not the document ID
          ...snapshot.data()!,
        }),
        toFirestore: (profile, _) {
          final data = profile.toJson();
          data.remove('id'); // Remove id since it's not stored in the document
          return data;
        },
      );

  // Create user profile on first sign up
  Future<void> createUserProfile(AppUser user) async {
    try {
      await _usersCollection.doc(user.id).set(user);
    } catch (e) {
      throw UserRepositoryException('Failed to create user profile: $e');
    }
  }

  // Get user by ID
  Future<AppUser?> getUserById(String userId) async {
    try {
      final doc = await _usersCollection.doc(userId).get();
      return doc.data();
    } catch (e) {
      throw UserRepositoryException('Failed to get user: $e');
    }
  }

  // Update user
  Future<void> updateUser(AppUser user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toJson()..remove('id'));
    } catch (e) {
      throw UserRepositoryException('Failed to update user: $e');
    }
  }

  // Update last active timestamp
  Future<void> updateLastActive(String userId) async {
    try {
      await _usersCollection.doc(userId).update({'lastActiveAt': FieldValue.serverTimestamp()});
    } catch (e) {
      throw UserRepositoryException('Failed to update last active: $e');
    }
  }

  // Update streak count
  Future<void> updateStreakCount(String userId, int streakCount) async {
    try {
      await _usersCollection.doc(userId).update({'streakCount': streakCount});
    } catch (e) {
      throw UserRepositoryException('Failed to update streak count: $e');
    }
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    try {
      await _usersCollection.doc(userId).delete();
    } catch (e) {
      throw UserRepositoryException('Failed to delete user: $e');
    }
  }

  // Profile methods
  Future<void> createUserDetailedProfile(UserProfile profile) async {
    try {
      await _userProfilesCollection(profile.id).doc('details').set(profile);
    } catch (e) {
      throw UserRepositoryException('Failed to create user detailed profile: $e');
    }
  }

  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _userProfilesCollection(userId).doc('details').get();
      return doc.data();
    } catch (e) {
      throw UserRepositoryException('Failed to get user profile: $e');
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      await _userProfilesCollection(profile.id).doc('details').update(profile.toJson()..remove('id'));
    } catch (e) {
      throw UserRepositoryException('Failed to update user profile: $e');
    }
  }

  // Stream user data
  Stream<AppUser?> watchUser(String userId) {
    return _usersCollection.doc(userId).snapshots().map((doc) => doc.data());
  }

  Stream<UserProfile?> watchUserProfile(String userId) {
    return _userProfilesCollection(userId).doc('details').snapshots().map((doc) => doc.data());
  }
}

class UserRepositoryException implements Exception {
  final String message;

  const UserRepositoryException(this.message);

  @override
  String toString() => 'UserRepositoryException: $message';
}
