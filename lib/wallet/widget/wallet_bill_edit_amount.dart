import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/widget/wallet_asset_selector.dart';

class WalletBillEditAmount extends HookWidget {
  const WalletBillEditAmount({
    Key? key,
    required this.billType,
    required this.asset,
    required this.assets,
    required this.onSelected,
    required this.amountController,
  }) : super(key: key);

  final WalletBillType billType;
  final WalletAsset? asset;
  final List<WalletAsset> assets;
  final Function(WalletAsset? asset) onSelected;

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 160,
              height: double.infinity,
              child: WalletAssetSelector(
                asset: asset,
                onSelected: onSelected,
              ),
            ),
            const VerticalDivider(thickness: 2, width: 32),
            Expanded(
              child: TextFormField(
                controller: amountController,
                style: TextStyle(
                  fontSize: theme.textTheme.headline4?.fontSize,
                  color: billType == WalletBillType.outcome ? errorColor : successColor,
                  fontFamily: fontMonospace,
                ),
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: TextStyle(fontSize: theme.textTheme.headline4?.fontSize, fontFamily: fontMonospace),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  counterText: '',
                ),
                textAlign: TextAlign.right,
                maxLength: 10,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
