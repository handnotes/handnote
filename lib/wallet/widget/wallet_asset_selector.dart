import 'package:flutter/material.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_add_screen.dart';
import 'package:handnote/wallet/widget/wallet_asset_item.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletAssetSelector extends HookConsumerWidget {
  const WalletAssetSelector({
    Key? key,
    required this.asset,
    required this.onSelected,
  }) : super(key: key);

  final WalletAsset? asset;
  final void Function(WalletAsset?) onSelected;

  @override
  Widget build(BuildContext context, ref) {
    final assets = ref.watch(walletAssetProvider);

    return WalletAssetItem(
      asset,
      dense: true,
      onTap: () => _buildAssetSelector(context, assets, asset),
    );
  }

  Future<dynamic> _buildAssetSelector(BuildContext context, List<WalletAsset> assets, WalletAsset? previous) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final theme = Theme.of(context);
        final noAssetIcon = RoundIcon(Icon(Icons.account_balance_wallet, color: theme.disabledColor));
        return Container(
          padding: const EdgeInsets.all(8.0),
          height: 500,
          child: ListView.separated(
            itemCount: assets.length + 2,
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
              } else if (index == assets.length + 1) {
                return ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('添加账户'),
                  onTap: () async {
                    final asset = await Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const WalletAssetAddScreen(),
                    ));
                    assert(asset is WalletAsset);
                    onSelected(asset);
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
