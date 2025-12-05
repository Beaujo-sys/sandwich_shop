import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';

void main() {
  group('ProfileScreen widget tests', () {
    testWidgets('renders form fields and save button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

      expect(find.byKey(const Key('nameField')), findsOneWidget);
      expect(find.byKey(const Key('emailField')), findsOneWidget);
      expect(find.byKey(const Key('saveButton')), findsOneWidget);
    });

    testWidgets('shows validation errors for empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pump();

      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('shows email validation error for invalid email', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

      await tester.enterText(find.byKey(const Key('nameField')), 'Alice');
      await tester.enterText(find.byKey(const Key('emailField')), 'invalid-email');
      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pump();

      expect(find.text('Enter a valid email'), findsOneWidget);
    });

    testWidgets('saves and displays profile summary', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

      await tester.enterText(find.byKey(const Key('nameField')), 'Alice');
      await tester.enterText(find.byKey(const Key('emailField')), 'alice@example.com');

      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pump();

      expect(find.text('Name: Alice'), findsOneWidget);
      expect(find.text('Email: alice@example.com'), findsOneWidget);
      expect(find.text('Profile saved'), findsOneWidget); // SnackBar
    });
  });
}
