import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:necopia/environment/air_visual_service.dart';

class AirQualityLayer extends DynamicLayer {
  AirQuality airQuality = AirQuality.good;

  @override
  void drawLayer() {
    if (airQuality.index > 0) {
      canvas.drawColor(Colors.grey.withOpacity(airQuality.index * 0.1 + 0.2),
          BlendMode.color);
      canvas.drawColor(Colors.black54.withOpacity(airQuality.index * 0.1 + 0.1),
          BlendMode.screen);
    }
  }
}
