import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
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
            child: const Text('账户', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 8),
          Column(children: [
            for (var asset in assets) WalletAssetItem(asset, maskBalance: maskAmount),
          ]),
        ],
      ),
    );
  }
}
