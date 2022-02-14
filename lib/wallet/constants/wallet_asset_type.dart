import 'package:handnote/wallet/constants/wallet_asset_category.dart';
import 'package:handnote/wallet/model/wallet_asset.dart';

enum WalletAssetType {
  creditCard,
  debitCard,
  alipay,
  wechat,
  neteasePay,
  tenpay,
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

final walletAssetTypeList = <WalletAsset>[
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.creditCard, name: '信用卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.debitCard, name: '储蓄卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.cash, name: '现金'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.alipay, name: '支付宝'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.wechat, name: '微信支付'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.neteasePay, name: '网易支付'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.tenpay, name: '财付通'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.schoolCard, name: '校园卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.foodCard, name: '餐卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.busCard, name: '公交卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.shoppingCard, name: '购物卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.haircutCard, name: '理发卡'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.digitalAssets, name: '数字资产'),
  WalletAsset(category: WalletAssetCategory.fund, type: WalletAssetType.otherAsset, name: '其他资产'),
  // receivable
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.borrowOut, name: '借出'),
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.reimburse, name: '报销'),
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.owed, name: '欠款'),
  WalletAsset(category: WalletAssetCategory.receivable, type: WalletAssetType.otherReceivable, name: '其他应收'),
  // payable
  WalletAsset(category: WalletAssetCategory.payable, type: WalletAssetType.borrowIn, name: '借入'),
  WalletAsset(category: WalletAssetCategory.payable, type: WalletAssetType.loan, name: '贷款'),
  WalletAsset(category: WalletAssetCategory.payable, type: WalletAssetType.otherPayable, name: '其他应付'),
];
