import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_brain/core/providers/auth_providers.dart';

class AuthWrapper extends ConsumerWidget {
  final Widget child;

  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final location = GoRouterState.of(context).uri.path;

    return authState.when(
      data: (user) {
        // If user is not authenticated and trying to access protected routes
        if (user == null && !_isPublicRoute(location)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/auth/login');
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // If user is authenticated and trying to access auth routes
        if (user != null && _isAuthRoute(location)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return child;
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text('Authentication Error: $error'),
              const SizedBox(height: 16),
              FilledButton(onPressed: () => ref.invalidate(authStateProvider), child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }

  bool _isPublicRoute(String location) {
    return location.startsWith('/auth/');
  }

  bool _isAuthRoute(String location) {
    return location.startsWith('/auth/');
  }
}
