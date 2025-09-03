import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance, _googleSignIn = googleSignIn ?? GoogleSignIn();

  // Auth state stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Email & Password Sign In
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Email & Password Sign Up
  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(code: 'google-sign-in-cancelled', message: 'Google sign in was cancelled by user');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(code: 'google-sign-in-error', message: 'Google sign in failed: $e');
    }
  }

  // Apple Sign In
  Future<UserCredential> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);

      final oauthCredential = OAuthProvider("apple.com").credential(idToken: appleCredential.identityToken, accessToken: appleCredential.authorizationCode);

      return await _firebaseAuth.signInWithCredential(oauthCredential);
    } on SignInWithAppleAuthorizationException catch (e) {
      throw AuthException(code: 'apple-sign-in-error', message: 'Apple sign in failed: ${e.message}');
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(code: 'apple-sign-in-error', message: 'Apple sign in failed: $e');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      throw AuthException(code: 'sign-out-error', message: 'Failed to sign out: $e');
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      await currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Update profile
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      await currentUser?.updateDisplayName(displayName);
      await currentUser?.updatePhotoURL(photoURL);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    try {
      await currentUser?.verifyBeforeUpdateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Reauthenticate with email and password
  Future<void> reauthenticateWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = EmailAuthProvider.credential(email: email, password: password);
      await currentUser?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  // Map Firebase Auth exceptions to custom exceptions
  AuthException _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthException(code: 'user-not-found', message: 'No user found with this email address.');
      case 'wrong-password':
        return const AuthException(code: 'wrong-password', message: 'Wrong password provided.');
      case 'invalid-email':
        return const AuthException(code: 'invalid-email', message: 'Email address is invalid.');
      case 'user-disabled':
        return const AuthException(code: 'user-disabled', message: 'This user account has been disabled.');
      case 'too-many-requests':
        return const AuthException(code: 'too-many-requests', message: 'Too many requests. Try again later.');
      case 'operation-not-allowed':
        return const AuthException(code: 'operation-not-allowed', message: 'This sign-in method is not allowed.');
      case 'weak-password':
        return const AuthException(code: 'weak-password', message: 'Password is too weak.');
      case 'email-already-in-use':
        return const AuthException(code: 'email-already-in-use', message: 'An account already exists with this email address.');
      case 'requires-recent-login':
        return const AuthException(code: 'requires-recent-login', message: 'This action requires recent authentication. Please sign in again.');
      default:
        return AuthException(code: e.code, message: e.message ?? 'An unknown error occurred.');
    }
  }
}

class AuthException implements Exception {
  final String code;
  final String message;

  const AuthException({required this.code, required this.message});

  @override
  String toString() => 'AuthException($code): $message';
}
