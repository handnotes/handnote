import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/widget/wallet_asset_item.dart';
import 'package:handnote/widgets/round_icon.dart';

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
    final noAssetIcon = RoundIcon(Icon(Icons.account_balance_wallet, color: theme.disabledColor));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 160,
              height: double.infinity,
              child: WalletAssetItem(
                asset,
                dense: true,
                onTap: () => _chooseAsset(context, asset, noAssetIcon),
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

  Future<dynamic> _chooseAsset(BuildContext context, WalletAsset? previous, Widget? noAssetIcon) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          height: 500,
          child: ListView.separated(
            itemCount: assets.length + 1,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == assets.length) {
                return ListTile(
                  leading: noAssetIcon,
                  title: const Text('不选择账户'),
                  subtitle: const Text('将使用默认账户'),
                  onTap: () {
                    onSelected(null);
                    Navigator.pop(context);
                  },
                );
              } else {
                final element = assets[index];
                return WalletAssetItem(
                  element,
                  dense: true,
                  trailingBuilder: () => element.id == previous?.id ? const Icon(Icons.check) : null,
                  onTap: () {
                    onSelected(element);
                    Navigator.pop(context);
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
