// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
// Removed unused order_screen import
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/styled_button.dart';

void main() {
  group('CartScreen', () {
    testWidgets('displays empty cart message when cart is empty',
        (WidgetTester tester) async {
      final Cart emptyCart = Cart();
      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => emptyCart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      expect(find.text('Cart View'), findsOneWidget);
      // Cart indicator in AppBar
      final Finder appBarFinder = find.byType(AppBar);
      expect(
        find.descendant(of: appBarFinder, matching: find.byIcon(Icons.shopping_cart)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: appBarFinder, matching: find.text('0')),
        findsOneWidget,
      );
      expect(find.text('Your cart is empty.'), findsOneWidget);
      expect(find.text('Total: £0.00'), findsOneWidget);
    });

    testWidgets('displays cart items when cart has items',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => cart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      expect(find.text('Cart View'), findsOneWidget);
      // Cart indicator should reflect item count
      final Finder appBarFinder2 = find.byType(AppBar);
      expect(
        find.descendant(of: appBarFinder2, matching: find.byIcon(Icons.shopping_cart)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: appBarFinder2, matching: find.text('2')),
        findsOneWidget,
      );
      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Footlong on white bread'), findsOneWidget);
      expect(find.text('Qty: 2'), findsOneWidget);
      expect(find.text('£22.00'), findsOneWidget);
      expect(find.text('Total: £22.00'), findsOneWidget);
    });

    testWidgets('displays multiple cart items correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final Sandwich sandwich2 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      cart.add(sandwich1, quantity: 1);
      cart.add(sandwich2, quantity: 3);

      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => cart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      // Cart indicator shows combined quantity
      final Finder appBarFinder3 = find.byType(AppBar);
      expect(
        find.descendant(of: appBarFinder3, matching: find.byIcon(Icons.shopping_cart)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: appBarFinder3, matching: find.text('4')),
        findsOneWidget,
      );
      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Chicken Teriyaki'), findsOneWidget);
      expect(find.text('Footlong on white bread'), findsOneWidget);
      expect(find.text('Six-inch on wheat bread'), findsOneWidget);
      expect(find.text('Qty: 1'), findsOneWidget);
      expect(find.text('Qty: 3'), findsOneWidget);
      expect(find.text('Total: £32.00'), findsOneWidget);
    });

    testWidgets('shows checkout button when cart has items',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => cart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      expect(find.widgetWithText(StyledButton, 'Checkout'), findsOneWidget);
    });

    testWidgets('hides checkout button when cart is empty',
        (WidgetTester tester) async {
      final Cart emptyCart = Cart();
      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => emptyCart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      expect(find.widgetWithText(StyledButton, 'Checkout'), findsNothing);
    });

    testWidgets('increment quantity button works correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => cart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      expect(find.text('Qty: 1'), findsOneWidget);

      final Finder addButtonFinder = find.byIcon(Icons.add);
      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Qty: 2'), findsOneWidget);
      expect(find.text('Quantity increased'), findsOneWidget);
    });

    testWidgets('decrement quantity button works correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => cart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      expect(find.text('Qty: 2'), findsOneWidget);

      final Finder removeButtonFinder = find.byIcon(Icons.remove);
      await tester.tap(removeButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Qty: 1'), findsOneWidget);
      expect(find.text('Quantity decreased'), findsOneWidget);
    });

    testWidgets('remove item button works correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => cart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      expect(find.text('Veggie Delight'), findsOneWidget);

      final Finder deleteButtonFinder = find.byIcon(Icons.delete);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Veggie Delight'), findsNothing);
      expect(find.text('Your cart is empty.'), findsOneWidget);
      expect(find.text('Item removed from cart'), findsOneWidget);
    });

    testWidgets('back button navigates back', (WidgetTester tester) async {
      final Cart cart = Cart();
      final CartScreen cartViewScreen = const CartScreen();
      final Widget app = ChangeNotifierProvider<Cart>(
        create: (_) => cart,
        child: MaterialApp(home: cartViewScreen),
      );

      await tester.pumpWidget(app);

      final Finder backButtonFinder =
          find.widgetWithText(StyledButton, 'Back to Order');
      expect(backButtonFinder, findsOneWidget);

      final StyledButton backButton =
          tester.widget<StyledButton>(backButtonFinder);
      expect(backButton.onPressed, isNotNull);
    });
  });
}
