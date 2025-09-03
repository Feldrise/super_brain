import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_brain/features/auth/presentation/controllers/auth_controller.dart';
import 'package:super_brain/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:super_brain/features/auth/presentation/widgets/social_sign_in_buttons.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error!), backgroundColor: Theme.of(context).colorScheme.error));
        authController.clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),

                Text(
                  'Join SuperBrain',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'Start your journey to better memory and cognitive health.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Name field
                AuthTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Email field
                AuthTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password field
                AuthTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Confirm password field
                AuthTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _register(),
                ),

                const SizedBox(height: 16),

                // Terms and conditions checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary, decoration: TextDecoration.underline),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Register button
                FilledButton(
                  onPressed: (authState.isLoading || !_agreeToTerms) ? null : _register,
                  child: authState.isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Create Account'),
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('or continue with', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // Social sign in buttons
                SocialSignInButtons(
                  isLoading: authState.isLoading,
                  onGoogleSignIn: () async {
                    final success = await authController.signInWithGoogle();
                    if (success && mounted) {
                      context.go('/home');
                    }
                  },
                  onAppleSignIn: () async {
                    final success = await authController.signInWithApple();
                    if (success && mounted) {
                      context.go('/home');
                    }
                  },
                ),

                const SizedBox(height: 32),

                // Sign in link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ', style: Theme.of(context).textTheme.bodyMedium),
                    TextButton(onPressed: () => context.pop(), child: const Text('Sign In')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please agree to the Terms of Service and Privacy Policy')));
      return;
    }

    final authController = ref.read(authControllerProvider.notifier);
    final success = await authController.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      displayName: _nameController.text.trim(),
    );

    if (success && mounted) {
      context.go('/home');
    }
  }
}
