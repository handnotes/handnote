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
    final theme = Theme.of(context);
    final walletAssets = ref.watch(walletAssetProvider);

    final billType = useState(WalletBillType.outcome);
    final asset = useState<WalletAsset?>(null);
    final amount = useState(0.0);
    final time = useState<DateTime>(DateTime.now());
    final description = useState<String?>(null);

    final today = DateTime.now();
    final timeDiff = today.difference(time.value);
    final String timeLabel = timeDiff.inDays == 0
        ? '今天'
        : timeDiff.inDays > 365
            ? '${time.value.year}年${time.value.month}月${time.value.day}日'
            : '${time.value.month}月${time.value.day}日';

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: RadioButtons(
            inverse: true,
            dense: true,
            childMinSize: 80,
            textList: const ['流出', '流入', '内部转账'],
            selected: billType.value.index,
            onSelected: (index) => billType.value = WalletBillType.values[index],
          ),
        ),
        body: Column(children: [
          WalletBillEditAmount(
            billType: billType.value,
            asset: asset.value,
            assets: walletAssets,
            onSelected: (newAsset) => asset.value = newAsset,
            amount: amount.value,
            onAmountChanged: (newValue) => amount.value = newValue,
          ),
          Container(height: 16, color: theme.backgroundColor),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 100, maxHeight: double.infinity),
                    child: TextButton.icon(
                      icon: const Icon(Icons.calendar_today_sharp),
                      label: Text(timeLabel),
                      onPressed: () async {
                        time.value = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: today,
                            ) ??
                            DateTime.now();
                      },
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '备注',
                      ),
                      initialValue: description.value,
                      onChanged: (newValue) => description.value = newValue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
