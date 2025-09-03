import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_brain/features/auth/presentation/controllers/auth_controller.dart';
import 'package:super_brain/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:super_brain/features/auth/presentation/widgets/social_sign_in_buttons.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),

                // Logo/Title
                Text(
                  'SuperBrain',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'Welcome back! Sign in to continue your journey.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

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
                  textInputAction: TextInputAction.done,
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
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _signIn(),
                ),

                const SizedBox(height: 8),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () => context.push('/auth/forgot-password'), child: const Text('Forgot Password?')),
                ),

                const SizedBox(height: 24),

                // Sign in button
                FilledButton(
                  onPressed: authState.isLoading ? null : _signIn,
                  child: authState.isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Sign In'),
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

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: Theme.of(context).textTheme.bodyMedium),
                    TextButton(onPressed: () => context.push('/auth/register'), child: const Text('Sign Up')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    final authController = ref.read(authControllerProvider.notifier);
    final success = await authController.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text);

    if (success && mounted) {
      context.go('/home');
    }
  }
}
