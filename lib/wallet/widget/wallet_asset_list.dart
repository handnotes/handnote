import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_detail_screen.dart';
import 'package:handnote/wallet/widget/wallet_asset_item.dart';

class WalletAssetList extends HookWidget {
  const WalletAssetList(
    this.assets, {
    Key? key,
    this.inHomePage = false,
    this.maskAmount = false,
  }) : super(key: key);

  final List<WalletAsset> assets;
  final bool inHomePage;
  final bool maskAmount;

  @override
  Widget build(BuildContext context) {
    List<WalletAsset> assets = this.assets;
    final theme = Theme.of(context);

    if (inHomePage) {
      assets = this.assets.where((asset) => asset.showInHomePage).toList();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.topLeft,
            child: Text('资产账户', style: Theme.of(context).textTheme.titleMedium),
          ),
          const SizedBox(height: 8),
          Column(children: [
            for (var asset in assets)
              WalletAssetItem(
                asset,
                allowEdit: true,
                trailingBuilder: () => Text(
                  maskAmount ? '****' : asset.balance.toString(),
                  style: theme.textTheme.subtitle1,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WalletAssetDetailScreen(asset),
                  ));
                },
              ),
          ]),
        ],
      ),
    );
  }
}
