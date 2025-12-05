import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/views/about_screen.dart';

void main() {
  group('Navigation drawer and responsive navigation', () {
    testWidgets('Drawer exists on narrow screens and opens', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800, 1280);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(MaterialApp(
        home: const OrderScreen(),
        routes: {
          '/about': (context) => const AboutScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ));

      // Open the drawer via AppBar hamburger
      ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);

      // Tap Profile entry
      // Target the Drawer ListTile with text 'Profile' to avoid ambiguity
      await tester.tap(find.widgetWithText(ListTile, 'Profile'));
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);

      // Cleanup overrides
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });
    });

    testWidgets('Shows NavigationRail on wide screens', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1400, 900);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(MaterialApp(
        home: const OrderScreen(),
        routes: {
          '/about': (context) => const AboutScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ));
      await tester.pumpAndSettle();

      expect(find.byType(NavigationRail), findsOneWidget);

      // Tap About destination (index 1)
      final NavigationRail rail = tester.widget(find.byType(NavigationRail));
      expect(rail.destinations.length, greaterThanOrEqualTo(3));

      // Simulate destination selection
      // We can't directly tap destinations easily, so find text label
      // Tap NavigationRail destination by its label
      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();

      expect(find.byType(AboutScreen), findsOneWidget);

      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });
    });
  });
}
