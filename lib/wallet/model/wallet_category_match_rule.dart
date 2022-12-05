import 'package:handnote/model.dart';
import 'package:handnote/utils/nanoid.dart';
import 'package:handnote/wallet/model/wallet_category.dart';

class WalletCategoryMatchRule implements Model {
  String id;
  WalletCategoryType type;
  String pattern;
  List<String> categoryName;
  double? minAmount;
  double? maxAmount;
  int weight;
  final DateTime createdAt;
  DateTime updatedAt;

  WalletCategoryMatchRule({
    id,
    required this.type,
    required this.pattern,
    required this.categoryName,
    this.minAmount,
    this.maxAmount,
    this.weight = 0,
    createdAt,
    updatedAt,
  })  : id = id ?? nanoid(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
  WalletCategoryMatchRule copyWith({
    String? id,
    WalletCategoryType? type,
    String? pattern,
    List<String>? categoryName,
    double? minAmount,
    double? maxAmount,
    int? weight,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletCategoryMatchRule(
      id: id ?? this.id,
      type: type ?? this.type,
      pattern: pattern ?? this.pattern,
      categoryName: categoryName ?? this.categoryName,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'pattern': pattern,
      'categoryName': categoryName.join(','),
      'minAmount': minAmount?.toStringAsFixed(2),
      'maxAmount': maxAmount?.toStringAsFixed(2),
      'weight': weight,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory WalletCategoryMatchRule.fromMap(Map<String, dynamic> map) {
    return WalletCategoryMatchRule(
      id: map['id'],
      type: WalletCategoryType.values[map['type']],
      pattern: map['pattern'],
      categoryName: (map['categoryName'] as String).split(','),
      minAmount: map['minAmount'],
      maxAmount: map['maxAmount'],
      weight: map['weight'],
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
    );
  }

  @override
  String toString() {
    return 'WalletCategoryMatchRule (${type.name}, w: $weight, pattern: $pattern, category: $categoryName), amount: ${minAmount ?? '-'}/${maxAmount ?? '-'}}\n';
  }
}
