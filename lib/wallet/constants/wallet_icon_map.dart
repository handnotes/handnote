import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';

final Map<WalletAssetType, Widget> walletAssetTypeIconMap = {
  WalletAssetType.creditCard: const Icon(FontAwesome5Brands.cc_visa, color: Colors.orangeAccent, size: 20),
  WalletAssetType.debitCard: const Icon(FontAwesome5.credit_card, color: Colors.orangeAccent, size: 20),
  WalletAssetType.cash: const Icon(Icons.money, color: Colors.orangeAccent, size: 24),
  WalletAssetType.alipay: const Icon(FontAwesome5Brands.alipay, color: Colors.blue, size: 24),
  WalletAssetType.wechat: const Icon(FontAwesome5Brands.weixin, color: Colors.green, size: 22),
  WalletAssetType.neteasePay: Image.asset('assets/icons/netease_pay.png', width: 22, height: 22, color: Colors.red),
  WalletAssetType.tenpay: Image.asset('assets/icons/tenpay.png', width: 20, height: 20, color: Colors.orangeAccent),
  WalletAssetType.schoolCard: const Icon(Ionicons.school, color: Colors.orangeAccent, size: 24),
  WalletAssetType.busCard: const Icon(FontAwesome5Solid.bus, color: Colors.orangeAccent, size: 22),
  WalletAssetType.foodCard: const Icon(FontAwesome.cutlery, color: Colors.orangeAccent, size: 22),
  WalletAssetType.shoppingCard: const Icon(FontAwesome5Solid.shopping_cart, color: Colors.orangeAccent, size: 20),
  WalletAssetType.haircutCard: const Icon(Ionicons.cut, color: Colors.orangeAccent, size: 24),
  WalletAssetType.digitalAssets: const Icon(FontAwesome.bitcoin, color: Colors.orangeAccent, size: 24),
  WalletAssetType.otherAsset: const Icon(FontAwesome5Solid.money_check_alt, color: Colors.orangeAccent, size: 18),
  // receivable
  WalletAssetType.borrowOut: const Icon(FontAwesome5Solid.sign_out_alt, color: Colors.green, size: 20),
  WalletAssetType.reimburse: const Icon(Ionicons.receipt, color: Colors.green, size: 20),
  WalletAssetType.owed: const Icon(FontAwesome5Solid.file_invoice_dollar, color: Colors.green, size: 20),
  WalletAssetType.otherReceivable: const Icon(FontAwesome5Solid.sign_out_alt, color: Colors.green, size: 20),
  // payable
  WalletAssetType.borrowIn: const Icon(FontAwesome5Solid.sign_in_alt, color: Colors.blue, size: 20),
  WalletAssetType.loan: const Icon(MaterialCommunityIcons.bank_transfer_out, color: Colors.blue, size: 24),
  WalletAssetType.otherPayable: const Icon(FontAwesome5Solid.sign_in_alt, color: Colors.blue, size: 20),
};
