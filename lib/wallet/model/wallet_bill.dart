import 'package:flutter/material.dart';
import 'package:handnote/constants/currency.dart';
import 'package:handnote/model.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/nanoid.dart';
import 'package:handnote/wallet/constants/wallet_system_category.dart';

enum WalletBillType {
  outcome,
  income,
  innerTransfer,
}

class WalletBill implements Model {
  @override
  WalletBill({
    String? id,
    this.category,
    this.subCategory,
    this.outAssets,
    this.outAmount = 0,
    this.outAmountType,
    this.outImportedSummary,
    this.inAssets,
    this.inAmount = 0,
    this.inAmountType,
    this.inImportedSummary,
    DateTime? time,
    this.description = '',
    this.counterParty,
    this.importedId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
  })  : id = id ?? nanoid(),
        time = time ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final int? category;
  final int? subCategory;
  final int? outAssets;
  final double outAmount;
  final CurrencyType? outAmountType;
  final String? outImportedSummary;
  final int? inAssets;
  final double inAmount;
  final CurrencyType? inAmountType;
  final String? inImportedSummary;
  final DateTime time;
  final String description;
  final String? counterParty;

  /// Used to distinguish whether the imported data is repeated
  final String? importedId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  bool get isOutcome => inAmount == 0 && outAmount > 0;

  bool get isIncome => inAmount > 0 && outAmount == 0;

  bool get isInnerTransfer => inAmount > 0 && outAmount > 0;

  double get amount => isOutcome ? outAmount : inAmount;

  WalletBillType get type {
    if (isInnerTransfer) {
      return WalletBillType.innerTransfer;
    } else if (isIncome) {
      return WalletBillType.income;
    } else {
      return WalletBillType.outcome;
    }
  }

  WalletBill.adjustBalance({required int assetId, required double balance})
      : this(
          category: walletSystemCategoryIdMap[WalletSystemCategory.adjustBalance],
          inAssets: assetId,
          inAmountType: CurrencyType.CNY,
          inAmount: balance,
        );

  @override
  WalletBill copyWith({
    String? id,
    int? category,
    int? subCategory,
    int? outAssets,
    double? outAmount,
    CurrencyType? outAmountType,
    String? outImportedSummary,
    int? inAssets,
    double? inAmount,
    CurrencyType? inAmountType,
    String? inImportedSummary,
    DateTime? time,
    String? description,
    String? counterParty,
    String? importedId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return WalletBill(
      id: id ?? this.id,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      outAssets: outAssets ?? this.outAssets,
      outAmount: outAmount ?? this.outAmount,
      outAmountType: outAmountType ?? this.outAmountType,
      outImportedSummary: outImportedSummary ?? this.outImportedSummary,
      inAssets: inAssets ?? this.inAssets,
      inAmount: inAmount ?? this.inAmount,
      inAmountType: inAmountType ?? this.inAmountType,
      inImportedSummary: inImportedSummary ?? this.inImportedSummary,
      time: time ?? this.time,
      description: description ?? this.description,
      counterParty: counterParty ?? this.counterParty,
      importedId: importedId ?? this.importedId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'subCategory': subCategory,
      'outAssets': outAssets,
      'outAmount': outAmount.toStringAsFixed(2),
      'outType': outAmountType?.name,
      'outImportedSummary': outImportedSummary,
      'inAssets': inAssets,
      'inAmount': inAmount.toStringAsFixed(2),
      'inType': inAmountType?.name,
      'inImportedSummary': inImportedSummary,
      'time': time.toUtc().toIso8601String(),
      'description': description,
      'counterParty': counterParty,
      'importedId': importedId,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      'deletedAt': deletedAt?.toUtc().toIso8601String(),
    };
  }

  @override
  factory WalletBill.fromMap(Map<String, dynamic> map) {
    return WalletBill(
      id: map['id'],
      category: map['category'],
      subCategory: map['subCategory'],
      outAssets: map['outAssets'],
      outAmount: map['outAmount'],
      outAmountType: currencyMap[map['outType']],
      outImportedSummary: map['outImportedSummary'],
      inAssets: map['inAssets'],
      inAmount: map['inAmount'],
      inAmountType: currencyMap[map['inType']],
      inImportedSummary: map['inImportedSummary'],
      time: DateTime.parse(map['time']).toLocal(),
      description: map['description'],
      counterParty: map['counterParty'],
      importedId: map['importedId'],
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      deletedAt: map['deletedAt'] == null ? null : DateTime.parse(map['deletedAt']).toLocal(),
    );
  }
}

final billColorMap = <WalletBillType, Color>{
  WalletBillType.outcome: errorColor,
  WalletBillType.income: successColor,
  WalletBillType.innerTransfer: primaryColor,
};

final currencyMap = <String, CurrencyType>{
  'CNY': CurrencyType.CNY,
  'USD': CurrencyType.USD,
};
