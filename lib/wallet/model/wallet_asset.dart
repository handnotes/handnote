import 'package:handnote/constants/bank.dart';
import 'package:handnote/constants/enums.dart';
import 'package:handnote/model.dart';
import 'package:handnote/utils/extensions.dart'; // ignore: unused_import
import 'package:handnote/utils/string.dart';
import 'package:handnote/wallet/constants/wallet_asset_category.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';

class WalletAsset implements Model {
  final int? id;

  final WalletAssetCategory category;

  final WalletAssetType type;

  /// 卡片/资产/责任人名称
  final String name;

  final String remark;

  final Status status;

  final bool showInHomePage;

  /// 是否允许记账
  final bool allowBill;

  /// 不计入资产总额
  final bool notCounted;

  final double balance;

  final Bank? bank;

  final String? cardNumber;

  /// 到期日/还款日
  final DateTime? repaymentDate;

  /// (信用卡/花呗)账单日
  final DateTime? billingDate;

  final DateTime createdAt;

  final DateTime updatedAt;

  final DateTime? deletedAt;

  @override
  WalletAsset({
    this.id,
    required this.category,
    required this.type,
    required this.name,
    this.remark = '',
    this.status = Status.active,
    this.showInHomePage = true,
    this.allowBill = true,
    this.notCounted = false,
    this.balance = 0,
    this.bank,
    this.cardNumber,
    this.repaymentDate,
    this.billingDate,
    createdAt,
    updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
  WalletAsset copyWith({
    int? id,
    WalletAssetCategory? category,
    WalletAssetType? type,
    String? name,
    String? remark,
    Status? status,
    bool? showInHomePage,
    bool? allowBill,
    bool? notCounted,
    double? initAmount,
    double? balance,
    Bank? bank,
    String? cardNumber,
    DateTime? repaymentDate,
    DateTime? billingDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return WalletAsset(
      id: id ?? this.id,
      category: category ?? this.category,
      type: type ?? this.type,
      name: name ?? this.name,
      remark: remark ?? this.remark,
      status: status ?? this.status,
      showInHomePage: showInHomePage ?? this.showInHomePage,
      allowBill: allowBill ?? this.allowBill,
      notCounted: notCounted ?? this.notCounted,
      balance: balance ?? this.balance,
      bank: bank ?? this.bank,
      cardNumber: cardNumber ?? this.cardNumber,
      repaymentDate: repaymentDate ?? this.repaymentDate,
      billingDate: billingDate ?? this.billingDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'category': category.index,
      'type': type.name,
      'name': name,
      'remark': remark,
      'status': status.index,
      'showInHomePage': showInHomePage ? 1 : 0,
      'allowBill': allowBill ? 1 : 0,
      'notCounted': notCounted ? 1 : 0,
      'balance': balance.toStringAsFixed(2),
      'bank': bank?.name,
      'cardNumber': cardNumber,
      'repaymentDate': repaymentDate?.toUtc().toIso8601String(),
      'billingDate': billingDate?.toUtc().toIso8601String(),
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      'deletedAt': deletedAt?.toUtc().toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  factory WalletAsset.fromMap(Map<String, dynamic> map) {
    return WalletAsset(
      id: map['id'],
      category: WalletAssetCategory.values[map['category']],
      type: WalletAssetType.values.byName(map['type']),
      name: map['name'],
      remark: map['remark'],
      status: Status.values[map['status']],
      showInHomePage: map['showInHomePage'] == 1,
      allowBill: map['allowBill'] == 1,
      notCounted: map['notCounted'] == 1,
      balance: map['balance'],
      bank: map['bank'] != null ? Bank.values.byName(map['bank']) : null,
      cardNumber: map['cardNumber'],
      repaymentDate: map['repaymentDate']?.let((it) => DateTime.parse(it).toLocal()),
      billingDate: map['billingDate']?.let((it) => DateTime.parse(it).toLocal()),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      deletedAt: map['deletedAt']?.let((it) => DateTime.parse(it).toLocal()),
    );
  }

  @override
  String toString() => 'WalletAsset(id:$id, category:${category.name}, type:${type.name}, name:$name)';

  String? get subtitle {
    final bankInfo = bankInfoMap[bank];
    final String cardNumber = this.cardNumber?.slice(-4) ?? '';
    final String bankCardName = (bankInfo != null ? assetTypeNameMap[type] : null) ?? '';
    final String subTitle = (remark.isNotEmpty ? remark : '$bankCardName $cardNumber').trim();
    return subTitle.isNotEmpty ? subTitle : null;
  }
}
