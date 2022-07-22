import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import 'wallet_book.dart';

final logger = Logger('WalletBookProvider');

class WalletBookNotifier extends StateNotifier<List<WalletBook>> {
  WalletBookNotifier() : super([]);

  static const tableName = 'wallet_book';

  Future<void> getList() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      orderBy: 'sort DESC',
      where: 'deleted_at is null',
    );
    state = list.map((e) => WalletBook.fromMap(e)).toList();
  }

  Future<void> add(WalletBook book) async {
    final db = await DB.shared.instance;
    final updated = book.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
    await db.insert(tableName, updated.toMap());
    await getList();
  }

  Future<void> update(WalletBook book) async {
    final db = await DB.shared.instance;
    final updated = book.copyWith(updatedAt: DateTime.now());
    await db.update(tableName, updated.toMap(), where: 'id = ?', whereArgs: [book.id]);
    await getList();
  }

  Future<void> delete(WalletBook book) async {
    var updated = book.copyWith(deletedAt: DateTime.now());
    await update(updated);
  }
}

final walletBookProvider =
    StateNotifierProvider<WalletBookNotifier, List<WalletBook>>((ref) => WalletBookNotifier());
