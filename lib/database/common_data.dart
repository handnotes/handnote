enum CommonDataKey {
  walletLatest30dOutcome,
  walletLatest30dIncome,
}

typedef CommonData = Map<CommonDataKey, String?>;

extension CommonDataProperty on CommonData {
  double get walletLatest30dOutcome => double.tryParse(this[CommonDataKey.walletLatest30dOutcome] ?? '') ?? 0;

  double get walletLatest30dIncome => double.tryParse(this[CommonDataKey.walletLatest30dIncome] ?? '') ?? 0;
}
