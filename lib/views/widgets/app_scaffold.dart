import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/widgets/app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const AppScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useRail = constraints.maxWidth >= 900;

        Widget content = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (useRail)
              NavigationRail(
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.store),
                    label: Text('Order'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.info_outline),
                    label: Text('About'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
                selectedIndex: 0,
                onDestinationSelected: (index) {
                  switch (index) {
                    case 0:
                      Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
                      break;
                    case 1:
                      Navigator.pushNamed(context, '/about');
                      break;
                    case 2:
                      Navigator.pushNamed(context, '/profile');
                      break;
                  }
                },
              ),
            Expanded(child: body),
          ],
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: const [],
          ),
          drawer: useRail ? null : const AppDrawer(),
          body: content,
        );
      },
    );
  }
}
