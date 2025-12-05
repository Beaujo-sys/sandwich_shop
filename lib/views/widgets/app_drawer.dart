import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/cart_scope.dart';
import 'package:sandwich_shop/views/cart_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Sandwich Shop'),
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Order'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.pop(context);
              final cart = CartScope.of(context).cart;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(cart: cart),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}
