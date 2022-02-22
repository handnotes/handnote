import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/widget/wallet_choose_asset.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/radio_buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletBillEditScreen extends HookConsumerWidget {
  const WalletBillEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final walletAssets = ref.watch(walletAssetProvider);
    final billType = useState(WalletBillType.outcome);
    final asset = useState<WalletAsset?>(null);
    final amount = useState(0.0);

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: RadioButtons(
            inverse: true,
            dense: true,
            childMinSize: 80,
            textList: const ['流出', '流入', '内部转账'],
            selected: billType.value.index,
            onSelected: (index) => billType.value = WalletBillType.values[index],
          ),
        ),
        body: Column(
          children: [
            WalletBillEditAmount(
              billType: billType.value,
              asset: asset.value,
              assets: walletAssets,
              onSelected: (newAsset) => asset.value = newAsset,
              amount: amount.value,
              onAmountChanged: (newValue) => amount.value = newValue,
            ),
          ],
        ),
      ),
    );
  }
}
