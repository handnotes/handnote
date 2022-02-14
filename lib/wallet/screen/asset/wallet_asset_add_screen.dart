import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/constants/wallet_asset_category.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';
import 'package:handnote/wallet/constants/wallet_icon_map.dart';
import 'package:handnote/wallet/screen/asset/wallet_asset_edit_screen.dart';
import 'package:handnote/widgets/radio_buttons.dart';
import 'package:handnote/widgets/round_icon.dart';

class WalletAssetAddScreen extends HookWidget {
  const WalletAssetAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = useState(0);
    final pageController = usePageController();

    return Scaffold(
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
    );
  }

  List<Widget> _buildAssetList(BuildContext context, WalletAssetCategory category) {
    return walletAssetTypeList.where((asset) => asset.category == category).map((asset) {
      return ListTile(
        title: Text(asset.name),
        leading: RoundIcon(walletAssetTypeIconMap[asset.type]),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => WalletAssetEditScreen(asset: asset),
            ),
          );
        },
      );
    }).toList();
  }
}
