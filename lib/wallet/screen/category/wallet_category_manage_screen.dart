import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handnote/constants/enums.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/wallet/model/wallet_category.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/wallet/screen/category/wallet_category_edit_screen.dart';
import 'package:handnote/wallet/utils/category_tree.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/radio_buttons.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletCategoryManageScreen extends HookConsumerWidget {
  const WalletCategoryManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final type = useState(WalletCategoryType.outcome);
    final theme = Theme.of(context);
    final categoryList = ref.watch(walletCategoryProvider).where((element) => element.type == type.value).toList();
    final categoryTree = useMemoized(() => WalletCategoryTree.fromList(categoryList), [categoryList]);

    useEffect(() {
      ref.read(walletCategoryProvider.notifier).getList();
    }, []);

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: RadioButtons(
            inverse: true,
            dense: true,
            textList: const ['支出分类', '收入分类'],
            selected: type.value.index,
            onSelected: (index) => type.value = WalletCategoryType.values[index],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categoryTree.children.length,
                itemBuilder: (context, index) {
                  final treeNode = categoryTree.children[index];
                  final iconColor = type.value == WalletCategoryType.outcome ? errorColor : successColor;
                  final isEnabled = treeNode.category.status == WalletCategoryStatus.enable;

                  return ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Container(
                      transform: Matrix4.translationValues(-12, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: isEnabled ? [
                          RoundIcon(Icon(treeNode.category.icon), color: treeNode.category.color),
                          const SizedBox(width: 16),
                          Text(treeNode.category.name),
                        ]:[
                          RoundIcon(Icon(treeNode.category.icon), color: Colors.black38),
                          const SizedBox(width: 16),
                          Text(treeNode.category.name, style: const TextStyle(color: Colors.black38)),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        switch (value) {
                          case MenuAction.edit:
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WalletCategoryEditScreen(treeNode.category),
                            ));
                            break;
                          case MenuAction.enable:
                            var newStatus = isEnabled ? WalletCategoryStatus.disable : WalletCategoryStatus.enable;
                            final updated = treeNode.category.copyWith(status: newStatus);
                            ref.read(walletCategoryProvider.notifier).update(updated);
                            break;
                          case MenuAction.delete:
                            // TODO: delete confirmation
                            ref.read(walletCategoryProvider.notifier).delete(treeNode.category);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: MenuAction.edit,
                          child: Text('编辑'),
                        ),
                        PopupMenuItem(
                          value: MenuAction.enable,
                          child: Text(isEnabled ? '停用' : '启用'),
                        ),
                        const PopupMenuItem(
                          value: MenuAction.delete,
                          child: Text('删除'),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        width: double.infinity,
                        color: theme.backgroundColor,
                        padding: const EdgeInsets.all(8),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 84,
                            childAspectRatio: 1,
                          ),
                          itemCount: treeNode.children.length + 1,
                          itemBuilder: (context, index) {
                            if (index == treeNode.children.length) {
                              return _buildAddSubCategory(context, treeNode.category);
                            } else {
                              final child = treeNode.children[index];
                              return _buildSubCategory(context, child, treeNode.category, iconColor);
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            _buildAddMainCategory(context, type),
          ],
        ),
      ),
    );
  }

  SizedBox _buildAddMainCategory(BuildContext context, ValueNotifier<WalletCategoryType> type) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: theme.backgroundColor, padding: const EdgeInsets.all(20)),
        child: Text('添加大类', style: theme.textTheme.subtitle1),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WalletCategoryEditScreen(
              WalletCategory(pid: 0, type: type.value),
            ),
          ));
        },
      ),
    );
  }

  Widget _buildSubCategory(
    BuildContext context,
    WalletCategoryTree child,
    WalletCategory parent,
    Color iconColor,
  ) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          top: -8,
          child: IconButton(
            icon: RoundIcon(
              Icon(child.category.icon),
              color: Color.alphaBlend(Colors.white.withAlpha(90), iconColor),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WalletCategoryEditScreen(child.category, parent: parent),
              ));
            },
          ),
        ),
        Positioned(
          bottom: 4,
          child: Text(child.category.name, style: TextStyle(color: theme.disabledColor)),
        ),
      ],
    );
  }

  Widget _buildAddSubCategory(BuildContext context, WalletCategory parent) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          top: -8,
          child: IconButton(
            icon: RoundIcon(Icon(Icons.plus_one, color: theme.disabledColor)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WalletCategoryEditScreen(
                  WalletCategory(pid: parent.id, type: parent.type, icon: parent.icon),
                  parent: parent,
                ),
              ));
            },
          ),
        ),
        Positioned(
          bottom: 4,
          child: Text('添加子类', style: TextStyle(color: theme.disabledColor)),
        ),
      ],
    );
  }
}
