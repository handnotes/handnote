import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/enum/wallet_asset_type.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/widgets/currency_text.dart';

class WalletAssetItem extends HookWidget {
  final WalletAsset asset;
  final bool maskBalance;

  const WalletAssetItem(this.asset, {Key? key, this.maskBalance = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subTitle = asset.remark;

    var icon = walletAssetTypeIcon(asset.type);
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Container(
        height: 72,
        alignment: Alignment.center,
        child: ListTile(
          leading: Icon(icon.first, color: icon.second),
          title: Text(asset.name, style: const TextStyle(fontSize: 16)),
          subtitle: subTitle.isNotEmpty ? Text(subTitle, style: const TextStyle(fontSize: 14)) : null,
          trailing: maskBalance ? null : CurrencyText(asset.balance, color: Colors.black, monoFont: false),
        ),
      ),
    );
  }
}
