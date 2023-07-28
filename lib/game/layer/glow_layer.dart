import 'dart:ui';

import 'package:flame/layers.dart';
import 'package:flutter/material.dart';

class RoundGlowLayer extends DynamicLayer {
  Color color;
  Color? outerColor;
  Offset position;
  double radius;
  double? outerRadius;
  double blurRadius;
  double? outerBlurRadius;
  RoundGlowLayer(this.position,
      {this.radius = 30,
      this.outerRadius,
      this.blurRadius = 30,
      this.outerBlurRadius,
      this.color = Colors.white,
      this.outerColor});
  @override
  void drawLayer() {
    outerRadius ??= radius * 4;
    outerBlurRadius ??= blurRadius;
    outerColor ??= color;

    Paint paint = Paint();
    paint.color = color;
    paint.blendMode = BlendMode.screen;
    paint.imageFilter = ImageFilter.blur(
        sigmaX: blurRadius, sigmaY: blurRadius, tileMode: TileMode.decal);
    canvas.drawCircle(position, radius, paint);

    paint.color = outerColor!;
    paint.blendMode = BlendMode.softLight;
    paint.imageFilter = ImageFilter.blur(
        sigmaX: outerBlurRadius!,
        sigmaY: outerBlurRadius!,
        tileMode: TileMode.decal);
    canvas.drawCircle(position, outerRadius!, paint);
  }
}
