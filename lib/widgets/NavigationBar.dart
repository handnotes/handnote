import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store.dart';

enum Navigation { memo }

class NavigationBar extends StatefulWidget {
  final Navigation active;

  const NavigationBar(this.active, {Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Memo',
          icon: Icon(Icons.assignment),
        ),
      ],
      onTap: (index) {
        final tap = Navigation.values[index];
        if (tap == widget.active) return;
        Provider.of<AppData>(context, listen: false).navigateTo(tap);
      },
    );
  }
}
