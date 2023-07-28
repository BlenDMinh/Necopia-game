import 'dart:math';

import 'package:flutter/material.dart';

enum PixelButtonAspect { oneOne, twoOne, threeOne, fourOne, fiveOne, sixOne }

class PixelButton extends StatefulWidget {
  static final Map<PixelButtonAspect, double> ratio = {
    PixelButtonAspect.oneOne: 1,
    PixelButtonAspect.sixOne: 126.0 / 23.0
  };
  final Widget child;
  final double width;
  final VoidCallback onPressed;
  final PixelButtonAspect aspect;
  const PixelButton(
      {super.key,
      required this.onPressed,
      this.child = const SizedBox.shrink(),
      this.aspect = PixelButtonAspect.sixOne,
      this.width = 300});

  @override
  State<StatefulWidget> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  double height(double width) => width / ratio[widget.aspect]!;
  double pixel(double height) => height / 23.0;

  Map<PixelButtonAspect, double> ratio = {
    PixelButtonAspect.oneOne: 21.0 / 23.0,
    PixelButtonAspect.sixOne: 126.0 / 23.0
  };
  bool isTapDown = false;

  ImageProvider<Object> _getButtonImage() {
    if (widget.aspect == PixelButtonAspect.oneOne) {
      if (!isTapDown)
        return const AssetImage("assets/button/button-base1x1.png");
      return const AssetImage("assets/button/button-base1x1-pressed.png");
    }
    if (!isTapDown) return const AssetImage("assets/button/button-base6x1.png");
    return const AssetImage("assets/button/button-base6x1-pressed.png");
  }

  @override
  Widget build(BuildContext context) {
    final image = _getButtonImage();
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isTapDown = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTapDown = false;
        });
      },
      onTap: () {
        widget.onPressed.call();
      },
      child: LayoutBuilder(builder: (context, constraint) {
        double w = min(widget.width, constraint.maxWidth);
        double h = height(w);
        double p = pixel(h);
        return Container(
            alignment: Alignment.center,
            width: w,
            height: h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    filterQuality: FilterQuality.none,
                    image: image,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: isTapDown ? p * 8 : p * 6,
                ),
                widget.child,
              ],
            ));
      }),
    );
  }
}
