import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SocialSignInButtons extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAppleSignIn;

  const SocialSignInButtons({super.key, this.isLoading = false, this.onGoogleSignIn, this.onAppleSignIn});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google Sign In
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: isLoading ? null : onGoogleSignIn,
            icon: isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Image.asset(
                    'assets/images/google_logo.png',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.g_mobiledata, size: 20);
                    },
                  ),
            label: const Text('Continue with Google'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),

        // Show Apple Sign In only on iOS and macOS
        if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isLoading ? null : onAppleSignIn,
              icon: isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.apple, size: 20),
              label: const Text('Continue with Apple'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
