import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'wallet_asset.dart';

class WalletAssetNotifier extends StateNotifier<List<WalletAsset>> {
  WalletAssetNotifier() : super([]);

  static const tableName = 'wallet_asset';

  void getList() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      orderBy: 'created_at DESC',
    );
    state = list.map((e) => WalletAsset.fromMap(e)).toList();
  }

  void add(WalletAsset asset) async {
    final db = await DB.shared.instance;
    await db.insert(tableName, asset.toMap());
    state.add(asset);
  }
}

final walletAssetProvider =
    StateNotifierProvider<WalletAssetNotifier, List<WalletAsset>>((ref) => WalletAssetNotifier());
