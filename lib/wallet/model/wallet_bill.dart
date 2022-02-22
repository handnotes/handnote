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
    this.inAssets,
    this.inAmount = 0,
    DateTime? time,
    this.description = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
  })  : id = nanoid(),
        time = time ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final int? category;
  final int? subCategory;
  final int? outAssets;
  final double outAmount;
  final int? inAssets;
  final double inAmount;
  final DateTime time;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  WalletBill copyWith({
    String? id,
    int? category,
    int? subCategory,
    int? outAssets,
    double? outAmount,
    int? inAssets,
    double? inAmount,
    DateTime? time,
    String? description,
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
      inAssets: inAssets ?? this.inAssets,
      inAmount: inAmount ?? this.inAmount,
      time: time ?? this.time,
      description: description ?? this.description,
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
      'out_amount': outAmount,
      'in_assets': inAssets,
      'in_amount': inAmount,
      'time': time.millisecondsSinceEpoch,
      'description': description,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'deleted_at': deletedAt?.millisecondsSinceEpoch,
    };
  }

  factory WalletBill.fromMap(Map<String, dynamic> map) {
    return WalletBill(
      id: map['id'],
      category: map['category'],
      subCategory: map['sub_category'],
      outAssets: map['out_assets'],
      outAmount: map['out_amount'],
      inAssets: map['in_assets'],
      inAmount: map['in_amount'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      description: map['description'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      deletedAt: map['deleted_at'] == null ? null : DateTime.fromMillisecondsSinceEpoch(map['deleted_at']),
    );
  }
}
