import 'package:handnote/constants/bank.dart';
import 'package:handnote/constants/enums.dart';
import 'package:handnote/wallet/constants/wallet_asset_category.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';

class WalletAsset {
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

  /// 初始金额
  final double initAmount;

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
    this.initAmount = 0,
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
}
