import 'dart:io';

import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final double padding = Platform.isMacOS ? 24 : 0;
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(top: padding),
      color: color ?? theme.colorScheme.primaryContainer,
      child: child,
    );
  }
}
