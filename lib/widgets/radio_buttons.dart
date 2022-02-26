import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RadioButtons extends HookWidget {
  const RadioButtons({
    Key? key,
    required this.textList,
    this.selected = 0,
    this.onSelected,
    this.inverse = false,
    this.dense = false,
    this.childMinSize = 0,
  }) : super(key: key);

  final List<String> textList;
  final int selected;
  final ValueChanged<int>? onSelected;
  final bool inverse;
  final bool dense;
  final double childMinSize;

  List<bool> getMenuStatus(int selected) => List.generate(textList.length, (index) => selected == index);

  @override
  Widget build(BuildContext context) {
    final isSelected = getMenuStatus(selected);
    final theme = Theme.of(context);

    final primaryContainer = inverse ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.primaryContainer;
    final onPrimaryContainer = inverse ? theme.colorScheme.primaryContainer : theme.colorScheme.onPrimaryContainer;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(builder: (context, constraints) {
        final double height = dense ? 28 : 32;
        final double minWidth = dense ? childMinSize : (constraints.maxWidth - textList.length - 1) / textList.length;

        return ToggleButtons(
          children: textList.map((text) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(text),
            );
          }).toList(),
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: (constraints.maxWidth - textList.length - 1) / textList.length,
            minHeight: height,
            maxHeight: height,
          ),
          isSelected: isSelected,
          borderRadius: BorderRadius.circular(4),
          borderColor: primaryContainer,
          selectedBorderColor: primaryContainer,
          fillColor: primaryContainer,
          selectedColor: onPrimaryContainer,
          color: primaryContainer,
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
