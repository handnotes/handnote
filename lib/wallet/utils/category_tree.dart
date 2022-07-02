import 'package:collection/collection.dart';
import 'package:handnote/wallet/model/wallet_category.dart';

class WalletCategoryTree {
  const WalletCategoryTree({
    required this.id,
    required this.pid,
    required this.category,
    required this.children,
  });

  final int id;
  final int? pid;
  final WalletCategory category;
  final List<WalletCategoryTree> children;

  factory WalletCategoryTree.fromList(List<WalletCategory> categoryList) {
    final groupMap = groupBy(categoryList, (WalletCategory category) => category.pid);

    WalletCategoryTree _fromList(WalletCategory node) {
      final children = (groupMap[node.id] ?? []).sorted((a, b) => a.status.index.compareTo(b.status.index));
      return WalletCategoryTree(
        id: node.id!,
        pid: node.pid,
        category: node,
        children: children.map((WalletCategory child) => _fromList(child)).toList(),
      );
    }

    final List<WalletCategoryTree> children =
        groupMap[0]?.map((WalletCategory category) => _fromList(category)).toList() ?? [];

    return WalletCategoryTree(id: 0, pid: null, category: WalletCategory.root(), children: children);
  }

  @override
  String toString() {
    return 'WalletCategoryTree(id: $id, pid: $pid, name: ${category.name}, children: $children)';
  }
}
