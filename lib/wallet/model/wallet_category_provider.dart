import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import 'wallet_category.dart';

final logger = Logger('WalletCategoryProvider');

class WalletCategoryNotifier extends StateNotifier<List<WalletCategory>> {
  WalletCategoryNotifier() : super([]);

  static const tableName = 'wallet_category';

  Future<void> getList() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      orderBy: 'sort DESC',
      where: 'deletedAt is null',
    );
    state = list.map((e) => WalletCategory.fromMap(e)).toList();
  }

  Future<void> add(WalletCategory category) async {
    final db = await DB.shared.instance;
    final updated = category.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
    await db.insert(tableName, updated.toMap());
    await getList();
  }

  Future<void> update(WalletCategory category) async {
    final db = await DB.shared.instance;
    final updated = category.copyWith(updatedAt: DateTime.now());
    await db.update(tableName, updated.toMap(), where: 'id = ?', whereArgs: [category.id]);
    await getList();
  }

  Future<void> delete(WalletCategory category) async {
    var updated = category.copyWith(deletedAt: DateTime.now());
    await update(updated);
  }
}

final walletCategoryProvider =
    StateNotifierProvider<WalletCategoryNotifier, List<WalletCategory>>((ref) => WalletCategoryNotifier());
