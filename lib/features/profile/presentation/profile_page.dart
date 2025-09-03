import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/auth/presentation/controllers/auth_controller.dart';
import 'package:super_brain/features/profile/presentation/pages/edit_profile_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final currentUser = ref.watch(currentUserProvider);
    final appUserAsync = ref.watch(appUserProvider);
    final userProfileAsync = ref.watch(userProfileProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Please sign in to view your profile'),
                  const SizedBox(height: 16),
                  FilledButton(onPressed: () => context.go('/auth/login'), child: const Text('Sign In')),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Profile'), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _ProfileHeader(user: currentUser, appUserAsync: appUserAsync, userProfileAsync: userProfileAsync),
                const SizedBox(height: 24),
                _StatsSection(appUserAsync: appUserAsync),
                const SizedBox(height: 24),
                _SettingsSection(),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              FilledButton(onPressed: () => ref.invalidate(authStateProvider), child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends ConsumerWidget {
  final dynamic user;
  final AsyncValue appUserAsync;
  final AsyncValue userProfileAsync;

  const _ProfileHeader({required this.user, required this.appUserAsync, required this.userProfileAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Get display name from user profile, app user, or Firebase Auth user
    String displayName = 'User';
    String email = user?.email ?? '';
    String? photoURL;

    userProfileAsync.whenData((profile) {
      if (profile?.displayName != null) {
        displayName = profile!.displayName!;
      }
      photoURL = profile?.photoURL;
    });

    if (displayName == 'User') {
      appUserAsync.whenData((appUser) {
        if (appUser?.displayName != null) {
          displayName = appUser!.displayName!;
        }
        photoURL ??= appUser?.photoURL;
      });
    }
    if (displayName == 'User' && user?.displayName != null) {
      displayName = user!.displayName!;
    }

    if (photoURL == null) {
      photoURL = user?.photoURL;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: photoURL != null ? NetworkImage(photoURL!) : null,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: photoURL == null
                  ? Text(
                      displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U',
                      style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(displayName, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(email, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsSection extends ConsumerWidget {
  final AsyncValue appUserAsync;

  const _StatsSection({required this.appUserAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    int streakCount = 0;
    appUserAsync.whenData((appUser) {
      if (appUser != null) {
        streakCount = appUser.streakCount;
      }
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistics', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(icon: Icons.local_fire_department, value: streakCount.toString(), label: 'Day Streak', color: Colors.orange),
                _StatItem(
                  icon: Icons.psychology_outlined,
                  value: '0', // TODO: Get from word lists
                  label: 'Words Learned',
                  color: Colors.blue,
                ),
                _StatItem(
                  icon: Icons.timer_outlined,
                  value: '0', // TODO: Get from sessions
                  label: 'Total Minutes',
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.value, required this.label, required this.color});

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SettingsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _SettingItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Manage reminders',
              onTap: () {
                // TODO: Open notifications settings
              },
            ),
            _SettingItem(
              icon: Icons.schedule_outlined,
              title: 'Morning Routine',
              subtitle: 'Set your schedule',
              onTap: () {
                // TODO: Open routine settings
              },
            ),
            _SettingItem(
              icon: Icons.language_outlined,
              title: 'Language',
              subtitle: 'English',
              onTap: () {
                // TODO: Open language settings
              },
            ),
            _SettingItem(
              icon: Icons.dark_mode_outlined,
              title: 'Theme',
              subtitle: 'Automatic',
              onTap: () {
                // TODO: Open theme settings
              },
            ),
            _SettingItem(
              icon: Icons.security_outlined,
              title: 'Account & Security',
              subtitle: 'Password, email settings',
              onTap: () {
                // TODO: Navigate to account security page
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account settings coming soon!')));
              },
            ),
            const Divider(),
            _SettingItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'FAQ and contact',
              onTap: () {
                // TODO: Open help
              },
            ),
            _SettingItem(
              icon: Icons.logout,
              title: 'Sign Out',
              subtitle: 'Sign out of your account',
              textColor: Colors.red,
              onTap: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Sign Out'),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                      FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sign Out')),
                    ],
                  ),
                );

                if (confirmed == true) {
                  final authController = ref.read(authControllerProvider.notifier);
                  await authController.signOut();
                  if (context.mounted) {
                    context.go('/auth/login');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({required this.icon, required this.title, required this.subtitle, required this.onTap, this.textColor});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = textColor ?? theme.colorScheme.onSurface;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(color: color, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: textColor?.withOpacity(0.7) ?? theme.colorScheme.onSurfaceVariant)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurfaceVariant),
      onTap: onTap,
    );
  }
}
