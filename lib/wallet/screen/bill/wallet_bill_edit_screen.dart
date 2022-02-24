import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
import 'package:handnote/wallet/model/wallet_category.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/wallet/utils/category_tree.dart';
import 'package:handnote/wallet/widget/wallet_choose_asset.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/radio_buttons.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:handnote/widgets/toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletBillEditScreen extends HookConsumerWidget {
  const WalletBillEditScreen({Key? key, this.bill}) : super(key: key);

  final WalletBill? bill;

  get isEdit => bill != null;

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final assets = ref.watch(walletAssetProvider);

    // TODO: setup init value when edit
    // TODO: add internal transfer billType
    final billType = useState(WalletBillType.outcome);
    final asset = useState<WalletAsset?>(null);
    final time = useState<DateTime>(bill?.time ?? DateTime.now());
    final category = useState<WalletCategory?>(null);

    final amountController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final categoryList = ref.watch(walletCategoryProvider).where((e) => e.type.index == billType.value.index).toList();
    final categoryTree = useMemoized(() => WalletCategoryTree.fromList(categoryList), [categoryList]);

    useEffect(() {
      ref.read(walletCategoryProvider.notifier).getList();
      amountController.text = (bill?.inAmount ?? bill?.outAmount ?? '').toString();
      descriptionController.text = bill?.description ?? '';
    }, []);

    final iconColor = billType.value == WalletBillType.outcome ? Colors.red[300] : Colors.green[300];
    final today = DateTime.now();
    final timeDiff = today.difference(time.value);
    final String timeLabel = timeDiff.inDays == 0
        ? '今天'
        : timeDiff.inDays > 365
            ? '${time.value.year}年${time.value.month}月${time.value.day}日'
            : '${time.value.month}月${time.value.day}日';

    Future<bool> _save() async {
      final amount = double.tryParse(amountController.text) ?? 0;
      final description = descriptionController.text;
      if (amount <= 0) {
        Toast.error(context, '请输入金额');
        return false;
      } else if (category.value == null) {
        Toast.error(context, '请选择分类');
        return false;
      }
      WalletBill bill = this.bill ?? WalletBill();
      bill = bill.copyWith(
        category: category.value?.id,
        // TODO: add subcategory
        time: time.value,
        description: description,
      );
      if (billType.value == WalletBillType.outcome) {
        bill = bill.copyWith(
          outAssets: asset.value?.id,
          outAmount: amount,
        );
      } else {
        bill = bill.copyWith(
          inAssets: asset.value?.id,
          inAmount: amount,
        );
      }
      if (isEdit) {
        await ref.read(walletBillProvider.notifier).update(bill);
      } else {
        await ref.read(walletBillProvider.notifier).add(bill);
      }
      return true;
    }

    Future<void> _delete() async {
      assert(bill != null);
      await ref.read(walletBillProvider.notifier).delete(bill!);
    }

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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            WalletBillEditAmount(
              billType: billType.value,
              asset: asset.value,
              assets: assets,
              onSelected: (newAsset) => asset.value = newAsset,
              amountController: amountController,
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
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: '备注',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.extent(
                // FIXME: grid view maybe overflow
                shrinkWrap: true,
                maxCrossAxisExtent: 76,
                mainAxisSpacing: 8,
                children: [
                  for (final categoryNode in categoryTree.children)
                    Builder(builder: (context) {
                      final color = categoryNode.id == category.value?.id ? iconColor : theme.disabledColor;
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: RoundIcon(Icon(categoryNode.category.icon, color: color)),
                              onPressed: () => category.value = categoryNode.category,
                            ),
                          ),
                          Positioned.fill(
                            top: null,
                            child: Text(
                              categoryNode.category.name,
                              style: TextStyle(color: color, fontSize: theme.textTheme.caption?.fontSize),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    })
                ],
              ),
            ),
            const Spacer(),
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isEdit)
                      Expanded(
                        child: OutlinedButton(
                          child: const Text('删除'),
                          onPressed: () async {
                            await _delete();
                            Navigator.of(context).pop();
                            // TODO: toast and revert
                          },
                        ),
                      )
                    else
                      Expanded(
                        child: OutlinedButton(
                          child: const Text('再记一笔'),
                          onPressed: () async {
                            final isSuccess = await _save();
                            if (isSuccess) {
                              amountController.clear();
                              descriptionController.clear();
                              // TODO: toast success and focus on amount
                            }
                          },
                        ),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('保存'),
                        onPressed: () async {
                          final isSuccess = await _save();
                          if (isSuccess) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}