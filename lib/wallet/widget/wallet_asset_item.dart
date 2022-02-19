import 'package:flutter/material.dart';
import 'package:handnote/utils/extensions.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/widgets/currency_text.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletAssetItem extends HookConsumerWidget {
  final WalletAsset asset;
  final bool maskBalance;

  const WalletAssetItem(this.asset, {Key? key, this.maskBalance = false}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
          onLongPress: () => _showAdvancedDialog(context, ref),
        ),
      ),
    );
  }

  Future<int?> _showAdvancedDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(asset.name),
        titleTextStyle: Theme.of(context).textTheme.subtitle1,
        children: [
          SimpleDialogOption(
            child: const Text('隐藏'),
            onPressed: () => _hideAsset(context, ref),
          ),
          SimpleDialogOption(
            child: const Text('编辑'),
            onPressed: () => _editAsset(context, ref),
          ),
          SimpleDialogOption(
            child: const Text('删除'),
            onPressed: () => _deleteAsset(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _hideAsset(BuildContext context, WidgetRef ref) async {
    await ref.read(walletAssetProvider.notifier).hide(asset);
    Navigator.of(context).pop();
  }

  Future<void> _editAsset(BuildContext context, WidgetRef ref) async {
    // TODO: implement edit asset
  }

  Future<void> _deleteAsset(BuildContext context, WidgetRef ref) async {
    // TODO: popup a confirm dialog before delete
    await ref.read(walletAssetProvider.notifier).delete(asset);
    Navigator.of(context).pop();
  }
}
