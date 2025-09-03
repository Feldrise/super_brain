import 'package:super_brain/theme/screen_helper.dart';
import 'package:flutter/material.dart';

class FormLayout extends StatelessWidget {
  const FormLayout({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 984),
        child: Padding(
          padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final child in children) ...[child],
            ],
          ),
        ),
      ),
    );
  }
}
