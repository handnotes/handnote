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
  }) : super(key: key);

  final List<String> textList;
  final int selected;
  final ValueChanged<int>? onSelected;
  final bool inverse;
  final bool dense;

  List<bool> getMenuStatus(int selected) => List.generate(textList.length, (index) => selected == index);

  @override
  Widget build(BuildContext context) {
    final isSelected = getMenuStatus(selected);
    final theme = Theme.of(context);

    final primary = inverse ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.primary;
    final primaryContainer = inverse ? theme.colorScheme.primary : theme.colorScheme.onPrimaryContainer;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(builder: (context, constraints) {
        final double height = dense ? 28 : 32;
        final double minWidth = dense ? 0.0 : (constraints.maxWidth - textList.length - 1) / textList.length;

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
          borderColor: primary,
          selectedBorderColor: primary,
          fillColor: primary,
          selectedColor: primaryContainer,
          color: primary,
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
