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
  const WalletImportedBill({
    required this.datetime,
    required this.currencyType,
    required this.amount,
    required this.billType,
    required this.tradeType,
    required this.counterParty,
    this.importedSummary,
    this.productName,
    this.cardNumber,
  });

  final DateTime datetime;
  final CurrencyType currencyType;
  final double amount;
  final WalletImportedBillType billType;

  /// 交易类型
  final String tradeType;

  /// 对方账户
  final String counterParty;

  /// 商品名称
  final String? productName;

  /// 转入转出卡号
  final String? cardNumber;

  /// 导入时的交易摘要
  final String? importedSummary;

  bool get isIncome => billType == WalletImportedBillType.income;

  bool get isOutcome => billType == WalletImportedBillType.outcome;

  bool get isTransfer => billType == WalletImportedBillType.transfer;

  bool get isRefund => billType == WalletImportedBillType.refund;

  String get summary => [tradeType, counterParty, cardNumber].whereNotNull().join(' ');

  factory WalletImportedBill.fromMap(Map<String, dynamic> map) {
    return WalletImportedBill(
      datetime: DateTime.parse(map['datetime']).toLocal(),
      currencyType: CurrencyType.values.byName(map['currencyType']),
      amount: double.tryParse("${map['amount']}") ?? 0,
      billType: WalletImportedBillType.values.byName(map['billType']),
      tradeType: map['tradeType'],
      counterParty: map['counterParty'],
      productName: map['productName'],
      cardNumber: map['cardNumber'],
    );
  }

  @override
  String toString() {
    return '\nWalletBillImported{${dateFormat.format(datetime)} ${currencyType.name} $amount, \tbillType: ${billType.name}, tradeType: $tradeType, counterParty: $counterParty, productName: $productName, cardNumber: $cardNumber}';
  }

  WalletBill toBill({
    WalletAsset? fromAsset,
    WalletAsset? toAsset,
    String? identifier,
  }) {
    WalletBill bill = WalletBill(
      time: datetime,
      counterParty: [counterParty, cardNumber].whereNotNull().join(' '),
      description: tradeType,
      importedId: identifier,
    );
    final amount = this.amount.abs();
    if (isIncome) {
      bill = bill.copyWith(
        inAmountType: currencyType,
        inAmount: amount,
        inAssets: fromAsset?.id ?? 0,
        inImportedSummary: importedSummary,
        outAmountType: null,
        outAmount: null,
        outAssets: null,
      );
    } else if (isOutcome) {
      bill = bill.copyWith(
        outAmountType: currencyType,
        outAmount: amount,
        outAssets: toAsset?.id ?? 0,
        outImportedSummary: importedSummary,
        inAmountType: null,
        inAmount: null,
        inAssets: null,
      );
    } else if (isTransfer) {
      bill = bill.copyWith(
        inAmountType: currencyType,
        inAmount: amount,
        inAssets: fromAsset?.id ?? 0,
        inImportedSummary: this.amount > 0 ? importedSummary : null,
        outAmountType: currencyType,
        outAmount: amount,
        outAssets: toAsset?.id ?? 0,
        outImportedSummary: this.amount <= 0 ? importedSummary : null,
      );
    } else if (isRefund) {
      bill = bill.copyWith(
        category: walletSystemCategoryIdMap[WalletSystemCategory.refund],
        inAmountType: currencyType,
        inAmount: amount,
        inAssets: toAsset?.id ?? 0,
        inImportedSummary: importedSummary,
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
    return WalletImportedReport(
      accountName: map['accountName'],
      startDate: DateTime.parse(map['startDate']).toLocal(),
      endDate: DateTime.parse(map['endDate']).toLocal(),
      count: map['count'],
      totalIncome: double.tryParse("${map['totalIncome']}") ?? 0,
      totalOutcome: double.tryParse("${map['totalOutcome']}") ?? 0,
      bills: (map['bills'] as List<dynamic>).map((e) => WalletImportedBill.fromMap(e)).toList(),
    );
  }
}
