import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_brain/core/widgets/unsaved_changes_dialog.dart';

void main() {
  group('UnsavedChangesDialog Tests', () {
    testWidgets('should display correct title and content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  UnsavedChangesDialog.show(context, title: 'Test Title', content: 'Test Content');
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog elements
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.text('Annuler'), findsOneWidget);
      expect(find.text('Sauvegarder'), findsOneWidget);
      expect(find.text('Abandonner'), findsOneWidget);
    });

    testWidgets('should call onSave when save button is pressed', (WidgetTester tester) async {
      bool saveCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  UnsavedChangesDialog.show(
                    context,
                    title: 'Test Title',
                    content: 'Test Content',
                    onSave: () {
                      saveCalled = true;
                    },
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Tap save button
      await tester.tap(find.text('Sauvegarder'));
      await tester.pumpAndSettle();

      expect(saveCalled, isTrue);
    });

    testWidgets('should call onDiscard when discard button is pressed', (WidgetTester tester) async {
      bool discardCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  UnsavedChangesDialog.show(
                    context,
                    title: 'Test Title',
                    content: 'Test Content',
                    onDiscard: () {
                      discardCalled = true;
                    },
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Tap discard button
      await tester.tap(find.text('Abandonner'));
      await tester.pumpAndSettle();

      expect(discardCalled, isTrue);
    });

    testWidgets('should dismiss dialog when cancel button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  UnsavedChangesDialog.show(context, title: 'Test Title', content: 'Test Content');
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.text('Test Title'), findsOneWidget);

      // Tap cancel button
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.text('Test Title'), findsNothing);
    });
  });
}
