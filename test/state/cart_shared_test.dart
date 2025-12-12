import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/views/styled_button.dart';

void main() {
  testWidgets('Cart is shared across screens and updates when modified',
      (WidgetTester tester) async {
    // Pump the real app which wires up the Cart provider in main.dart
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Verify we're on the Order screen
    expect(find.text('Sandwich Counter'), findsOneWidget);

    // Add default sandwich to the cart (use StyledButton finder and ensure visible)
    final Finder addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
    expect(addToCartButton, findsOneWidget);
    await tester.ensureVisible(addToCartButton);
    await tester.pumpAndSettle();
    await tester.tap(addToCartButton);
    await tester.pumpAndSettle();

    // The order screen shows a summary that includes the cart count
    expect(find.textContaining('Cart: 1 items'), findsOneWidget);

    // Navigate to the Cart screen
    final Finder viewCartButton = find.text('View Cart');
    expect(viewCartButton, findsOneWidget);
    await tester.tap(viewCartButton);
    await tester.pumpAndSettle();

    // Cart screen should show the sandwich we added
    expect(find.text('Veggie Delight'), findsOneWidget);

    // And show a total label
    expect(find.textContaining('Total:'), findsOneWidget);
  });
}
