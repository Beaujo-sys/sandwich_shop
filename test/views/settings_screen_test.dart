import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sandwich_shop/views/settings_screen.dart';
import 'package:sandwich_shop/views/app_styles.dart';

void main() {
	group('SettingsScreen', () {
		setUp(() async {
			SharedPreferences.setMockInitialValues(<String, Object>{});
			// Ensure base font resets to default for each test run
			await AppStyles.loadFontSize();
		});

		testWidgets('loads with default font size and shows UI', (WidgetTester tester) async {
			await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

			// Initial state shows loading indicator, then settles to UI
			expect(find.byType(CircularProgressIndicator), findsOneWidget);
			await tester.pumpAndSettle();

			expect(find.text('Settings'), findsOneWidget);
			expect(find.text('Font Size'), findsOneWidget);

			// Default from AppStyles is 16px
			expect(find.text('Current size: 16px'), findsOneWidget);

			// Sample preview text should exist
			expect(
				find.text('This is sample text to preview the font size.'),
				findsOneWidget,
			);
		});

		testWidgets('changing slider saves and updates font size', (WidgetTester tester) async {
			await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
			await tester.pumpAndSettle();

			// Get slider and change value to 20
			final Slider slider = tester.widget<Slider>(find.byType(Slider));
			slider.onChanged?.call(20.0);
			await tester.pumpAndSettle();

			// UI reflects new size
			expect(find.text('Current size: 20px'), findsOneWidget);

			// AppStyles should also reflect saved size
			expect(AppStyles.baseFontSize, equals(20.0));
		});

		testWidgets('font size persists across app restarts', (WidgetTester tester) async {
			await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
			await tester.pumpAndSettle();

			// Change to 24
			final Slider slider = tester.widget<Slider>(find.byType(Slider));
			slider.onChanged?.call(24.0);
			await tester.pumpAndSettle();
			expect(find.text('Current size: 24px'), findsOneWidget);

			// Simulate app restart by rebuilding a new SettingsScreen
			await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
			await tester.pumpAndSettle();

			// New instance should read persisted value
			expect(find.text('Current size: 24px'), findsOneWidget);
			expect(AppStyles.baseFontSize, equals(24.0));

			// Back button works
			expect(find.text('Back to Order'), findsOneWidget);
			await tester.tap(find.text('Back to Order'));
			await tester.pumpAndSettle();
			// After pop, the Navigator stack may be empty; ensure no crash and test completes
		});
	});
}

