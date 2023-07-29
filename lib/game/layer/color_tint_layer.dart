import 'dart:ui';

import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/environment_controller.dart';

class ColorTintLayer extends DynamicLayer {
  EnvTime envTime;
  ColorTintLayer({this.envTime = EnvTime.morning});

  @override
  void drawLayer() {
    if (envTime == EnvTime.morning) {
      canvas.drawColor(const Color.fromRGBO(104, 76, 0, 1).withOpacity(0.15),
          BlendMode.darken);
    }
    if (envTime == EnvTime.noon) {
      canvas.drawColor(primaryYellowLighter.withOpacity(0), BlendMode.screen);
    }
    if (envTime == EnvTime.afternoon) {
      canvas.drawColor(Colors.amber.withOpacity(0.2), BlendMode.darken);
    }
    if (envTime == EnvTime.night) {
      canvas.drawColor(const Color.fromARGB(255, 15, 0, 70).withOpacity(0.3),
          BlendMode.darken);
    }
  }
}
