import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../store.dart';

enum Navigation { memo }

class NavigationBar extends HookWidget {
  final Navigation active;

  const NavigationBar(this.active, {Key? key}) : super(key: key);

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
        if (tap == active) return;
        Provider.of<AppData>(context, listen: false).navigateTo(tap);
      },
    );
  }
}
