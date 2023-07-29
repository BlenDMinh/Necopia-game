import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/game/animal/cat.dart';

class CatClothComponent extends SpriteComponent {
  late bool moveDirection;
  CatComponent cat;
  CatClothComponent._(this.cat);
  final environmentController = Get.find<IEnvironmentController>();

  static create(CatComponent cat, String spritePath) async {
    var catCloth = CatClothComponent._(cat);
    final sprite = await Sprite.load(spritePath);
    catCloth.sprite = sprite;
    catCloth.anchor = Anchor.center;
    catCloth.size = Vector2.all(100);
    catCloth.moveDirection = cat.moveDirection;
    // debugPrint(cat.size.toString());
    return catCloth;
  }

  bool visible = false;

  @override
  void update(double dt) {
    super.update(dt);
    position = cat.position;
    if (visible) {
      setOpacity(1);
    } else {
      setOpacity(0);
    }
    if (cat.moveDirection != moveDirection) {
      moveDirection = cat.moveDirection;
      flipHorizontally();
    }
  }
}
