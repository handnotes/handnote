import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final expandedMap = useState(<int, bool>{});

    useEffect(() {
      ref.read(walletCategoryProvider.notifier).getList();
      return null;
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, semanticLabel: 'Back'),
            onPressed: Navigator.of(context).pop,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categoryTree.children.length,
                itemBuilder: (context, index) {
                  final treeNode = categoryTree.children[index];
                  final bool displayChildren = expandedMap.value[treeNode.category.id] ?? false;
                  final iconColor = type.value == WalletCategoryType.outcome ? Colors.red[300]! : Colors.green[300]!;

                  return Column(
                    children: [
                      ListTile(
                        visualDensity: VisualDensity.standard,
                        leading: Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(displayChildren ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right),
                            RoundIcon(Icon(treeNode.category.icon), color: iconColor),
                          ],
                        ),
                        title: Text(treeNode.category.name),
                        onTap: () {
                          expandedMap.value = {...expandedMap.value, treeNode.id: !(displayChildren)};
                        },
                      ),
                      if (displayChildren)
                        Container(
                          width: double.infinity,
                          color: theme.backgroundColor,
                          padding: const EdgeInsets.all(8),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 104,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
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
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: theme.backgroundColor),
        child: Text(
          '添加大类',
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: theme.textTheme.subtitle1?.fontSize,
          ),
        ),
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

  Column _buildSubCategory(
    BuildContext context,
    WalletCategoryTree child,
    WalletCategory parent,
    Color iconColor,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: 64,
          width: 64,
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
        Text(child.category.name, style: TextStyle(color: theme.disabledColor)),
      ],
    );
  }

  Column _buildAddSubCategory(BuildContext context, WalletCategory parent) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: 64,
          width: 64,
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.disabledColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.plus_one, color: theme.disabledColor, size: 22),
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
        ),
        Text('添加子类', style: TextStyle(color: theme.disabledColor)),
      ],
    );
  }
}
