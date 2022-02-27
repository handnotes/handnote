import 'package:handnote/database/common_data.dart';
import 'package:handnote/database/db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';

final logger = Logger('CommonDataProvider');

class CommonDataNotifier extends StateNotifier<CommonData> {
  CommonDataNotifier() : super({});

  static const tableName = 'common_data';

  Future<void> loadData() async {
    final db = await DB.shared.instance;
    final List<Map<String, Object?>> list = await db.query(tableName);
    state = {for (var e in list) CommonDataKey.values.byName(e['key'] as String): (e['value'] as String?)};
  }

  Future<void> save(CommonData commonData) async {
    final db = await DB.shared.instance;
    final batch = db.batch();
    for (var keyValue in commonData.entries) {
      batch.insert(
        tableName,
        {'key': keyValue.key.name, 'value': keyValue.value},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    state = {...state, ...commonData};
  }
}

final commonDataProvider = StateNotifierProvider<CommonDataNotifier, CommonData>((ref) => CommonDataNotifier());
