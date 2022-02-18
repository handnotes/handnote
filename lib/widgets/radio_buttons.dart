import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RadioButtons extends HookWidget {
  const RadioButtons({
    Key? key,
    required this.textList,
    this.selected = 0,
    this.onSelected,
  }) : super(key: key);

  final List<String> textList;
  final int selected;
  final ValueChanged<int>? onSelected;

  List<bool> getMenuStatus(int selected) => List.generate(textList.length, (index) => selected == index);

  @override
  Widget build(BuildContext context) {
    final isSelected = getMenuStatus(selected);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(builder: (context, constraints) {
        return ToggleButtons(
          children: textList.map((text) => Text(text)).toList(),
          constraints: BoxConstraints.expand(
            width: (constraints.maxWidth - textList.length - 1) / textList.length,
            height: 32,
          ),
          isSelected: isSelected,
          borderRadius: BorderRadius.circular(4),
          borderColor: theme.colorScheme.primary,
          selectedBorderColor: theme.colorScheme.primary,
          fillColor: theme.colorScheme.primary,
          selectedColor: theme.colorScheme.onPrimaryContainer,
          color: theme.colorScheme.primary,
          onPressed: (index) {
            if (onSelected != null) {
              onSelected!(index);
            }
          },
        );
      }),
    );
  }
}
