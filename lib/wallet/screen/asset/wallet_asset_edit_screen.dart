import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletAssetEditScreen extends HookConsumerWidget {
  const WalletAssetEditScreen({Key? key, required this.asset}) : super(key: key);

  final WalletAsset asset;

  bool get isEdit => asset.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final remark = useState<String>(asset.remark);
    final balance = useState<double>(asset.balance);

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${isEdit ? '编辑' : '新建'}账户"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, semanticLabel: '返回'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: theme.scaffoldBackgroundColor,
          child: Form(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 16.0),
                  color: theme.colorScheme.surface,
                  child: Column(
                    children: [
                      Semantics(
                        explicitChildNodes: true,
                        child: ListTile(
                          title: Text(asset.name),
                          leading: RoundIcon(walletAssetTypeIconMap[asset.type]),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        ),
                      ),
                      const Divider(),
                      Semantics(
                        explicitChildNodes: true,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: '备注名',
                            border: InputBorder.none,
                          ),
                          initialValue: asset.remark,
                          onChanged: (value) => remark.value = value,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  color: theme.colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        explicitChildNodes: true,
                        child: TextFormField(
                          initialValue: asset.balance == 0 ? null : asset.balance.toString(),
                          decoration: const InputDecoration(
                            labelText: '账户余额',
                            hintText: '0.00',
                            prefixText: '¥',
                            hintStyle: TextStyle(fontSize: 22, fontFamily: fontMonospace),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 22, fontFamily: fontMonospace),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          onChanged: (value) => balance.value = double.tryParse(value) ?? 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      padding: const EdgeInsets.all(24),
                    ),
                    child: Text(
                      '保存',
                      style: theme.textTheme.subtitle1?.copyWith(
                        letterSpacing: 1.5,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    onPressed: () async {
                      final updated = asset.copyWith(
                        remark: remark.value,
                        balance: balance.value,
                      );
                      if (isEdit) {
                        await ref.read(walletAssetProvider.notifier).update(updated);
                      } else {
                        await ref.read(walletAssetProvider.notifier).add(updated);
                      }
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
