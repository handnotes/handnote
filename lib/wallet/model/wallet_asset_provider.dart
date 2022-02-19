import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'wallet_asset.dart';

class WalletAssetNotifier extends StateNotifier<List<WalletAsset>> {
  WalletAssetNotifier() : super([]);

  static const tableName = 'wallet_asset';

  Future<void> getHomeScreenList() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      orderBy: 'created_at DESC',
      where: 'deleted_at is null and show_in_home_page = 1',
    );
    state = list.map((e) => WalletAsset.fromMap(e)).toList();
  }

  Future<void> add(WalletAsset asset) async {
    final db = await DB.shared.instance;
    await db.insert(tableName, asset.toMap());
    state = [asset, ...state];
  }

  Future<void> update(WalletAsset asset) async {
    final db = await DB.shared.instance;
    await db.update(tableName, asset.toMap(), where: 'id = ?', whereArgs: [asset.id]);
    await getHomeScreenList();
  }

  Future<void> delete(WalletAsset asset) async {
    var updated = asset.copyWith(deletedAt: DateTime.now());
    await update(updated);
  }

  Future<void> hide(WalletAsset asset) async {
    var updated = asset.copyWith(showInHomePage: false);
    await update(updated);
  }
}

final walletAssetProvider =
    StateNotifierProvider<WalletAssetNotifier, List<WalletAsset>>((ref) => WalletAssetNotifier());
