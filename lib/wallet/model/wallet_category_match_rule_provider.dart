import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import 'wallet_category_match_rule.dart';

final logger = Logger('WalletCategoryMatchRuleProvider');

class WalletCategoryMatchRuleNotifier extends StateNotifier<List<WalletCategoryMatchRule>> {
  WalletCategoryMatchRuleNotifier() : super([]);

  static const tableName = 'wallet_category_match_rule';

  Future<void> getList() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      orderBy: 'weight DESC, updatedAt DESC',
    );
    state = list.map((e) => WalletCategoryMatchRule.fromMap(e)).toList();
  }

  Future<void> add(WalletCategoryMatchRule rule) async {
    final db = await DB.shared.instance;
    final updated = rule.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
    await db.insert(tableName, updated.toMap());
    await getList();
  }

  Future<void> update(WalletCategoryMatchRule rule) async {
    final db = await DB.shared.instance;
    final updated = rule.copyWith(updatedAt: DateTime.now());
    await db.update(tableName, updated.toMap(), where: 'id = ?', whereArgs: [rule.id]);
    await getList();
  }
}

final walletCategoryMatchRuleProvider =
    StateNotifierProvider<WalletCategoryMatchRuleNotifier, List<WalletCategoryMatchRule>>(
        (ref) => WalletCategoryMatchRuleNotifier());
