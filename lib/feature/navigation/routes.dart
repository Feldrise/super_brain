import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_brain/core/widgets/app_shell.dart';
import 'package:super_brain/features/home/presentation/home_page.dart';
import 'package:super_brain/features/reminder/presentation/reminder_page.dart';
import 'package:super_brain/features/morning/presentation/morning_page.dart';
import 'package:super_brain/features/profile/presentation/profile_page.dart';

CustomTransitionPage<dynamic> _buildPageWithDefaultTransition<T>({required BuildContext context, required GoRouterState state, required Widget child}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // return ScaleTransition(
      //   scale: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      //   child: child,
      // );

      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

GoRouter router() => GoRouter(
  initialLocation: '/home',
  routes: [
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
