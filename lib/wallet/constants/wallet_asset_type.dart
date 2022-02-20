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

const assetTypeNameMap = <WalletAssetType, String>{
  WalletAssetType.creditCard: '信用卡',
  WalletAssetType.debitCard: '储蓄卡',
  WalletAssetType.alipay: '支付宝',
  WalletAssetType.wechat: '微信钱包',
  WalletAssetType.neteasePay: '网易支付',
  WalletAssetType.tenpay: '财付通',
  WalletAssetType.cash: '现金钱包',
  WalletAssetType.schoolCard: '校园卡',
  WalletAssetType.busCard: '公交卡',
  WalletAssetType.foodCard: '餐卡',
  WalletAssetType.shoppingCard: '购物卡',
  WalletAssetType.haircutCard: '理发卡',
  WalletAssetType.digitalAssets: '数字资产',
  WalletAssetType.otherAsset: '其他资产',
  WalletAssetType.borrowOut: '借出',
  WalletAssetType.reimburse: '报销',
  WalletAssetType.owed: '项目欠款',
  WalletAssetType.otherReceivable: '其他收款',
  WalletAssetType.borrowIn: '借入',
  WalletAssetType.loan: '贷款',
  WalletAssetType.otherPayable: '其他付款',
};
