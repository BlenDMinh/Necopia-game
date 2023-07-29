import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/environment_controller.dart';

class UvLayer extends DynamicLayer {
  EnvUv uv = EnvUv.low;
  UvLayer();

  final Map<EnvUv, Color> _colorMap = {
    EnvUv.low: const Color(0xffffffff).withOpacity(0),
    EnvUv.moderate: primaryYellowLighter.withOpacity(0.1),
    EnvUv.high: primaryYellowLighter.withOpacity(0.2),
    EnvUv.veryHigh: primaryYellowLighter.withOpacity(0.3),
    EnvUv.extreme: primaryYellowLighter.withOpacity(0.5)
  };

  @override
  void drawLayer() {
    var color = _colorMap[uv];
    color ??= const Color(0xffffffff).withOpacity(0);
    canvas.drawColor(color, BlendMode.screen);
  }
}
