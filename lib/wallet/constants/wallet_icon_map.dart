import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';

final Map<WalletAssetType, Widget> walletAssetTypeIconMap = {
  WalletAssetType.creditCard: Icon(FontAwesome5Brands.cc_visa, color: Colors.orangeAccent[100], size: 20),
  WalletAssetType.debitCard: Icon(FontAwesome5.credit_card, color: Colors.orangeAccent[100], size: 20),
  WalletAssetType.cash: Icon(Icons.money, color: Colors.orangeAccent[100], size: 24),
  WalletAssetType.alipay: Icon(FontAwesome5Brands.alipay, color: Colors.blue[300], size: 24),
  WalletAssetType.wechat: Icon(FontAwesome5Brands.weixin, color: Colors.green[300], size: 22),
  WalletAssetType.neteasePay:
      Image.asset('assets/icons/netease_pay.png', width: 22, height: 22, color: Colors.red[300]),
  WalletAssetType.tenpay:
      Image.asset('assets/icons/tenpay.png', width: 20, height: 20, color: Colors.orangeAccent[100]),
  WalletAssetType.schoolCard: Icon(Ionicons.school, color: Colors.orangeAccent[100], size: 24),
  WalletAssetType.busCard: Icon(FontAwesome5Solid.bus, color: Colors.orangeAccent[100], size: 22),
  WalletAssetType.foodCard: Icon(FontAwesome.cutlery, color: Colors.orangeAccent[100], size: 22),
  WalletAssetType.shoppingCard: Icon(FontAwesome5Solid.shopping_cart, color: Colors.orangeAccent[100], size: 20),
  WalletAssetType.haircutCard: Icon(Ionicons.cut, color: Colors.orangeAccent[100], size: 24),
  WalletAssetType.digitalAssets: Icon(FontAwesome.bitcoin, color: Colors.orangeAccent[100], size: 24),
  WalletAssetType.otherAsset: Icon(FontAwesome5Solid.money_check_alt, color: Colors.orangeAccent[100], size: 18),
  // receivable
  WalletAssetType.borrowOut: Icon(FontAwesome5Solid.sign_out_alt, color: Colors.green[300], size: 20),
  WalletAssetType.reimburse: Icon(Ionicons.receipt, color: Colors.green[300], size: 20),
  WalletAssetType.owed: Icon(FontAwesome5Solid.file_invoice_dollar, color: Colors.green[300], size: 20),
  WalletAssetType.otherReceivable: Icon(FontAwesome5Solid.sign_out_alt, color: Colors.green[300], size: 20),
  // payable
  WalletAssetType.borrowIn: Icon(FontAwesome5Solid.sign_in_alt, color: Colors.blue[300], size: 20),
  WalletAssetType.loan: Icon(MaterialCommunityIcons.bank_transfer_out, color: Colors.blue[300], size: 24),
  WalletAssetType.otherPayable: Icon(FontAwesome5Solid.sign_in_alt, color: Colors.blue[300], size: 20),
};
