import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/utils/formatter.dart';

class CurrencyText extends HookWidget {
  const CurrencyText(
    this.amount, {
    Key? key,
    TextStyle? style,
    this.mask = false,
    this.monoFont = true,
  })  : style = style ?? const TextStyle(),
        super(key: key);

  final double amount;
  final bool mask;
  final TextStyle style;
  final bool monoFont;

  @override
  Widget build(BuildContext context) {
    final amountString = mask ? '****' : currencyYuanFormatter.format(amount);
    return Text(
      amountString,
      style: style.copyWith(
        fontFamily: monoFont ? fontMonospace : null,
      ),
    );
  }
}
