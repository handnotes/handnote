import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/constants/constants.dart';
import 'package:handnote/utils/formatter.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';
import 'package:handnote/wallet/constants/wallet_system_category.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_asset_provider.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
import 'package:handnote/wallet/model/wallet_category.dart';
import 'package:handnote/wallet/model/wallet_category_match_rule.dart';
import 'package:handnote/wallet/model/wallet_category_match_rule_provider.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/wallet/model/wallet_imported.dart';
import 'package:handnote/wallet/screen/bill/wallet_bill_batch_edit_screen.dart';
import 'package:handnote/wallet/widget/wallet_asset_selector.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletBillImportScreen extends HookConsumerWidget {
  const WalletBillImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final jsonStringController = useTextEditingController();
    final report = useState<WalletImportedReport?>(null);
    final asset = useState<WalletAsset?>(null);
    final assets = ref.watch(walletAssetProvider);
    final categories = ref.watch(walletCategoryProvider).toList();
    final matchRules = ref.watch(walletCategoryMatchRuleProvider);
    final billNotifier = ref.read(walletBillProvider.notifier);

    useEffect(() {
      ref.read(walletCategoryMatchRuleProvider.notifier).getList();
      return null;
    }, []);

    void _handleAnalysis() {
      report.value = WalletImportedReport.fromMap(json.decode(jsonStringController.value.text));
      assert(report.value != null);
      var accountName = report.value!.accountName;
      if (accountName == 'alipay') {
        asset.value = assets.firstWhere((e) => e.type == WalletAssetType.alipay);
      } else if (accountName == 'wechat') {
        asset.value = assets.firstWhere((e) => e.type == WalletAssetType.wechat);
      } else if (bankInfoMap.keys.map((e) => e.name).contains(accountName)) {
        // TODO: support credit card
        asset.value = assets.firstWhere((e) => e.bank?.name == accountName && e.type == WalletAssetType.debitCard);
      }
    }

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('导入账单'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(
                height: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      child: const Text('选择文件'),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result != null) {
                          final file = File(result.files.single.path ?? '');
                          final content = await file.readAsString();
                          jsonStringController.text = content;
                          _handleAnalysis();
                        }
                      },
                    ),
                    const VerticalDivider(),
                    Expanded(
                      child: TextField(
                        controller: jsonStringController,
                        decoration: const InputDecoration(
                          hintText: '请粘贴账单 JSON 内容',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        maxLength: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) => jsonStringController.text = value,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('分析'),
                onPressed: _handleAnalysis,
              ),
              if (report.value != null)
                ..._handleImport(context, report, asset, assets, matchRules, categories, billNotifier),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _handleImport(
    BuildContext context,
    ValueNotifier<WalletImportedReport?> reportValueNotifier,
    ValueNotifier<WalletAsset?> asset,
    List<WalletAsset> assets,
    List<WalletCategoryMatchRule> matchRules,
    List<WalletCategory> categories,
    WalletBillNotifier billNotifier,
  ) {
    final categoryNameMap = useMemoized(() => {for (var e in categories) '${e.type.name}.${e.name}': e}, [categories]);
    final categoryIdMap = useMemoized(() => {for (var e in categories) e.id: e}, [categories]);
    final report = reportValueNotifier.value!;
    final nonZeroBills = report.bills.where((e) => e.amount != 0);
    var billGroup = useMemoized(() {
      var list = groupBy(
        nonZeroBills,
        (WalletImportedBill bill) =>
            '${bill.amount > 0 ? 'income' : 'outcome'}, ${bill.summary}, ${bill.suggestCategory}',
      ).entries.toList();
      list.sort((a, b) => b.value.length.compareTo(a.value.length));
      return list;
    }, [report.bills]);

    useEffect(() {
      _autoCategory(billGroup, matchRules, categoryNameMap);
      reportValueNotifier.value = reportValueNotifier.value!.copyWith(
        bills: [...reportValueNotifier.value!.bills],
      );
      return null;
    }, [billGroup]);

    return [
      WalletAssetSelector(asset: asset.value, onSelected: (value) => asset.value = value),
      // TODO: support alipay (${bankInfoMap[Bank.values.byName(report.accountName)]?.name}储蓄卡)'
      Text('导入账户：${report.accountName}'),
      Text('时间范围：${dateFormat.format(report.startDate.toLocal())} ~ ${dateFormat.format(report.endDate.toLocal())}'),
      Text('总支出：${currencyTableFormatter.format(report.totalOutcome).padLeft(12)}',
          style: const TextStyle(fontFamily: fontMonospace)),
      Text('总收入：${currencyTableFormatter.format(report.totalIncome).padLeft(12)}',
          style: const TextStyle(fontFamily: fontMonospace)),
      Text('总条数：${report.bills.length} (无金额条数: ${report.bills.length - nonZeroBills.length})'),
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      OutlinedButton(
        child: const Text('自动导入'),
        onPressed: () {
          if (asset.value == null) {
            Toast.error(context, '请先选择要导入的账户');
            return;
          }
        },
      ),
      for (final map in billGroup)
        Builder(builder: (context) {
          final bills = map.value;
          final bill = bills.first;
          final summary =
              'type: ${bill.billType.name}\ntradeType: ${bill.tradeType}\ncounter: ${bill.counterParty}\ncard: ${bill.cardNumber}\ncategory: ${categoryIdMap[bill.suggestCategory]?.name}';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Text(summary),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(children: [
                  if (bill.suggestCategory != null) ...[
                    ElevatedButton(
                      child: Text('导入到"${categoryIdMap[bill.suggestCategory]?.name}"'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      ),
                      onPressed: () async {
                        if (asset.value == null) {
                          Toast.error(context, '请先选择要导入的账户');
                          return;
                        }
                        await _importClassifiedBills(billNotifier, asset.value!, report.identifier!, bills);
                        reportValueNotifier.value = reportValueNotifier.value!.copyWith(
                          bills: reportValueNotifier.value!.bills.where((e) => !bills.contains(e)).toList(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('导入成功')));
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                  OutlinedButton(
                    child: const Text('修改并导入'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    ),
                    onPressed: () async {
                      bool result = false;
                      result = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => walletBillBatchEditScreen(summary, bills, report, asset.value, assets),
                      ));
                      if (result == true) {
                        reportValueNotifier.value = reportValueNotifier.value!.copyWith(
                          bills: reportValueNotifier.value!.bills.where((e) => !bills.contains(e)).toList(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('导入成功')));
                      }
                    },
                  ),
                ]),
              ),
              const Text(
                '时间                         金额',
                softWrap: false,
                style: TextStyle(fontFamily: fontMonospace),
              ),
              for (final bill in bills)
                Text(
                  '${dateTimeFormat.format(bill.datetime)} ${currencyTableFormatter.format(bill.amount).padLeft(12)} ${bill.suggestCategory ?? ''}',
                  softWrap: false,
                  style: const TextStyle(fontFamily: fontMonospace),
                ),
            ],
          );
        }),
    ];
  }

  Future<void> _importClassifiedBills(
    WalletBillNotifier billNotifier,
    WalletAsset asset,
    String importIdentifier,
    List<WalletImportedBill> importedBills,
  ) async {
    final bills = importedBills.map((importedBill) {
      importedBill.summary;
      final bill = importedBill.toBill(
        currentAsset: asset,
        identifier: importIdentifier,
      );
      return bill;
    });
    for (var bill in bills) {
      await billNotifier.add(bill);
    }
  }

  Widget walletBillBatchEditScreen(
    String summary,
    List<WalletImportedBill> bills,
    WalletImportedReport report,
    WalletAsset? asset,
    List<WalletAsset> assets,
  ) {
    if (summary.contains(RegExp(r'(快捷支付|还款|转出|转入)'))) {
      WalletAssetType? assetType;
      String? cardNumber;
      if (summary.contains('微信')) {
        assetType = WalletAssetType.wechat;
      } else if (summary.contains('支付宝')) {
        assetType = WalletAssetType.alipay;
      } else if (summary.contains('京东')) {
        assetType = WalletAssetType.jd;
      } else if (summary.contains('信用卡')) {
        assetType = WalletAssetType.creditCard;
        cardNumber = summary.split(' ').last;
      }
      var outcomeAsset = asset;
      var transferAsset = assetType != null
          ? assets.firstWhereOrNull(
              (element) => element.type == assetType && (cardNumber != null ? element.cardNumber == cardNumber : true))
          : null;
      if (bills.first.amount > 0) {
        outcomeAsset = transferAsset;
        transferAsset = asset;
      }
      return WalletBillBatchEditScreen(
        bills: bills.map((e) => e.toBill(identifier: report.identifier)).toList(),
        type: WalletBillType.innerTransfer,
        asset: outcomeAsset,
        transferAsset: transferAsset,
        description: bills.first.tradeType,
        counterParty: [bills.first.counterParty, bills.first.cardNumber].whereNotNull().join(' '),
      );
    }

    if (summary.contains('退款')) {
      return WalletBillBatchEditScreen(
        bills: bills.map((e) => e.toBill(identifier: report.identifier)).toList(),
        type: WalletBillType.income,
        asset: asset,
        description: bills.first.tradeType,
        counterParty: [bills.first.counterParty, bills.first.cardNumber].whereNotNull().join(' '),
        categoryId: walletSystemCategoryIdMap[WalletSystemCategory.refund],
      );
    }

    if (summary.contains('结息')) {
      return WalletBillBatchEditScreen(
        bills: bills.map((e) => e.toBill(identifier: report.identifier)).toList(),
        type: WalletBillType.income,
        asset: asset,
        description: bills.first.tradeType,
        counterParty: [bills.first.counterParty, bills.first.cardNumber].whereNotNull().join(' '),
        categoryId: walletSystemCategoryIdMap[WalletSystemCategory.interestIncome],
      );
    }

    return WalletBillBatchEditScreen(
      bills: bills.map((e) => e.toBill(identifier: report.identifier)).toList(),
      asset: asset,
      // TODO: identify the type and category
      type: bills.first.isIncome
          ? WalletBillType.income
          : bills.first.isOutcome
              ? WalletBillType.outcome
              : bills.first.amount > 0
                  ? WalletBillType.income
                  : WalletBillType.outcome,
      description: bills.first.tradeType,
      counterParty: [bills.first.counterParty, bills.first.cardNumber].whereNotNull().join(' '),
    );
  }

  Future<void> _autoCategory(
    List<MapEntry<String, List<WalletImportedBill>>> billGroup,
    List<WalletCategoryMatchRule> matchRules,
    Map<String, WalletCategory> categoryNameMap,
  ) async {
    final incomeMatchRules = matchRules.where((it) => it.type == WalletCategoryType.income);
    final outcomeMatchRules = matchRules.where((it) => it.type == WalletCategoryType.outcome);
    // 遍历 group
    for (final kv in billGroup) {
      final bills = kv.value;
      final summary = bills.first.summary;
      final isIncome = bills.first.amount > 0;
      final rules = isIncome ? incomeMatchRules : outcomeMatchRules;
      // 遍历匹配规则
      for (final rule in rules) {
        if (!RegExp(rule.pattern.replaceAll(r'\', '\\')).hasMatch(summary)) continue;
        // 遍历group中的每笔账单
        for (final bill in bills) {
          if (bill.suggestCategory != null) continue;
          if (rule.minAmount != null && bill.amount.abs() < rule.minAmount!) continue;
          if (rule.maxAmount != null && bill.amount.abs() > rule.maxAmount!) continue;
          // 遍历推荐分类，依次寻找是否有分类相匹配
          for (final categoryName in rule.categoryName.reversed) {
            final walletCategoryType = isIncome ? WalletCategoryType.income : WalletCategoryType.outcome;
            final suggestedCategory = categoryNameMap['${walletCategoryType.name}.$categoryName'];
            if (suggestedCategory != null) {
              bill.suggestCategory = suggestedCategory.id;
              break;
            }
          }
        }
      }
    }
  }
}
