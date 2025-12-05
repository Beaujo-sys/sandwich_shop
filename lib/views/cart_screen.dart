import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  String _getSizeText(bool isFootlong) {
    if (isFootlong) {
      return 'Footlong';
    } else {
      return 'Six-inch';
    }
  }

  double _getItemPrice(Sandwich sandwich, int quantity) {
    final PricingRepository pricingRepository = PricingRepository();
    return pricingRepository.calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  Future<void> _navigateToCheckout() async {
    if (widget.cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(cart: widget.cart),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        widget.cart.clear();
      });

      final String orderId = result['orderId'] as String;
      final String estimatedTime = result['estimatedTime'] as String;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Order $orderId confirmed! Estimated time: $estimatedTime'),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: const Text(
          'Cart View',
          style: heading1,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              if (widget.cart.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: const [
                      Text('Your cart is empty.', style: heading2, textAlign: TextAlign.center),
                      SizedBox(height: 8),
                      Text('Add sandwiches from the order screen to begin.', style: normalText, textAlign: TextAlign.center),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              for (MapEntry<Sandwich, int> entry in widget.cart.items.entries)
                Column(
                  children: [
                    Text(entry.key.name, style: heading2),
                    Text(
                      '${_getSizeText(entry.key.isFootlong)} on ${entry.key.breadType.name} bread',
                      style: normalText,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              widget.cart.remove(entry.key, quantity: 1);
                            });
                            final qty = widget.cart.getQuantity(entry.key);
                            final removedCompletely = qty == 0;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  removedCompletely
                                      ? 'Removed ${entry.key.name} from cart'
                                      : 'Decreased ${entry.key.name} quantity to $qty',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                        Text(
                          'Qty: ${widget.cart.getQuantity(entry.key)}',
                          style: normalText,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setState(() {
                              widget.cart.add(entry.key, quantity: 1);
                            });
                            final qty = widget.cart.getQuantity(entry.key);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Increased ${entry.key.name} quantity to $qty'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            setState(() {
                              final qty = widget.cart.getQuantity(entry.key);
                              if (qty > 0) {
                                widget.cart.remove(entry.key, quantity: qty);
                              }
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Removed ${entry.key.name} from cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(
                      '£${_getItemPrice(entry.key, widget.cart.getQuantity(entry.key)).toStringAsFixed(2)}',
                      style: normalText,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Text(
                'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                style: heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              StyledButton(
                onPressed: _goBack,
                icon: Icons.arrow_back,
                label: 'Back to Order',
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
