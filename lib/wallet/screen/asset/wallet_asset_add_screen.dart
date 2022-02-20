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
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.creditCard, hasSecondaryMenu: true),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.debitCard, hasSecondaryMenu: true),
  // TODO: add digital asset select page
  // WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.digitalAssets, hasSecondaryMenu: true),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.alipay, description: '支持导入账单'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.wechat, description: '支持导入账单'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.jd),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.neteasePay),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.meituan),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.tenpay),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.shoppingCard),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.busCard),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.schoolCard),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.foodCard),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.haircutCard),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.cash, systemName: '现金钱包'),
  WalletAddAssetItem(category: WalletAssetCategory.fund, type: WalletAssetType.otherAsset),
  // receivable
  WalletAddAssetItem(category: WalletAssetCategory.receivable, type: WalletAssetType.borrowOut),
  WalletAddAssetItem(category: WalletAssetCategory.receivable, type: WalletAssetType.reimburse),
  WalletAddAssetItem(category: WalletAssetCategory.receivable, type: WalletAssetType.otherReceivable),
  // payable
  WalletAddAssetItem(category: WalletAssetCategory.payable, type: WalletAssetType.borrowIn),
  WalletAddAssetItem(category: WalletAssetCategory.payable, type: WalletAssetType.loan),
  WalletAddAssetItem(category: WalletAssetCategory.payable, type: WalletAssetType.jiebei),
  WalletAddAssetItem(category: WalletAssetCategory.payable, type: WalletAssetType.otherPayable),
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
      final theme = Theme.of(context);

      return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
          title: Text(item.name),
          leading: RoundIcon(walletAssetTypeIconMap[asset.type]),
          trailing: item.hasSecondaryMenu
              ? const Icon(Icons.chevron_right)
              : item.description.isNotEmpty
                  ? Text(item.description, style: TextStyle(color: theme.disabledColor))
                  : null,
          visualDensity: VisualDensity.standard,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => item.hasSecondaryMenu
                    ? WalletAssetSelectBankScreen(asset: asset)
                    : WalletAssetEditScreen(asset: asset)));
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
    this.description = '',
    this.systemName = '',
    this.hasSecondaryMenu = false,
  });

  final WalletAssetCategory category;
  final WalletAssetType type;
  final String description;
  final String systemName;
  final bool hasSecondaryMenu;

  get name => assetTypeNameMap[type];
}
