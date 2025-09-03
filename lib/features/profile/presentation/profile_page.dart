import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [_ProfileHeader(), const SizedBox(height: 24), _StatsSection(), const SizedBox(height: 24), _SettingsSection()]),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                'JD',
                style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Text('John Doe', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('john.doe@example.com', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                // TODO: Edit profile
              },
              icon: const Icon(Icons.edit),
              label: const Text('Modifier le profil'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistiques', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(icon: Icons.local_fire_department, value: '7', label: 'Jours consécutifs', color: Colors.orange),
                _StatItem(icon: Icons.psychology_outlined, value: '127', label: 'Mots mémorisés', color: Colors.blue),
                _StatItem(icon: Icons.timer_outlined, value: '45', label: 'Minutes totales', color: Colors.green),
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

class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Paramètres', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _SettingItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Gérer les rappels',
              onTap: () {
                // TODO: Open notifications settings
              },
            ),
            _SettingItem(
              icon: Icons.schedule_outlined,
              title: 'Routine matinale',
              subtitle: 'Configurer l\'heure',
              onTap: () {
                // TODO: Open routine settings
              },
            ),
            _SettingItem(
              icon: Icons.language_outlined,
              title: 'Langue',
              subtitle: 'Français',
              onTap: () {
                // TODO: Open language settings
              },
            ),
            _SettingItem(
              icon: Icons.dark_mode_outlined,
              title: 'Thème',
              subtitle: 'Automatique',
              onTap: () {
                // TODO: Open theme settings
              },
            ),
            const Divider(),
            _SettingItem(
              icon: Icons.help_outline,
              title: 'Aide et support',
              subtitle: 'FAQ et contact',
              onTap: () {
                // TODO: Open help
              },
            ),
            _SettingItem(
              icon: Icons.logout,
              title: 'Déconnexion',
              subtitle: 'Se déconnecter du compte',
              textColor: Colors.red,
              onTap: () {
                // TODO: Logout
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
