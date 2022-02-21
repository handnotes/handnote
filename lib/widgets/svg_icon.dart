import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.assetName, {
    Key? key,
    this.size = 24.0,
    this.color,
    this.semanticLabel,
  }) : super(key: key);

  final String assetName;
  final String? semanticLabel;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$assetName.svg',
      semanticsLabel: semanticLabel,
      width: size,
      height: size,
      color: color,
    );
  }
}
