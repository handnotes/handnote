import 'package:flutter/material.dart';

enum WalletAssetType {
  creditCard,
  debitCard,
  alipay,
  wechat,
  cash,
  livingCard, // school, bus, food, shopping, etc.
  haircutCard,
  digitalAssets, // steam, ethereum, digitalYuan, etc.
  otherAsset,

  // Receivable
  borrowOut,
  reimburse,
  otherReceivable,

  // Payable
  borrowIn,
  loan,
  otherPayable,
}

final Map<WalletAssetType, Icon> _iconMap = {
  WalletAssetType.creditCard: const Icon(Icons.credit_card),
  WalletAssetType.debitCard: const Icon(Icons.credit_card),
  WalletAssetType.alipay: const Icon(Icons.payment),
  WalletAssetType.wechat: const Icon(Icons.payment),
  WalletAssetType.cash: const Icon(Icons.attach_money),
  WalletAssetType.livingCard: const Icon(Icons.home),
  WalletAssetType.haircutCard: const Icon(Icons.local_bar),
  WalletAssetType.digitalAssets: const Icon(Icons.payment),
  WalletAssetType.otherAsset: const Icon(Icons.payment),
  WalletAssetType.borrowOut: const Icon(Icons.input),
  WalletAssetType.reimburse: const Icon(Icons.input),
  WalletAssetType.otherReceivable: const Icon(Icons.input),
  WalletAssetType.borrowIn: const Icon(Icons.money_off),
  WalletAssetType.loan: const Icon(Icons.money_off),
  WalletAssetType.otherPayable: const Icon(Icons.money_off),
};

Icon walletAssetTypeIcon(WalletAssetType type) => _iconMap[type]!;
