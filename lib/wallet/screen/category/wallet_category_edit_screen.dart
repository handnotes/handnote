import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:handnote/constants/icons.dart';
import 'package:handnote/theme.dart';
import 'package:handnote/wallet/model/wallet_category.dart';
import 'package:handnote/wallet/model/wallet_category_provider.dart';
import 'package:handnote/widgets/page_container.dart';
import 'package:handnote/widgets/round_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletCategoryEditScreen extends HookConsumerWidget {
  const WalletCategoryEditScreen(this.category, {Key? key, this.parent}) : super(key: key);

  final WalletCategory category;
  final WalletCategory? parent;

  bool get isEdit => category.id != null;

  bool get isTopLevel => parent == null;

  bool get isOutcome => category.type == WalletCategoryType.outcome;

  Color get iconColor => isOutcome ? errorColor : successColor;

  static const defaultIcon = Icons.category;

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final icon = useState<IconData?>(category.icon ?? defaultIcon);
    final name = useState<String>(category.name);

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${isEdit ? '编辑' : '新建'}${isOutcome ? '支出' : '收入'}${isTopLevel ? '大类' : '小类'}'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (parent != null)
              Container(
                padding: const EdgeInsets.all(16),
                child: Text('大类名称: ${parent!.name}'),
              ),
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.colorScheme.surface,
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 64,
                    child: IconButton(
                      icon: RoundIcon(
                        Icon(
                          icon.value ?? defaultIcon,
                          semanticLabel: 'Change icon',
                          color: iconColor,
                          size: 32,
                        ),
                        size: 48,
                      ),
                      onPressed: () async {
                        final size = MediaQuery.of(context).size;
                        icon.value = await FlutterIconPicker.showIconPicker(
                          context,
                          title: const Text('选择图标'),
                          searchHintText: '搜索图标 (只支持英文)',
                          noResultsText: '没有找到',
                          closeChild: const Text('关闭'),
                          iconColor: Colors.blueGrey,
                          constraints: BoxConstraints(
                            minHeight: 300,
                            maxHeight: size.height - 300,
                            minWidth: 450,
                            maxWidth: 640,
                          ),
                          iconPackModes: [],
                          customIconPack: iconPack,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: isTopLevel ? '大类名称' : '小类名称',
                        border: InputBorder.none,
                      ),
                      initialValue: category.name,
                      onChanged: (value) => name.value = value,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('保存', style: TextStyle(color: theme.colorScheme.onSecondaryContainer)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(24),
                    primary: theme.colorScheme.secondary,
                  ),
                  onPressed: () async {
                    if (isEdit) {
                      final updated = category.copyWith(
                        name: name.value,
                        icon: icon.value,
                      );
                      ref.read(walletCategoryProvider.notifier).update(updated);
                    } else {
                      final updated = category.copyWith(
                        pid: parent?.id ?? category.pid,
                        name: name.value,
                        icon: icon.value,
                      );
                      ref.read(walletCategoryProvider.notifier).add(updated);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
