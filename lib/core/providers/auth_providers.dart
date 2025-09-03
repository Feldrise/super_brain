import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/services/auth_service.dart';
import 'package:super_brain/features/auth/data/repositories/user_repository.dart';
import 'package:super_brain/features/auth/domain/entities/app_user.dart';

// Core providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(firebaseAuth: ref.watch(firebaseAuthProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

// Auth state provider
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(data: (user) => user, loading: () => null, error: (_, __) => null);
});

// App user provider (Firestore user data)
final appUserProvider = StreamProvider<AppUser?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();

  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.watchUser(user.uid);
});

// User profile provider
final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();

  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.watchUserProfile(user.uid);
});

// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});
