import 'dart:ui';

import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/game/layer/processor/glow_processor.dart';

class TestGlow extends PreRenderedLayer {
  @override
  void drawLayer() {
    Paint paint = Paint();
    paint.color = yellowPaletteLighter.withOpacity(0.6);
    paint.blendMode = BlendMode.lighten;
    paint.imageFilter =
        ImageFilter.blur(sigmaX: 20, sigmaY: 20, tileMode: TileMode.decal);
    canvas.drawCircle(Offset(30, 525), 50, paint);

    paint.color = yellowPaletteLighter.withOpacity(0.7);
    paint.blendMode = BlendMode.softLight;
    paint.imageFilter =
        ImageFilter.blur(sigmaX: 50, sigmaY: 50, tileMode: TileMode.decal);
    canvas.drawCircle(Offset(30, 525), 200, paint);
  }
}
