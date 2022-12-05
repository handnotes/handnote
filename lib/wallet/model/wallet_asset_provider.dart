import 'package:handnote/database/db.dart';
import 'package:handnote/wallet/constants/wallet_system_category.dart';
import 'package:handnote/wallet/model/wallet_bill_provider.dart';
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

    for (var asset in [...state]) {
      reloadBalance(asset.id, originalBalance: asset.balance);
    }
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

  Future<double> reloadBalance(int? assetId, {double? originalBalance}) async {
    if (assetId == null || assetId <= 0) return 0;
    final db = await DB.shared.instance;
    final balance = await _queryBalance(assetId);
    if (balance == originalBalance) return balance;
    await db.update(
      tableName,
      {'balance': balance},
      where: 'id = ?',
      whereArgs: [assetId],
    );
    state = state.map((e) => e.id == assetId ? e.copyWith(balance: balance) : e).toList();
    return balance;
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

  Future<DateTime?> _queryLatestAdjustBalanceDate(int assetId) async {
    final db = await DB.shared.instance;
    final adjustBalanceCategoryId = walletSystemCategoryIdMap[WalletSystemCategory.adjustBalance];
    final list = await db.query(
      WalletBillNotifier.tableName,
      where: 'category = $adjustBalanceCategoryId and in_assets = ? and deleted_at is null',
      whereArgs: [assetId],
      orderBy: 'time DESC',
      limit: 1,
    );
    return list.isEmpty ? null : DateTime.parse(list.first['time'] as String).toLocal();
  }

  Future<double> _queryBalance(int assetId) async {
    final db = await DB.shared.instance;
    final fromDate = (await _queryLatestAdjustBalanceDate(assetId)) ?? DateTime.fromMillisecondsSinceEpoch(0);

    var result = await db.rawQuery("""select SUM(out_amount) as total from ${WalletBillNotifier.tableName} 
           where out_assets = ? 
             and datetime(time) >= datetime('$fromDate') 
             and deleted_at is null""", [assetId]);
    final double outAmount = double.tryParse('${result.first['total']}') ?? 0;

    result = await db.rawQuery("""select SUM(in_amount) as total from ${WalletBillNotifier.tableName} 
        where in_assets = ? 
          and datetime(time) >= datetime('$fromDate') 
          and deleted_at is null""", [assetId]);
    final inAmount = double.tryParse('${result.first['total']}') ?? 0;

    return double.tryParse((inAmount - outAmount).toStringAsFixed(2)) ?? 0;
  }
}

final walletAssetProvider =
    StateNotifierProvider<WalletAssetNotifier, List<WalletAsset>>((ref) => WalletAssetNotifier());
