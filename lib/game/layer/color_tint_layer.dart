import 'dart:ui';

import 'package:flame/layers.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/environment_controller.dart';

class ColorTintLayer extends DynamicLayer {
  EnvTime envTime;
  ColorTintLayer({this.envTime = EnvTime.morning});

  @override
  void drawLayer() {
    if (envTime == EnvTime.morning) {
      canvas.drawColor(const Color.fromRGBO(104, 76, 0, 1).withOpacity(0.6),
          BlendMode.darken);
    }
    if (envTime == EnvTime.noon) {
      canvas.drawColor(primaryYellowLighter.withOpacity(0.2), BlendMode.screen);
    }
    if (envTime == EnvTime.afternoon) {
      canvas.drawColor(primaryPurpleDarker.withOpacity(0.6), BlendMode.darken);
    }
    if (envTime == EnvTime.night) {
      canvas.drawColor(const Color.fromARGB(255, 15, 0, 70).withOpacity(0.7),
          BlendMode.darken);
    }
  }
}
