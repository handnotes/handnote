enum WalletSystemCategory {
  adjustBalance,
  refund,
  interestIncome,
  otherOutcome,
  otherIncome,
}

const Map<WalletSystemCategory, int> walletSystemCategoryIdMap = {
  WalletSystemCategory.adjustBalance: -1,
  WalletSystemCategory.interestIncome: 52,
  WalletSystemCategory.refund: 56,
  WalletSystemCategory.otherOutcome: 49,
  WalletSystemCategory.otherIncome: 99,
};
