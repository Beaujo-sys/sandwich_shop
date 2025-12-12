import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/app_styles.dart';

class CartIndicator extends StatelessWidget {
  const CartIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shopping_cart),
            const SizedBox(width: 4),
            Text('${cart.countOfItems}')
          ],
        );
      },
    );
  }
}
//applies heading1 text style and includes logo and cart indicator
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppHeader({super.key, required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
      title: Text(title, style: heading1),
      actions: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CartIndicator(),
        ),
        if (actions != null) ...actions!,
      ],
    );
  }
}
//applies heading2 text style
class SectionTitle extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const SectionTitle(this.text, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: heading2, textAlign: textAlign);
  }
}
//applies small text style
class NormalLabel extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const NormalLabel(this.text, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: normalText, textAlign: textAlign);
  }
}
//spacer with customizable height and width
class SizedSpacer extends StatelessWidget {
  final double height;
  final double width;
  const SizedSpacer({super.key, this.height = 0, this.width = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
