import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/utils/extensions.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/widgets/currency_text.dart';
import 'package:handnote/widgets/round_icon.dart';

class WalletAssetItem extends HookWidget {
  final WalletAsset asset;
  final bool maskBalance;

  const WalletAssetItem(this.asset, {Key? key, this.maskBalance = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subTitle = asset.remark;

    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Container(
        height: 72,
        alignment: Alignment.center,
        child: ListTile(
          leading: SizedBox(child: RoundIcon(walletAssetTypeIconMap[asset.type]), height: double.infinity),
          title: Text(asset.name),
          subtitle: subTitle.isNotEmpty ? Text(subTitle) : null,
          trailing: maskBalance.let((_) => CurrencyText(asset.balance, monoFont: false)),
        ),
      ),
    );
  }
}
