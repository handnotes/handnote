import 'package:flutter/material.dart';
import 'package:handnote/widgets/svg_icon.dart';

const defaultIconSize = 24.0;

class RoundIcon extends StatelessWidget {
  const RoundIcon(
    this.icon, {
    Key? key,
    this.size = 36,
    this.color = Colors.blueGrey,
  }) : super(key: key);

  final Widget? icon;
  final double? size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Widget? whiteIcon;
    final icon = this.icon;
    final Color color;

    if (icon is Icon) {
      whiteIcon = Icon(icon.icon, color: Colors.white, size: icon.size ?? defaultIconSize);
      color = icon.color ?? this.color;
    } else if (icon is Image) {
      whiteIcon =
          Image(image: icon.image, width: icon.width ?? defaultIconSize, height: icon.height ?? defaultIconSize);
      color = icon.color ?? this.color;
    } else if (icon is SvgIcon) {
      whiteIcon = SvgIcon(icon.assetName, color: Colors.white, size: icon.size ?? defaultIconSize);
      color = icon.color ?? this.color;
    } else {
      whiteIcon = icon;
      color = this.color;
    }

    return Material(
      clipBehavior: Clip.antiAlias,
      shape: const CircleBorder(),
      color: color,
      child: SizedBox(
        height: size,
        width: size,
        child: whiteIcon,
      ),
    );
  }
}
