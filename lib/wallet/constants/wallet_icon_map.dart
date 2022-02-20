import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:handnote/wallet/constants/wallet_asset_type.dart';
import 'package:handnote/widgets/svg_icon.dart';

final Map<WalletAssetType, Widget> walletAssetTypeIconMap = {
  WalletAssetType.creditCard: Icon(FontAwesome5Brands.cc_visa, color: Colors.orange[300], size: 20),
  WalletAssetType.debitCard: Icon(FontAwesome5.credit_card, color: Colors.orange[300], size: 20),
  WalletAssetType.cash: Icon(Icons.money, color: Colors.orange[300], size: 24),
  WalletAssetType.alipay: Icon(FontAwesome5Brands.alipay, color: Colors.blue[300], size: 24),
  WalletAssetType.wechat: Icon(FontAwesome5Brands.weixin, color: Colors.green[300], size: 22),
  WalletAssetType.neteasePay: SvgIcon('netease_pay', color: Colors.red[300]),
  WalletAssetType.tenpay: SvgIcon('tenpay', color: Colors.orange[300]),
  WalletAssetType.meituan: SvgIcon('meituan', color: Colors.orange[300]),
  WalletAssetType.jd: SvgIcon('jd', color: Colors.red[300], size: 20),
  WalletAssetType.schoolCard: Icon(Ionicons.school, color: Colors.orange[300], size: 24),
  WalletAssetType.busCard: Icon(FontAwesome5Solid.bus, color: Colors.orange[300], size: 22),
  WalletAssetType.foodCard: Icon(FontAwesome.cutlery, color: Colors.orange[300], size: 22),
  WalletAssetType.shoppingCard: Icon(FontAwesome5Solid.shopping_cart, color: Colors.orange[300], size: 20),
  WalletAssetType.haircutCard: Icon(Ionicons.cut, color: Colors.orange[300], size: 26),
  WalletAssetType.digitalAssets: Icon(FontAwesome.bitcoin, color: Colors.orange[300], size: 26),
  WalletAssetType.otherAsset: Icon(FontAwesome5Solid.money_check_alt, color: Colors.orange[300], size: 18),
  // receivable
  WalletAssetType.borrowOut: SvgIcon('borrow_out', color: Colors.green[300], size: 22),
  WalletAssetType.reimburse: Icon(Ionicons.receipt, color: Colors.green[300], size: 22),
  WalletAssetType.otherReceivable: Icon(FontAwesome5Solid.sign_in_alt, color: Colors.green[300], size: 22),
  // payable
  WalletAssetType.borrowIn: SvgIcon('borrow_in', color: Colors.blue[300], size: 22),
  WalletAssetType.loan: SvgIcon('loan', color: Colors.blue[300], size: 30),
  WalletAssetType.jiebei: SvgIcon('jiebei', size: 24, color: Colors.blue[300]),
  WalletAssetType.otherPayable: Icon(FontAwesome5Solid.sign_out_alt, color: Colors.blue[300], size: 22),
};
