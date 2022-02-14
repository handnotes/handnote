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
