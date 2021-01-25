
import 'package:demo_desktop/common/constant.dart';
import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  final bool isVertical;
  final double size;
  final Color color;
  CustomLine({
    this.isVertical = true,
    this.size = 1, this.color,
  }) : assert(isVertical != null && size != null);

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Container(color: color??bigStone08Color, height: size)
        : Container(color: color?? bigStone08Color, width: size);
  }
}
