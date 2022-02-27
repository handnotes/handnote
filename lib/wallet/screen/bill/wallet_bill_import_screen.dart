import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/bank.dart';
import 'package:handnote/utils/formatter.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';
import 'package:handnote/wallet/model/wallet_bill_imported.dart';
import 'package:handnote/wallet/screen/bill/wallet_bill_batch_edit_screen.dart';
import 'package:handnote/wallet/widget/wallet_asset_selector.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletBillImportScreen extends HookConsumerWidget {
  const WalletBillImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final jsonString = useState('');
    final report = useState<WalletBillImportedReport?>(null);
    final asset = useState<WalletAsset?>(null);

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('导入账单'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: '请粘贴账单 JSON 内容',
                  border: OutlineInputBorder(),
                ),
                maxLength: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) => jsonString.value = value,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('分析'),
                onPressed: () {
                  report.value = WalletBillImportedReport.fromMap(json.decode(jsonString.value));
                  assert(report.value != null);
                },
              ),
              if (report.value != null) _handleImport(context, report, asset),
            ],
          ),
        ),
      ),
    );
  }

  Widget _handleImport(BuildContext context, ValueNotifier<WalletBillImportedReport?> reportValueNotifier,
      ValueNotifier<WalletAsset?> asset) {
    final report = reportValueNotifier.value!;
    final bySummary = groupBy(report.bills, (WalletBillImported bill) => bill.summary);

    return Expanded(
      child: ListView(children: [
        WalletAssetSelector(asset: asset.value, onSelected: (value) => asset.value = value),
        Text('导入账户：${report.accountName} (${bankInfoMap[Bank.values.byName(report.accountName)]?.name}储蓄卡)'),
        Text('时间范围：${dateFormat.format(report.startDate)} ~ ${dateFormat.format(report.endDate)}'),
        Text('总支出：${report.totalOutcome}'),
        Text('总收入：${report.totalIncome}'),
        Text('总比数：${report.count}'),
        for (final summary in bySummary.keys)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Text(summary),
              OutlinedButton(
                child: const Text('导入这一批'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                ),
                onPressed: () async {
                  final bills = bySummary[summary]!;
                  final result = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WalletBillBatchEditScreen(
                      bills: bills.map((e) => e.toBill(identifier: report.identifier)).toList(),
                      asset: asset.value,
                      // TODO: identify the type and category
                      type: bills.first.isIncome ? WalletBillType.income : WalletBillType.outcome,
                      description: bills.first.tradeType,
                      counterParty: [bills.first.counterParty, bills.first.cardNumber].whereNotNull().join(' '),
                    ),
                  ));
                  if (result == true) {
                    reportValueNotifier.value = reportValueNotifier.value!.copyWith(
                      bills: reportValueNotifier.value!.bills.where((e) => !bills.contains(e)).toList(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('导入成功')));
                  }
                },
              ),
              for (final bill in bySummary[summary]!)
                Text(
                  '${dateFormat.format(bill.datetime)} ${bill.amount} \t${bill.tradeType} ${bill.counterParty} ${bill.cardNumber ?? ''}',
                  softWrap: false,
                ),
            ],
          ),
      ]),
    );
  }
}