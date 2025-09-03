import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_brain/core/providers/auth_providers.dart';
import 'package:super_brain/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:super_brain/features/profile/presentation/controllers/profile_controller.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProfile = ref.read(userProfileProvider);
      userProfile.whenData((profile) {
        if (profile != null) {
          _displayNameController.text = profile.displayName ?? '';
          _bioController.text = profile.bio ?? '';
          _locationController.text = profile.location ?? '';
        }
      });
    });
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final userProfileAsync = ref.watch(userProfileProvider);

    ref.listen(profileControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error!), backgroundColor: Theme.of(context).colorScheme.error));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: profileState.isUpdating ? null : _saveProfile,
            child: profileState.isUpdating ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save'),
          ),
        ],
      ),
      body: userProfileAsync.when(
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile picture section
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: profile?.photoURL != null ? NetworkImage(profile!.photoURL!) : null,
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: profile?.photoURL == null
                            ? Text(
                                profile?.displayName?.isNotEmpty == true ? profile!.displayName![0].toUpperCase() : 'U',
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: () {
                              // TODO: Implement photo picker
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Photo picker coming soon!')));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Display name
                AuthTextField(
                  controller: _displayNameController,
                  labelText: 'Display Name',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a display name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Bio
                AuthTextField(
                  controller: _bioController,
                  labelText: 'Bio',
                  hintText: 'Tell us about yourself...',
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),

                const SizedBox(height: 16),

                // Location
                AuthTextField(controller: _locationController, labelText: 'Location', hintText: 'Where are you located?', textInputAction: TextInputAction.done),

                const SizedBox(height: 32),

                // Email (read-only)
                AuthTextField(
                  controller: TextEditingController(text: profile?.email ?? ''),
                  labelText: 'Email',
                  enabled: false,
                ),

                const SizedBox(height: 8),

                Text(
                  'To change your email, go to Account & Security settings.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text('Error loading profile: $error'),
              const SizedBox(height: 16),
              FilledButton(onPressed: () => ref.invalidate(userProfileProvider), child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final profileController = ref.read(profileControllerProvider.notifier);
    final userProfile = ref.read(userProfileProvider).valueOrNull;

    if (userProfile == null) return;

    final updatedProfile = userProfile.copyWith(
      displayName: _displayNameController.text.trim(),
      bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
      location: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
    );

    final success = await profileController.updateUserProfile(updatedProfile);

    if (success && mounted) {
      // Also update the display name in Firebase Auth and AppUser
      await profileController.updateProfile(displayName: _displayNameController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!')));
      Navigator.of(context).pop();
    }
  }
}
