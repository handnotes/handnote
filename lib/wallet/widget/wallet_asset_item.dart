import 'package:flutter/material.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_edit_screen.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletAssetItem extends HookConsumerWidget {
  const WalletAssetItem(
    this.asset, {
    Key? key,
    this.dense = false,
    this.trailingBuilder,
    this.onTap,
    this.allowEdit = false,
  }) : super(key: key);

  final WalletAsset? asset;
  final bool dense;
  final Widget? Function()? trailingBuilder;
  final GestureTapCallback? onTap;
  final bool allowEdit;

  @override
  Widget build(BuildContext context, ref) {
    return dense
        ? _buildListTile(context, ref, asset)
        : Card(
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.1),
            child: _buildListTile(context, ref, asset),
          );
  }

  ListTile _buildListTile(BuildContext context, WidgetRef ref, WalletAsset? asset) {
    final theme = Theme.of(context);
    final bankInfo = bankInfoMap[asset?.bank];
    final assetIcon = asset == null
        ? RoundIcon(
            const Icon(Icons.account_balance_wallet),
            color: theme.disabledColor,
          )
        : bankInfo != null
            ? RoundIcon(bankInfo.icon)
            : RoundIcon(walletAssetTypeIconMap[asset.type]);

    return ListTile(
      minVerticalPadding: 0,
      leading: FittedBox(
        alignment: Alignment.centerLeft,
        child: assetIcon,
      ),
      title: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              asset?.name ?? '选择账户',
              style: theme.textTheme.subtitle1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            if (asset?.subtitle != null)
              Text(
                asset!.subtitle!,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: theme.textTheme.caption,
              )
          ],
        ),
      ),
      trailing: trailingBuilder != null ? trailingBuilder!() : null,
      onTap: onTap,
      onLongPress: allowEdit && asset != null ? () => _showAdvancedDialog(context, ref) : null,
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
            title: Text(asset!.name),
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
    await ref.read(walletAssetProvider.notifier).hide(asset!);
    Navigator.of(context).pop();
  }

  Future<void> _editAsset(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => WalletAssetEditScreen(asset: asset!),
    ));
  }

  Future<void> _deleteAsset(BuildContext context, WidgetRef ref) async {
    // TODO: determine if asset is have billing
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确认删除资产：${asset!.name}？'),
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
              await ref.read(walletAssetProvider.notifier).delete(asset!);
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
