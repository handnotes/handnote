import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/currency.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
import 'package:handnote/wallet/model/wallet_category.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/wallet/utils/category_tree.dart';
import 'package:handnote/wallet/widget/wallet_asset_selector.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/radio_buttons.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:handnote/widgets/toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletBillBatchEditScreen extends HookConsumerWidget {
  const WalletBillBatchEditScreen({
    Key? key,
    required this.bills,
    this.type,
    required this.description,
    required this.counterParty,
    this.asset,
    this.categoryId,
  }) : super(key: key);

  final List<WalletBill> bills;
  final WalletBillType? type;
  final String description;
  final String counterParty;
  final WalletAsset? asset;
  final int? categoryId;

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);

    final billType = useState(type ?? WalletBillType.outcome);
    final isInner = billType.value == WalletBillType.innerTransfer;
    final descriptionController = useTextEditingController();
    final counterPartyController = useTextEditingController();
    final asset = useState<WalletAsset?>(this.asset);
    final transferAsset = useState<WalletAsset?>(null);
    final category = useState<WalletCategory?>(null);

    final categories = ref.watch(walletCategoryProvider).where((e) => e.type.index == billType.value.index).toList();
    final categoryMap = useMemoized(() => {for (var e in categories) e.id: e}, [categories]);
    final categoryTree = useMemoized(() => WalletCategoryTree.fromList(categories), [categories]);

    useEffect(() {
      descriptionController.text = description;
      counterPartyController.text = counterParty;
      category.value = categoryId != null ? categoryMap[categoryId] : null;
      return null;
    }, []);

    final iconColor = billType.value == WalletBillType.outcome ? Colors.red[300] : Colors.green[300];

    Future<bool> _save() async {
      final description = descriptionController.text;
      if (isInner) {
        if (transferAsset.value == asset.value) {
          Toast.error(context, '转入资产和转出资产不能相同');
          return false;
        }
      } else if (category.value == null) {
        Toast.error(context, '请选择分类');
        return false;
      }
      final List<WalletBill> bills = this.bills.map((bill) {
        bill = bill.copyWith(
          category: category.value?.id,
          description: description,
        );
        if (billType.value == WalletBillType.outcome) {
          bill = bill.copyWith(
            outAssets: asset.value?.id,
            outAmount: bill.amount,
            outAmountType: CurrencyType.RMB,
            inAssets: null,
            inAmount: null,
            inAmountType: null,
          );
        } else if (billType.value == WalletBillType.income) {
          bill = bill.copyWith(
            inAssets: asset.value?.id,
            inAmount: bill.amount,
            inAmountType: CurrencyType.RMB,
            outAssets: null,
            outAmount: null,
            outAmountType: null,
          );
        } else {
          bill = bill.copyWith(
            inAssets: transferAsset.value?.id,
            inAmount: bill.amount,
            inAmountType: CurrencyType.RMB,
            outAssets: asset.value?.id,
            outAmount: bill.amount,
            outAmountType: CurrencyType.RMB,
          );
        }
        return bill;
      }).toList();
      await ref.read(walletBillProvider.notifier).addList(bills);
      return true;
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WalletAssetSelector(
              asset: asset.value,
              onSelected: (newAsset) => asset.value = newAsset,
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
              WalletAssetSelector(
                asset: transferAsset.value,
                onSelected: (newAsset) => transferAsset.value = newAsset,
              ),
            ],
            Container(height: 16, color: theme.backgroundColor),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: '备注',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
              child: TextFormField(
                controller: counterPartyController,
                decoration: const InputDecoration(
                  labelText: '交易对方',
                ),
              ),
            ),
            if (!isInner)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GridView.extent(
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
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text('保存'),
                onPressed: () async {
                  final isSuccess = await _save();
                  if (isSuccess) {
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
