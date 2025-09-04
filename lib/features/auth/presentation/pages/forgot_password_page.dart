import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:super_brain/features/auth/presentation/controllers/auth_controller.dart';
import 'package:super_brain/features/auth/presentation/widgets/auth_text_field.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
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
      appBar: AppBar(title: const Text('Réinitialiser le mot de passe'), backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(24.0), child: _emailSent ? _buildSuccessView() : _buildFormView(authState)),
      ),
    );
  }

  Widget _buildFormView(AuthState authState) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 60),

          Icon(Icons.lock_outline, size: 80, color: Theme.of(context).colorScheme.primary),

          const SizedBox(height: 32),

          Text(
            'Mot de passe oublié ?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Text(
            'Ne vous inquiétez pas ! Saisissez votre adresse email et nous vous enverrons un lien pour réinitialiser votre mot de passe.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Email field
          AuthTextField(
            controller: _emailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Veuillez saisir un email valide';
              }
              return null;
            },
            onFieldSubmitted: (_) => _sendResetEmail(),
          ),

          const SizedBox(height: 32),

          // Send reset email button
          FilledButton(
            onPressed: authState.isLoading ? null : _sendResetEmail,
            child: authState.isLoading
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Envoyer le lien de réinitialisation'),
          ),

          const SizedBox(height: 24),

          // Back to login
          TextButton(onPressed: () => context.pop(), child: const Text('Retour à la connexion')),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),

        Icon(Icons.mark_email_read_outlined, size: 80, color: Theme.of(context).colorScheme.primary),

        const SizedBox(height: 32),

        Text(
          'Vérifiez votre Email',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        Text(
          'Nous avons envoyé un lien de réinitialisation de mot de passe à ${_emailController.text}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          'Veuillez vérifier votre email et suivre les instructions pour réinitialiser votre mot de passe.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        OutlinedButton(
          onPressed: () {
            setState(() {
              _emailSent = false;
            });
          },
          child: const Text('Envoyer à nouveau'),
        ),

        const SizedBox(height: 16),

        FilledButton(onPressed: () => context.go('/auth/login'), child: const Text('Retour à la connexion')),
      ],
    );
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    final authController = ref.read(authControllerProvider.notifier);
    final success = await authController.sendPasswordResetEmail(_emailController.text.trim());

    if (success) {
      setState(() {
        _emailSent = true;
      });
    }
  }
}
