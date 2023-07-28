import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';

class PixelContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color color;
  const PixelContainer(
      {super.key,
      this.child = const SizedBox.shrink(),
      this.color = primaryYellowLighter,
      this.padding = const EdgeInsets.all(10),
      this.margin = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(30 / 255),
              spreadRadius: 4,
              offset: const Offset(0, 8)),
          const BoxShadow(
              color: primaryPurpleDarker,
              spreadRadius: 4,
              offset: Offset(0, 4)),
          const BoxShadow(color: primaryPurple, spreadRadius: 4),
          const BoxShadow(color: primaryYellow, spreadRadius: 2),
        ],
      ),
      child: child,
    );
  }
}
