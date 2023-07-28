import 'dart:ui';

import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:necopia/const/color.dart';

class GlowProcessor extends LayerProcessor {
  @override
  void process(Picture pic, Canvas canvas) {
    Paint paint = Paint()
      ..colorFilter = ColorFilter.mode(yellowPaletteLighter, BlendMode.srcATop)
      ..imageFilter = ImageFilter.compose(
          outer: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          inner: ColorFilter.mode(yellowPaletteLighter, BlendMode.srcATop));
    canvas.saveLayer(Rect.largest, paint);
    canvas.drawPicture(pic);
    canvas.restore();
  }
}
