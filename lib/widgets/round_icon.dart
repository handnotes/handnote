import 'package:flutter/material.dart';

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
      whiteIcon = Icon(icon.icon, color: Colors.white, size: icon.size);
      color = icon.color ?? this.color;
    } else if (icon is Image) {
      whiteIcon = Image(image: icon.image, width: icon.width, height: icon.height);
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
