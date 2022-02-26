import 'package:flutter/material.dart';
import 'package:handnote/constants/currency.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/utils/nanoid.dart';

enum WalletBillType {
  outcome,
  income,
  inner,
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
  final Currency? outAmountType;
  final int? inAssets;
  final double inAmount;
  final Currency? inAmountType;
  final DateTime time;
  final String description;
  final String? counterParty;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  bool get isOutcome => inAmount == 0 && outAmount > 0;

  bool get isIncome => inAmount > 0 && outAmount == 0;

  bool get isInner => inAmount > 0 && outAmount > 0;

  double get amount => isOutcome ? outAmount : inAmount;

  WalletBillType get type {
    if (isOutcome) {
      return WalletBillType.outcome;
    } else if (isIncome) {
      return WalletBillType.income;
    } else {
      return WalletBillType.inner;
    }
  }

  WalletBill copyWith({
    String? id,
    int? category,
    int? subCategory,
    int? outAssets,
    double? outAmount,
    Currency? outAmountType,
    int? inAssets,
    double? inAmount,
    Currency? inAmountType,
    DateTime? time,
    String? description,
    String? counterParty,
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
      'out_type': outAmountType?.toString(),
      'in_assets': inAssets,
      'in_amount': inAmount.toStringAsFixed(2),
      'in_type': inAmountType?.toString(),
      'time': time.toIso8601String(),
      'description': description,
      'counter_party': counterParty,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
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
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: map['deleted_at'] == null ? null : DateTime.parse(map['deleted_at']),
    );
  }
}

final billColorMap = <WalletBillType, Color>{
  WalletBillType.outcome: errorColor,
  WalletBillType.income: successColor,
  WalletBillType.inner: primaryColor,
};

final currencyMap = <String, Currency>{
  'RMB': Currency.RMB,
  'USD': Currency.USD,
};
