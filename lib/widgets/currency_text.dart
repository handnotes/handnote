import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/formatter.dart';

class CurrencyText extends HookWidget {
  const CurrencyText(
    this.amount, {
    Key? key,
    this.fontSize = 16,
    this.color = Colors.white,
  }) : super(key: key);

  final double amount;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final amountString = currencyYuanFormatter.format(amount);

    return Text(amountString,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'monospace',
          fontFamilyFallback: ['Courier'],
        ));
  }
}
