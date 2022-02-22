import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import 'wallet_bill.dart';

final logger = Logger('WalletBillProvider');

class WalletBillNotifier extends StateNotifier<List<WalletBill>> {
  WalletBillNotifier() : super([]);

  static const tableName = 'wallet_bill';

  Future<void> getList() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(
      tableName,
      orderBy: 'sort DESC',
      where: 'deleted_at is null',
    );
    state = list.map((e) => WalletBill.fromMap(e)).toList();
  }

  Future<void> add(WalletBill bill) async {
    final db = await DB.shared.instance;
    final updated = bill.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
    await db.insert(tableName, updated.toMap());
    await getList();
  }

  Future<void> update(WalletBill bill) async {
    final db = await DB.shared.instance;
    final updated = bill.copyWith(updatedAt: DateTime.now());
    await db.update(tableName, updated.toMap(), where: 'id = ?', whereArgs: [bill.id]);
    await getList();
  }

  Future<void> delete(WalletBill bill) async {
    var updated = bill.copyWith(deletedAt: DateTime.now());
    await update(updated);
  }
}

final walletBillProvider = StateNotifierProvider<WalletBillNotifier, List<WalletBill>>((ref) => WalletBillNotifier());
