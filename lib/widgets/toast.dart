import 'package:flutter/material.dart';
import 'package:handnote/theme.dart';

class Toast {
  static error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: errorColor,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onError)),
    ));
  }
}
