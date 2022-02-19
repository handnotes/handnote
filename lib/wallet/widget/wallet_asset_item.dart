import 'package:flutter/material.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_edit_screen.dart';
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
      child: ListTile(
        leading: RoundIcon(walletAssetTypeIconMap[asset.type]),
        title: Text(asset.name),
        subtitle: subTitle.isNotEmpty ? Text(subTitle) : null,
        trailing: CurrencyText(asset.balance, mask: maskBalance, monoFont: false),
        visualDensity: VisualDensity.standard,
        onLongPress: () => _showAdvancedDialog(context, ref),
      ),
    );
  }

  Future<int?> _showAdvancedDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            textTheme: theme.textTheme.copyWith(
              bodyText2: theme.textTheme.bodyText2?.copyWith(fontSize: 16),
            ),
          ),
          child: SimpleDialog(
            title: Text(asset.name),
            children: [
              SimpleDialogOption(
                child: const Text('隐藏'),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                onPressed: () => _hideAsset(context, ref),
              ),
              SimpleDialogOption(
                child: const Text('编辑'),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                onPressed: () => _editAsset(context, ref),
              ),
              SimpleDialogOption(
                child: const Text('删除'),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                onPressed: () => _deleteAsset(context, ref),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _hideAsset(BuildContext context, WidgetRef ref) async {
    await ref.read(walletAssetProvider.notifier).hide(asset);
    Navigator.of(context).pop();
  }

  Future<void> _editAsset(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WalletAssetEditScreen(asset: asset)));
  }

  Future<void> _deleteAsset(BuildContext context, WidgetRef ref) async {
    // TODO: determine if asset is have billing
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确认删除资产：${asset.name}？'),
        actions: [
          TextButton(
            autofocus: true,
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
            child: const Text('确认'),
            onPressed: () async {
              await ref.read(walletAssetProvider.notifier).delete(asset);
              Navigator.of(context)
                ..pop()
                ..pop();
            },
          ),
        ],
      ),
    );
  }
}
