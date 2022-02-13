import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:handnote/utils/pair.dart';

enum WalletAssetType {
  creditCard,
  debitCard,
  alipay,
  wechat,
  cash,
  schoolCard,
  busCard,
  foodCard,
  shoppingCard,
  haircutCard,
  digitalAssets, // steam, ethereum, digitalYuan, etc.
  otherAsset,

  // Receivable
  borrowOut,
  reimburse,
  owed,
  otherReceivable,

  // Payable
  borrowIn,
  loan,
  otherPayable,
}

final Map<WalletAssetType, Pair<IconData, Color?>> _iconMap = {
  WalletAssetType.creditCard: const Pair(FontAwesome5Brands.cc_visa, null),
  WalletAssetType.debitCard: const Pair(FontAwesome5.credit_card, null),
  WalletAssetType.alipay: const Pair(FontAwesome5Brands.alipay, Colors.blue),
  WalletAssetType.wechat: const Pair(FontAwesome5Brands.weixin, Colors.green),
  WalletAssetType.cash: const Pair(FontAwesome5.money_bill_alt, null),
  WalletAssetType.schoolCard: const Pair(FontAwesome.graduation_cap, null),
  WalletAssetType.busCard: const Pair(FontAwesome5Solid.bus, null),
  WalletAssetType.foodCard: const Pair(FontAwesome5Solid.utensils, null),
  WalletAssetType.shoppingCard: const Pair(FontAwesome5Solid.shopping_cart, null),
  WalletAssetType.haircutCard: const Pair(FontAwesome5Solid.cut, null),
  WalletAssetType.digitalAssets: const Pair(FontAwesome5Brands.bitcoin, null),
  WalletAssetType.otherAsset: const Pair(FontAwesome5Solid.money_check_alt, null),
  WalletAssetType.borrowOut: const Pair(FontAwesome.sign_out, null),
  WalletAssetType.reimburse: const Pair(Ionicons.receipt_outline, null),
  WalletAssetType.owed: const Pair(FontAwesome5Solid.file_invoice_dollar, null),
  WalletAssetType.otherReceivable: const Pair(FontAwesome.sign_out, null),
  WalletAssetType.borrowIn: const Pair(FontAwesome.sign_in, null),
  WalletAssetType.loan: const Pair(MaterialCommunityIcons.bank_transfer_out, null),
  WalletAssetType.otherPayable: const Pair(FontAwesome.sign_in, null),
};

Pair<IconData, Color?> walletAssetTypeIcon(WalletAssetType type) => _iconMap[type]!;