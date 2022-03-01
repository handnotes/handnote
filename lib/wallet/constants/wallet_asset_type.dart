enum WalletAssetType {
  debitCard,
  alipay,
  wechat,
  jd,
  neteasePay,
  tenpay,
  meituan,
  cash,
  schoolCard,
  busCard,
  foodCard,
  shoppingCard,
  haircutCard,
  digitalAssets, // steam, ethereum, digitalYuan, etc.
  otherAsset,

  // Credit account
  creditCard,
  huabei,
  baitiao,
  otherCredit,

  // Receivable
  borrowOut,
  reimburse,
  otherReceivable,

  // Payable
  borrowIn,
  loan,
  jiebei,
  jintiao,
  otherPayable,
}

var walletAssetTypeOthers = [
  WalletAssetType.otherAsset,
  WalletAssetType.otherCredit,
  WalletAssetType.otherPayable,
  WalletAssetType.otherReceivable
];

const assetTypeNameMap = <WalletAssetType, String>{
  WalletAssetType.debitCard: '储蓄卡',
  WalletAssetType.digitalAssets: '数字资产',
  WalletAssetType.alipay: '支付宝',
  WalletAssetType.wechat: '微信钱包',
  WalletAssetType.jd: '京东钱包',
  WalletAssetType.meituan: '美团钱包',
  WalletAssetType.cash: '现金钱包',
  WalletAssetType.schoolCard: '校园卡',
  WalletAssetType.busCard: '公交卡',
  WalletAssetType.foodCard: '餐卡',
  WalletAssetType.shoppingCard: '购物卡',
  WalletAssetType.haircutCard: '理发卡',
  WalletAssetType.otherAsset: '其他资产',
  // Credit account
  WalletAssetType.creditCard: '信用卡',
  WalletAssetType.huabei: '蚂蚁花呗',
  WalletAssetType.baitiao: '京东白条',
  // Receivable
  WalletAssetType.borrowOut: '借出',
  WalletAssetType.reimburse: '报销',
  WalletAssetType.otherReceivable: '其他应收',
  // Payable
  WalletAssetType.borrowIn: '借入',
  WalletAssetType.loan: '贷款',
  WalletAssetType.jiebei: '蚂蚁借呗',
  WalletAssetType.jintiao: '京东金条',
  WalletAssetType.otherPayable: '其他应付',
};
