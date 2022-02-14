import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/utils/formatter.dart';

class CurrencyText extends HookWidget {
  const CurrencyText(
    this.amount, {
    Key? key,
    this.mask = false,
    this.fontSize = 16,
    this.color = Colors.white,
    this.monoFont = true,
  }) : super(key: key);

  final double amount;
  final bool mask;
  final double fontSize;
  final Color color;
  final bool monoFont;

  @override
  Widget build(BuildContext context) {
    final amountString = mask ? '****' : currencyYuanFormatter.format(amount);

    return Text(amountString,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: monoFont ? fontMonospace : null,
        ));
  }
}
