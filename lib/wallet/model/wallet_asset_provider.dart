import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import 'wallet_asset.dart';

final logger = Logger('WalletAssetProvider');

class WalletAssetNotifier extends StateNotifier<List<WalletAsset>> {
  WalletAssetNotifier() : super([]);

  static const tableName = 'wallet_asset';

  Future<void> loadData() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      orderBy: 'created_at DESC',
      where: 'deleted_at is null',
    );
    state = list.map((e) => WalletAsset.fromMap(e)).toList();
  }

  Future<WalletAsset?> getOne(int id) async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (list.isEmpty) return null;

    assert(list.length == 1);
    return WalletAsset.fromMap(list[0]);
  }

  Future<WalletAsset> add(WalletAsset asset) async {
    final db = await DB.shared.instance;
    WalletAsset updated = asset.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
    final id = await db.insert(tableName, updated.toMap());
    final added = await getOne(id);
    assert(added is WalletAsset);
    state = [added!, ...state];
    return added;
  }

  Future<WalletAsset> update(WalletAsset asset) async {
    final db = await DB.shared.instance;
    WalletAsset updated = asset.copyWith(updatedAt: DateTime.now());
    await db.update(tableName, updated.toMap(), where: 'id = ?', whereArgs: [asset.id]);
    updated = (await getOne(asset.id!))!;
    state = state.map((e) => e.id == updated.id ? updated : e).toList();
    return updated;
  }

  Future<void> delete(WalletAsset asset) async {
    final db = await DB.shared.instance;
    var updated = asset.copyWith(deletedAt: DateTime.now());
    await db.update(tableName, updated.toMap(), where: 'id = ?', whereArgs: [asset.id]);
    state = state.where((e) => e.id != updated.id).toList();
  }

  Future<void> hide(WalletAsset asset) async {
    var updated = asset.copyWith(showInHomePage: false);
    await update(updated);
  }
}

final walletAssetProvider =
    StateNotifierProvider<WalletAssetNotifier, List<WalletAsset>>((ref) => WalletAssetNotifier());
