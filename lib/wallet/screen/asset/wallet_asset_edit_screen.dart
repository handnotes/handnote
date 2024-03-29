import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletAssetEditScreen extends HookConsumerWidget {
  const WalletAssetEditScreen({Key? key, required this.asset}) : super(key: key);

  final WalletAsset asset;

  bool get isEdit => asset.id != null;

  double get originalBalance => asset.balance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bankInfo = bankInfoMap[asset.bank];
    final String bankCardName = assetTypeNameMap[asset.type] ?? '';

    String remarkLabel = '备注名';
    String? remarkHint;

    if (asset.bank != null) {
      remarkLabel = '卡别名';
      remarkHint = '如工资卡、房贷卡等';
    }

    final originalName = bankInfo != null ? bankInfo.name : asset.name;
    final initName = walletAssetTypeOthers.contains(asset.type) ? '' : originalName;
    final name = useState<String>(isEdit ? asset.name : originalName);
    final remark = useState<String>(asset.remark);
    final balance = useState<double>(asset.balance);
    final cardNumber = useState<String?>(asset.cardNumber);

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${isEdit ? '编辑' : '新建'}资产"),
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                          trailing: bankCardName.isNotEmpty
                              ? Text(bankCardName, style: TextStyle(color: theme.disabledColor))
                              : null,
                          title: TextFormField(
                            initialValue: isEdit ? asset.name : initName,
                            decoration: InputDecoration(
                              hintText: originalName,
                              border: InputBorder.none,
                            ),
                            onChanged: (value) => name.value = value,
                          ),
                          leading: bankInfo != null
                              ? RoundIcon(bankInfo.icon)
                              : RoundIcon(walletAssetTypeIconMap[asset.type]),
                        ),
                      ),
                      const Divider(),
                      Semantics(
                        explicitChildNodes: true,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: remarkLabel,
                            hintText: remarkHint,
                            border: InputBorder.none,
                          ),
                          initialValue: asset.remark,
                          onChanged: (value) => remark.value = value,
                        ),
                      ),
                      if (asset.bank != null) ...[
                        const Divider(),
                        Semantics(
                          explicitChildNodes: true,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: '卡号',
                              hintText: '可填尾号进行辨识，也用于导入时自动识别',
                              border: InputBorder.none,
                            ),
                            initialValue: cardNumber.value,
                            onChanged: (value) => cardNumber.value = value,
                          ),
                        ),
                      ]
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
                  child: ElevatedButton(
                    child: const Text('保存'),
                    onPressed: () async {
                      final updated = asset.copyWith(
                        name: name.value,
                        remark: remark.value,
                        balance: balance.value,
                        cardNumber: bankInfo != null ? cardNumber.value : null,
                      );
                      WalletAsset updatedAsset;
                      if (isEdit) {
                        updatedAsset = await ref.read(walletAssetProvider.notifier).update(updated);
                      } else {
                        updatedAsset = await ref.read(walletAssetProvider.notifier).add(updated);
                      }
                      if (updatedAsset.balance != originalBalance) {
                        var walletBill = WalletBill.adjustBalance(
                          assetId: updatedAsset.id!,
                          balance: updatedAsset.balance,
                        );
                        await ref.read(walletBillProvider.notifier).add(walletBill);
                      }
                      Navigator.of(context).pop(updatedAsset);
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
