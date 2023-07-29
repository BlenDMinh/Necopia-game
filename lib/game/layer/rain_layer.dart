import 'dart:ui';

import 'package:flame/layers.dart';
import 'package:necopia/environment/environment_controller.dart';

class RainLayer extends DynamicLayer {
  EnvWeather weather = EnvWeather.normal;

  final Map<EnvWeather, Color> _colorMap = {
    EnvWeather.normal: const Color(0xffffffff).withOpacity(0),
    EnvWeather.rain: const Color.fromARGB(255, 0, 10, 145).withOpacity(0.2),
    EnvWeather.thunder: const Color.fromARGB(255, 68, 0, 178).withOpacity(0.2)
  };

  @override
  void drawLayer() {
    canvas.drawColor(_colorMap[weather]!, BlendMode.hardLight);
  }
}
