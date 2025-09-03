import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child, bottomNavigationBar: _BottomNavigationBar());
  }
}

class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).fullPath;

    return NavigationBar(
      selectedIndex: _calculateSelectedIndex(currentLocation),
      onDestinationSelected: (index) => _onItemTapped(index, context),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Accueil'),
        NavigationDestination(icon: Icon(Icons.psychology_outlined), selectedIcon: Icon(Icons.psychology), label: 'Mémoire'),
        NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), selectedIcon: Icon(Icons.wb_sunny), label: 'Routine'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }

  int _calculateSelectedIndex(String? location) {
    if (location == null) return 0;

    if (location.startsWith('/home') || location == '/') return 0;
    if (location.startsWith('/reminder')) return 1;
    if (location.startsWith('/morning')) return 2;
    if (location.startsWith('/profile')) return 3;

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/reminder');
        break;
      case 2:
        context.go('/morning');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
