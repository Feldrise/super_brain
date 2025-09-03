import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/core/services/auth_service.dart';
import 'package:super_brain/features/auth/domain/entities/app_user.dart';
import 'package:super_brain/features/auth/data/repositories/user_repository.dart';

// Auth controller state
class AuthState {
  final bool isLoading;
  final String? error;
  final bool isRegistering;

  const AuthState({this.isLoading = false, this.error, this.isRegistering = false});

  AuthState copyWith({bool? isLoading, String? error, bool? isRegistering}) {
    return AuthState(isLoading: isLoading ?? this.isLoading, error: error, isRegistering: isRegistering ?? this.isRegistering);
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;
  final UserRepository _userRepository;

  AuthController(this._authService, this._userRepository) : super(const AuthState());

  Future<bool> signInWithEmailAndPassword({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authService.signInWithEmailAndPassword(email: email, password: password);

      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An unexpected error occurred');
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword({required String email, required String password, required String displayName}) async {
    state = state.copyWith(isLoading: true, error: null, isRegistering: true);

    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(email: email, password: password);

      // Update display name
      await _authService.updateProfile(displayName: displayName);

      // Create user profile in Firestore
      await _createUserProfile(userCredential.user!, displayName);

      state = state.copyWith(isLoading: false, isRegistering: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message, isRegistering: false);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An unexpected error occurred', isRegistering: false);
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userCredential = await _authService.signInWithGoogle();

      // Check if this is a new user
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await _createUserProfile(userCredential.user!, userCredential.user!.displayName);
      }

      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An unexpected error occurred');
      return false;
    }
  }

  Future<bool> signInWithApple() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userCredential = await _authService.signInWithApple();

      // Check if this is a new user
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await _createUserProfile(userCredential.user!, userCredential.user!.displayName);
      }

      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An unexpected error occurred');
      return false;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authService.sendPasswordResetEmail(email: email);
      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An unexpected error occurred');
      return false;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authService.signOut();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to sign out');
    }
  }

  Future<void> _createUserProfile(dynamic user, String? displayName) async {
    final appUser = AppUser(id: user.uid, email: user.email!, displayName: displayName, photoURL: user.photoURL, createdAt: DateTime.now(), lastActiveAt: DateTime.now());

    await _userRepository.createUserProfile(appUser);

    // Also create a default detailed profile
    final userProfile = UserProfile(id: user.uid, email: user.email!, displayName: displayName, photoURL: user.photoURL, createdAt: DateTime.now(), updatedAt: DateTime.now());

    await _userRepository.createUserDetailedProfile(userProfile);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Auth controller provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthController(authService, userRepository);
});
