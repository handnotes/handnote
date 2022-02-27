import 'package:flutter/material.dart';
import 'package:handnote/constants/currency.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/nanoid.dart';

enum WalletBillType {
  outcome,
  income,
  innerTransfer,
}

class WalletBill {
  WalletBill({
    String? id,
    this.category,
    this.subCategory,
    this.outAssets,
    this.outAmount = 0,
    this.outAmountType,
    this.inAssets,
    this.inAmount = 0,
    this.inAmountType,
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
  final int? inAssets;
  final double inAmount;
  final CurrencyType? inAmountType;
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

  WalletBill copyWith({
    String? id,
    int? category,
    int? subCategory,
    int? outAssets,
    double? outAmount,
    CurrencyType? outAmountType,
    int? inAssets,
    double? inAmount,
    CurrencyType? inAmountType,
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
      inAssets: inAssets ?? this.inAssets,
      inAmount: inAmount ?? this.inAmount,
      inAmountType: inAmountType ?? this.inAmountType,
      time: time ?? this.time,
      description: description ?? this.description,
      counterParty: counterParty ?? this.counterParty,
      importedId: importedId ?? this.importedId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'sub_category': subCategory,
      'out_assets': outAssets,
      'out_amount': outAmount.toStringAsFixed(2),
      'out_type': outAmountType?.name,
      'in_assets': inAssets,
      'in_amount': inAmount.toStringAsFixed(2),
      'in_type': inAmountType?.name,
      'time': time.toUtc().toIso8601String(),
      'description': description,
      'counter_party': counterParty,
      'imported_id': importedId,
      'created_at': createdAt.toUtc().toIso8601String(),
      'updated_at': updatedAt.toUtc().toIso8601String(),
      'deleted_at': deletedAt?.toUtc().toIso8601String(),
    };
  }

  factory WalletBill.fromMap(Map<String, dynamic> map) {
    return WalletBill(
      id: map['id'],
      category: map['category'],
      subCategory: map['sub_category'],
      outAssets: map['out_assets'],
      outAmount: map['out_amount'],
      outAmountType: currencyMap[map['out_type']],
      inAssets: map['in_assets'],
      inAmount: map['in_amount'],
      inAmountType: currencyMap[map['in_type']],
      time: DateTime.parse(map['time']),
      description: map['description'],
      counterParty: map['counter_party'],
      importedId: map['imported_id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: map['deleted_at'] == null ? null : DateTime.parse(map['deleted_at']),
    );
  }
}

final billColorMap = <WalletBillType, Color>{
  WalletBillType.outcome: errorColor,
  WalletBillType.income: successColor,
  WalletBillType.innerTransfer: primaryColor,
};

final currencyMap = <String, CurrencyType>{
  'RMB': CurrencyType.RMB,
  'USD': CurrencyType.USD,
};
