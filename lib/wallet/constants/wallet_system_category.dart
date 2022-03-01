enum WalletSystemCategory {
  adjustBalance,
  refund,
  interestIncome,
}

const Map<WalletSystemCategory, int> walletSystemCategoryIdMap = {
  WalletSystemCategory.adjustBalance: -1,
  WalletSystemCategory.interestIncome: 52,
  WalletSystemCategory.refund: 56,
};
