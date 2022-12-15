import 'package:collection/collection.dart';
import 'package:handnote/constants/currency.dart';
import 'package:handnote/utils/formatter.dart';
import 'package:handnote/wallet/constants/wallet_system_category.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';
import 'package:handnote/wallet/model/wallet_bill.dart';

enum WalletImportedBillType {
  transfer,
  income,
  outcome,
  refund,
}

class WalletImportedBill {
  WalletImportedBill({
    required this.reportAccountName,
    required this.datetime,
    required this.currencyType,
    required this.amount,
    required this.billType,
    required this.tradeType,
    required this.counterParty,
    this.suggestCategory,
    this.productName,
    this.transformCounter,
  });

  final String reportAccountName;
  final DateTime datetime;
  final CurrencyType currencyType;
  final double amount;
  WalletImportedBillType billType;

  /// 交易类型
  final String tradeType;

  /// 对方账户
  final String counterParty;

  /// 商品名称
  final String? productName;

  /// 转入转出对象 (支付宝/微信/京东金融/卡号)
  final String? transformCounter;

  int? suggestCategory;

  bool get isIncome => amount > 0;

  bool get isOutcome => !isIncome;

  bool get isTransfer => billType == WalletImportedBillType.transfer;

  bool get isRefund => billType == WalletImportedBillType.refund;

  String get summary => reportAccountName + ':' + [tradeType, counterParty, transformCounter].whereNotNull().join(' ');

  factory WalletImportedBill.fromMap(String reportAccountName, Map<String, dynamic> map) {
    return WalletImportedBill(
      reportAccountName: reportAccountName,
      datetime: DateTime.parse(map['datetime']).toLocal(),
      currencyType: CurrencyType.values.byName(map['currencyType']),
      amount: double.tryParse("${map['amount']}") ?? 0,
      billType: WalletImportedBillType.values.byName(map['billType']),
      tradeType: map['tradeType'],
      counterParty: map['counterParty'],
      productName: map['productName'],
      transformCounter: map['transformCounter'],
    );
  }

  @override
  String toString() {
    return '\nWalletBillImported{${dateFormat.format(datetime)} ${currencyType.name} $amount, \tbillType: ${billType.name}, tradeType: $tradeType, counterParty: $counterParty, productName: $productName, transformCounter: $transformCounter}';
  }

  WalletBill toBill({
    @Deprecated('Use [currentAsset] and [counterAsset]') WalletAsset? fromAsset,
    @Deprecated('Use `currentAsset` and [counterAsset]') WalletAsset? toAsset,
    WalletAsset? currentAsset,
    WalletAsset? counterAsset,
    String? identifier,
    int? categoryId,
  }) {
    WalletBill bill = WalletBill(
      time: datetime,
      counterParty: [counterParty, transformCounter].whereNotNull().join(' '),
      description: tradeType,
      importedId: identifier,
    );
    final amount = this.amount.abs();
    if (isTransfer) {
      if (isIncome) {
        bill = bill.copyWith(
          category: null,
          inAmountType: currencyType,
          inAmount: amount,
          inAssets: currentAsset?.id,
          inImportedSummary: summary,
          outAmountType: currencyType,
          outAmount: amount,
          outAssets: counterAsset?.id,
          outImportedSummary: null,
        );
      } else {
        bill = bill.copyWith(
          category: null,
          inAmountType: currencyType,
          inAmount: amount,
          inAssets: counterAsset?.id,
          inImportedSummary: null,
          outAmountType: currencyType,
          outAmount: amount,
          outAssets: currentAsset?.id,
          outImportedSummary: summary,
        );
      }
    } else if (isRefund) {
      bill = bill.copyWith(
        category: walletSystemCategoryIdMap[WalletSystemCategory.refund],
        inAmountType: currencyType,
        inAmount: amount,
        inAssets: toAsset?.id ?? currentAsset?.id ?? 0,
        inImportedSummary: summary,
      );
    } else if (isIncome) {
      bill = bill.copyWith(
        category: bill.category ?? walletSystemCategoryIdMap[WalletSystemCategory.otherIncome],
        inAmountType: currencyType,
        inAmount: amount,
        inAssets: fromAsset?.id ?? currentAsset?.id ?? 0,
        inImportedSummary: summary,
      );
    } else if (isOutcome) {
      bill = bill.copyWith(
        category: bill.category ?? walletSystemCategoryIdMap[WalletSystemCategory.otherOutcome],
        outAmountType: currencyType,
        outAmount: amount,
        outAssets: toAsset?.id ?? currentAsset?.id ?? 0,
        outImportedSummary: summary,
      );
    }
    return bill;
  }
}

class WalletImportedReport {
  WalletImportedReport({
    required this.accountName,
    required this.startDate,
    required this.endDate,
    required this.count,
    required this.totalIncome,
    required this.totalOutcome,
    required this.bills,
  });

  final String accountName;
  final DateTime startDate;
  final DateTime endDate;
  final int count;
  final double totalIncome;
  final double totalOutcome;
  List<WalletImportedBill> bills;

  String? get identifier => '$accountName-${miniDateFormat.format(startDate)}-${miniDateFormat.format(endDate)}';

  WalletImportedReport copyWith({
    String? accountName,
    DateTime? startDate,
    DateTime? endDate,
    int? count,
    double? totalIncome,
    double? totalOutcome,
    List<WalletImportedBill>? bills,
  }) {
    return WalletImportedReport(
      accountName: accountName ?? this.accountName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      count: count ?? this.count,
      totalIncome: totalIncome ?? this.totalIncome,
      totalOutcome: totalOutcome ?? this.totalOutcome,
      bills: bills ?? this.bills,
    );
  }

  factory WalletImportedReport.fromMap(Map<String, dynamic> map) {
    var accountName = map['accountName'];
    return WalletImportedReport(
      accountName: accountName,
      startDate: DateTime.parse(map['startDate']).toLocal(),
      endDate: DateTime.parse(map['endDate']).toLocal(),
      count: map['count'],
      totalIncome: double.tryParse("${map['totalIncome']}") ?? 0,
      totalOutcome: double.tryParse("${map['totalOutcome']}") ?? 0,
      bills: (map['bills'] as List<dynamic>).map((e) => WalletImportedBill.fromMap(accountName, e)).toList(),
    );
  }
}
