import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/core/widgets/app_shell.dart';
import 'package:super_brain/features/auth/presentation/pages/login_page.dart';
import 'package:super_brain/features/auth/presentation/pages/register_page.dart';
import 'package:super_brain/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:super_brain/features/home/presentation/home_page.dart';
import 'package:super_brain/features/reminder/presentation/reminder_page.dart';
import 'package:super_brain/features/morning/presentation/morning_page.dart';
import 'package:super_brain/features/profile/presentation/profile_page.dart';

CustomTransitionPage<dynamic> _buildPageWithDefaultTransition<T>({required BuildContext context, required GoRouterState state, required Widget child}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

// Global router provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isAuthenticated = authState.valueOrNull != null;
      final isAuthRoute = state.uri.path.startsWith('/auth');

      // If not authenticated and not on auth route, redirect to login
      if (!isAuthenticated && !isAuthRoute) {
        return '/auth/login';
      }

      // If authenticated and on auth route, redirect to home
      if (isAuthenticated && isAuthRoute) {
        return '/home';
      }

      return null; // No redirect needed
    },
    routes: [
      // Authentication routes (no shell)
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginPage(),
        pageBuilder: (context, state) => _buildPageWithDefaultTransition(context: context, state: state, child: const LoginPage()),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterPage(),
        pageBuilder: (context, state) => _buildPageWithDefaultTransition(context: context, state: state, child: const RegisterPage()),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
        pageBuilder: (context, state) => _buildPageWithDefaultTransition(context: context, state: state, child: const ForgotPasswordPage()),
      ),

      // Main app routes (with shell)
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: "/home",
            builder: (context, state) => const HomePage(),
            pageBuilder: (context, state) => _buildPageWithDefaultTransition(context: context, state: state, child: const HomePage()),
          ),
          GoRoute(
            path: "/reminder",
            builder: (context, state) => const ReminderPage(),
            pageBuilder: (context, state) => _buildPageWithDefaultTransition(context: context, state: state, child: const ReminderPage()),
          ),
          GoRoute(
            path: "/morning",
            builder: (context, state) => const MorningPage(),
            pageBuilder: (context, state) => _buildPageWithDefaultTransition(context: context, state: state, child: const MorningPage()),
          ),
          GoRoute(
            path: "/profile",
            builder: (context, state) => const ProfilePage(),
            pageBuilder: (context, state) => _buildPageWithDefaultTransition(context: context, state: state, child: const ProfilePage()),
          ),
          // Redirect root to home
          GoRoute(path: "/", redirect: (context, state) => "/home"),
        ],
      ),
    ],
  );
});

// For backward compatibility
GoRouter router() => throw UnimplementedError('Use routerProvider instead. Access it via ref.watch(routerProvider)');
