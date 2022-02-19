// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/constants/wallet_asset_category.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_edit_screen.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_select_bank_screen.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/radio_buttons.dart';
import 'package:handnote/widgets/round_icon.dart';

const walletAssetTypeList = <WalletAddAssetItem>[
  // @formatter:off
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.creditCard, name: '信用卡', hasSecondaryMenu: true),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.debitCard, name: '储蓄卡', hasSecondaryMenu: true),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.digitalAssets, name: '数字资产', hasSecondaryMenu: true),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.alipay, name: '支付宝', description: '支持导入账单'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.wechat, name: '微信支付', description: '支持导入账单'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.neteasePay, name: '网易支付'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.tenpay, name: '财付通'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.shoppingCard, name: '购物卡'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.busCard, name: '公交卡'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.schoolCard, name: '校园卡'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.foodCard, name: '餐卡'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.haircutCard, name: '理发卡'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.cash, name: '现金钱包', systemName: '现金钱包'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.otherAsset, name: '其他资产'),
  // receivable
  WalletAddAssetItem(category: WalletAssetCategory.receivable, type: WalletAssetType.borrowOut, name: '借出'),
  WalletAddAssetItem(category: WalletAssetCategory.receivable, type: WalletAssetType.reimburse, name: '报销'),
  WalletAddAssetItem(category: WalletAssetCategory.receivable, type: WalletAssetType.owed, name: '欠款'),
  WalletAddAssetItem(category: WalletAssetCategory.receivable, type: WalletAssetType.otherReceivable, name: '其他应收'),
  // payable
  WalletAddAssetItem(category: WalletAssetCategory.payable, type: WalletAssetType.borrowIn, name: '借入'),
  WalletAddAssetItem(category: WalletAssetCategory.payable, type: WalletAssetType.loan, name: '贷款'),
  WalletAddAssetItem(category: WalletAssetCategory.payable, type: WalletAssetType.otherPayable, name: '其他应付'),
  // @formatter:on
];

class WalletAssetAddScreen extends HookWidget {
  const WalletAssetAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = useState(0);
    final pageController = usePageController();

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('添加资产'),
        ),
        body: Column(
          children: [
            RadioButtons(
              textList: walletAssetCategory,
              selected: category.value,
              onSelected: (index) {
                category.value = index;
                pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
              },
            ),
            Flexible(
              child: PageView(
                controller: pageController,
                children: [
                  for (var i = 0; i < walletAssetCategory.length; i++)
                    ListView(children: _buildAssetList(context, WalletAssetCategory.values[i])),
                ],
                onPageChanged: (index) => category.value = index,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAssetList(BuildContext context, WalletAssetCategory category) {
    return walletAssetTypeList.where((asset) => asset.category == category).map((item) {
      final asset = WalletAsset(category: item.category, type: item.type, name: item.name);

      return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
          title: Text(item.name),
          subtitle: item.description.isNotEmpty ? Text(item.description) : null,
          leading: RoundIcon(walletAssetTypeIconMap[asset.type]),
          trailing: item.hasSecondaryMenu ? const Icon(Icons.chevron_right) : null,
          visualDensity: VisualDensity.standard,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  if (item.hasSecondaryMenu) {
                    return WalletAssetSelectBankScreen(asset: asset);
                  } else {
                    return WalletAssetEditScreen(asset: asset);
                  }
                },
              ),
            );
          },
        ),
      );
    }).toList();
  }
}

class WalletAddAssetItem {
  const WalletAddAssetItem({
    required this.category,
    required this.type,
    required this.name,
    this.description = '',
    this.systemName = '',
    this.hasSecondaryMenu = false,
  });

  final WalletAssetCategory category;
  final WalletAssetType type;
  final String name;
  final String description;
  final String systemName;
  final bool hasSecondaryMenu;
}
