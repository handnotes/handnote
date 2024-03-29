import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/currency.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
import 'package:handnote/wallet/model/wallet_category.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/wallet/screen/category/wallet_category_manage_screen.dart';
import 'package:handnote/wallet/utils/category_tree.dart';
import 'package:handnote/wallet/widget/wallet_bill_edit_amount.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/radio_buttons.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:handnote/widgets/toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletBillEditScreen extends HookConsumerWidget {
  const WalletBillEditScreen({
    Key? key,
    this.bill,
    this.isEdit = true,
  }) : super(key: key);

  final WalletBill? bill;
  final bool isEdit;

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);

    final billType = useState(bill?.type ?? WalletBillType.outcome);
    final isInner = billType.value == WalletBillType.innerTransfer;
    final time = useState<DateTime>(bill?.time ?? DateTime.now());
    final descriptionController = useTextEditingController();
    final counterPartyController = useTextEditingController();
    final amountController = useTextEditingController();
    final asset = useState<WalletAsset?>(null);
    final transferAsset = useState<WalletAsset?>(null);
    final category = useState<WalletCategory?>(null);

    final assets = ref.watch(walletAssetProvider);
    final assetMap = useMemoized(() => {for (var e in assets) e.id: e}, [assets]);
    final categories = ref.watch(walletCategoryProvider).where((e) => e.type.index == billType.value.index).toList();
    final categoryMap = useMemoized(() => {for (var e in categories) e.id: e}, [categories]);
    final categoryTree = useMemoized(() => WalletCategoryTree.fromList(categories), [categories]);

    useEffect(() {
      amountController.text = (bill?.isOutcome == true ? bill?.outAmount : bill?.inAmount ?? '').toString();
      descriptionController.text = bill?.description ?? '';
      counterPartyController.text = bill?.counterParty ?? '';
      asset.value = assetMap[bill?.isIncome == true ? bill!.inAssets : bill?.outAssets];
      if (bill?.isInnerTransfer == true) transferAsset.value = assetMap[bill?.inAssets];
      category.value = bill?.category != null ? categoryMap[bill!.category] : null;
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
      }
      if (isInner) {
        if (transferAsset.value == asset.value) {
          Toast.error(context, '转入资产和转出资产不能相同');
          return false;
        }
      } else if (category.value == null) {
        Toast.error(context, '请选择分类');
        return false;
      }
      WalletBill bill = this.bill ?? WalletBill();
      bill = bill.copyWith(
        // TODO: multiple currency type support
        inAmountType: CurrencyType.CNY,
        outAmountType: CurrencyType.CNY,
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
      } else if (billType.value == WalletBillType.income) {
        bill = bill.copyWith(
          inAssets: asset.value?.id,
          inAmount: amount,
        );
      } else {
        bill = bill.copyWith(
          inAssets: transferAsset.value?.id,
          inAmount: amount,
          outAssets: asset.value?.id,
          outAmount: amount,
        );
      }
      if (isEdit) {
        await ref.read(walletBillProvider.notifier).update(bill);
      } else {
        await ref.read(walletBillProvider.notifier).add(bill);
      }
      await ref.read(walletAssetProvider.notifier).reloadBalance(bill.inAssets);
      await ref.read(walletAssetProvider.notifier).reloadBalance(bill.outAssets);
      return true;
    }

    Future<void> _delete() async {
      assert(bill != null);
      await ref.read(walletBillProvider.notifier).delete(bill!);
    }

    void _swapTransfer() {
      final temp = transferAsset.value;
      transferAsset.value = asset.value;
      asset.value = temp;
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
              billType: isInner ? WalletBillType.outcome : billType.value,
              asset: asset.value,
              assets: assets,
              onSelected: (newAsset) => asset.value = newAsset,
              amountController: amountController,
            ),
            if (isInner) ...[
              Container(
                alignment: Alignment.center,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  icon: const RotatedBox(quarterTurns: 1, child: Icon(Icons.switch_left)),
                  label: const Text('转至'),
                  onPressed: _swapTransfer,
                ),
              ),
              WalletBillEditAmount(
                billType: WalletBillType.income,
                asset: transferAsset.value,
                assets: assets,
                onSelected: (newAsset) => transferAsset.value = newAsset,
                amountController: amountController,
              ),
            ],
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
            if (bill?.importedId != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(right: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: theme.disabledColor,
                      ),
                      child: Text('已导入', style: theme.textTheme.caption),
                    ),
                  ],
                ),
              ),
            if (!isInner)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                  child: GridView.extent(
                    maxCrossAxisExtent: 76,
                    mainAxisSpacing: 8,
                    children: _buildCategories(context, categoryTree, category, iconColor),
                  ),
                ),
              ),
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

  List<Widget> _buildCategories(BuildContext context,
      WalletCategoryTree categoryTree,
      ValueNotifier<WalletCategory?> category,
      Color? iconColor,) {
    final theme = Theme.of(context);
    return [
      for (final categoryNode in categoryTree.children) _buildCategoryItem(context, categoryNode, category, iconColor),
      Stack(children: [
        Positioned.fill(
          child: IconButton(
            icon: RoundIcon(
              const Icon(Icons.settings, color: Colors.transparent),
              borderSide: BorderSide(color: theme.disabledColor),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WalletCategoryManageScreen(),
              ));
            },
          ),
        ),
        Positioned.fill(
          top: null,
          bottom: -2,
          child: Text(
            '管理',
            style: TextStyle(color: theme.disabledColor, fontSize: theme.textTheme.caption?.fontSize),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    ];
  }

  Widget _buildCategoryItem(BuildContext context,
      WalletCategoryTree categoryNode,
      ValueNotifier<WalletCategory?> category,
      Color? iconColor,) {
    final theme = Theme.of(context);
    final color = categoryNode.id == category.value?.id ? iconColor : theme.disabledColor;
    return Stack(children: [
      Positioned.fill(
        child: IconButton(
          icon: RoundIcon(Icon(categoryNode.category.icon, color: color)),
          onPressed: () => category.value = categoryNode.category,
        ),
      ),
      Positioned.fill(
        top: null,
        bottom: -2,
        child: Text(
          categoryNode.category.name,
          style: TextStyle(color: color, fontSize: theme.textTheme.caption?.fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}
