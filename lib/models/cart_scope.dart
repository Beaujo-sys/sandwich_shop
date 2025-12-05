import 'package:flutter/widgets.dart';
import 'package:sandwich_shop/models/cart.dart';

class CartScope extends InheritedWidget {
  final Cart cart;

  const CartScope({super.key, required this.cart, required super.child});

  static CartScope of(BuildContext context) {
    final CartScope? scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope not found in widget tree');
    return scope!;
  }

  @override
  bool updateShouldNotify(CartScope oldWidget) => cart != oldWidget.cart;
}
