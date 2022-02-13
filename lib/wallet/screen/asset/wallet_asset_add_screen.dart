import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/enum/wallet_asset_category.dart';
import 'package:handnote/wallet/enum/wallet_asset_type.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_edit_screen.dart';
import 'package:handnote/widgets/radio_buttons.dart';

const walletAssetCategory = ['资金', '应收', '应付'];
final walletAssetTypeList = <WalletAsset>[
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.creditCard, name: '信用卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.debitCard, name: '储蓄卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.alipay, name: '支付宝'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.wechat, name: '微信支付'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.cash, name: '现金'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.livingCard, name: '生活卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.haircutCard, name: '理发卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.digitalAssets, name: '数字资产'),
  // receivable
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.borrowOut, name: '借出'),
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.reimburse, name: '报销'),
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.otherReceivable, name: '其他应收'),
  // payable
  WalletAsset(category: WalletAssetCategory.payable, type: WalletAssetType.borrowIn, name: '借入'),
  WalletAsset(category: WalletAssetCategory.payable, type: WalletAssetType.loan, name: '贷款'),
  WalletAsset(category: WalletAssetCategory.payable, type: WalletAssetType.otherPayable, name: '其他应付'),
];

class WalletAssetAddScreen extends HookWidget {
  const WalletAssetAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('添加资产'),
      ),
      body: Column(
        children: [
          RadioButtons(
            textList: walletAssetCategory,
            selected: category.value,
            onSelected: (index) => category.value = index,
          ),
          Flexible(
            child: ListView(
              children: buildAssetList(context, WalletAssetCategory.values[category.value]),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildAssetList(BuildContext context, WalletAssetCategory category) {
    return walletAssetTypeList.where((asset) => asset.category == category).map((asset) {
      return ListTile(
        title: Text(asset.name),
        leading: walletAssetTypeIcon(asset.type),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WalletAssetEditScreen(
                category: category,
                type: asset.type,
              ),
            ),
          );
        },
      );
    }).toList();
  }
}
