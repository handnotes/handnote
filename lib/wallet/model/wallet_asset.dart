import 'package:handnote/constants/bank.dart';
import 'package:handnote/constants/enums.dart';
import 'package:handnote/utils/extensions.dart'; // ignore: unused_import
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
      initAmount: initAmount ?? this.initAmount,
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

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'category': category.index,
      'type': type.name,
      'name': name,
      'remark': remark,
      'status': status.index,
      'show_in_home_page': showInHomePage ? 1 : 0,
      'allow_bill': allowBill ? 1 : 0,
      'not_counted': notCounted ? 1 : 0,
      'init_amount': initAmount,
      'balance': balance,
      'bank': bank?.name,
      'card_number': cardNumber,
      'repayment_date': repaymentDate?.millisecondsSinceEpoch,
      'billing_date': billingDate?.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'deleted_at': deletedAt?.millisecondsSinceEpoch,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory WalletAsset.fromMap(Map<String, dynamic> map) {
    return WalletAsset(
      id: map['id'],
      category: WalletAssetCategory.values[map['category']],
      type: WalletAssetType.values.byName(map['type']),
      name: map['name'],
      remark: map['remark'],
      status: Status.values[map['status']],
      showInHomePage: map['show_in_home_page'] == 1,
      allowBill: map['allow_bill'] == 1,
      notCounted: map['not_counted'] == 1,
      initAmount: map['init_amount'],
      balance: map['balance'],
      bank: map['bank'] != null ? Bank.values.byName(map['bank']) : null,
      cardNumber: map['card_number'],
      repaymentDate: map['repayment_date']?.let((it) => DateTime.fromMillisecondsSinceEpoch(it)),
      billingDate: map['billing_date']?.let((it) => DateTime.fromMillisecondsSinceEpoch(it)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      deletedAt: map['deleted_at']?.let((it) => DateTime.fromMillisecondsSinceEpoch(it)),
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
