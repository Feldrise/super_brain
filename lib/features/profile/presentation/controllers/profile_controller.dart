import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/core/services/auth_service.dart';
import 'package:super_brain/features/auth/domain/entities/app_user.dart';
import 'package:super_brain/features/auth/data/repositories/user_repository.dart';

// Profile controller state
class ProfileState {
  final bool isLoading;
  final String? error;
  final bool isUpdating;

  const ProfileState({this.isLoading = false, this.error, this.isUpdating = false});

  ProfileState copyWith({bool? isLoading, String? error, bool? isUpdating}) {
    return ProfileState(isLoading: isLoading ?? this.isLoading, error: error, isUpdating: isUpdating ?? this.isUpdating);
  }
}

class ProfileController extends StateNotifier<ProfileState> {
  final AuthService _authService;
  final UserRepository _userRepository;

  ProfileController(this._authService, this._userRepository) : super(const ProfileState());

  Future<bool> updateProfile({String? displayName, String? photoURL}) async {
    state = state.copyWith(isUpdating: true, error: null);

    try {
      // Update Firebase Auth profile
      await _authService.updateProfile(displayName: displayName, photoURL: photoURL);

      // Update Firestore user data
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        final userRepository = _userRepository;
        final existingUser = await userRepository.getUserById(currentUser.uid);

        if (existingUser != null) {
          final updatedUser = existingUser.copyWith(displayName: displayName, photoURL: photoURL);
          await userRepository.updateUser(updatedUser);
        }

        // Also update detailed profile
        final existingProfile = await userRepository.getUserProfile(currentUser.uid);
        if (existingProfile != null) {
          final updatedProfile = existingProfile.copyWith(displayName: displayName, photoURL: photoURL, updatedAt: DateTime.now());
          await userRepository.updateUserProfile(updatedProfile);
        }
      }

      state = state.copyWith(isUpdating: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isUpdating: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isUpdating: false, error: 'Failed to update profile');
      return false;
    }
  }

  Future<bool> updateUserProfile(UserProfile profile) async {
    state = state.copyWith(isUpdating: true, error: null);

    try {
      final updatedProfile = profile.copyWith(updatedAt: DateTime.now());
      await _userRepository.updateUserProfile(updatedProfile);

      state = state.copyWith(isUpdating: false);
      return true;
    } catch (e) {
      state = state.copyWith(isUpdating: false, error: 'Failed to update profile');
      return false;
    }
  }

  Future<bool> updateEmail(String newEmail) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authService.updateEmail(newEmail);
      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to update email');
      return false;
    }
  }

  Future<bool> updatePassword(String newPassword) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authService.updatePassword(newPassword);
      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to update password');
      return false;
    }
  }

  Future<bool> reauthenticate({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authService.reauthenticateWithEmailAndPassword(email: email, password: password);
      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to reauthenticate');
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        // Delete user data from Firestore
        await _userRepository.deleteUser(currentUser.uid);

        // Delete Firebase Auth account
        await _authService.deleteAccount();
      }

      state = const ProfileState();
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to delete account');
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Profile controller provider
final profileControllerProvider = StateNotifierProvider<ProfileController, ProfileState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return ProfileController(authService, userRepository);
});
