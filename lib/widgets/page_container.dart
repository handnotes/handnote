import 'dart:io';

import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double padding = Platform.isMacOS ? 24 : 0;

    return Builder(
      builder: (context) => Container(
        padding: EdgeInsets.only(top: padding),
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary,
        child: child,
      ),
    );
  }
}
