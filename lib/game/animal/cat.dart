import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:get/get.dart';
import 'package:necopia/game/animal/animal_component.dart';
import 'package:necopia/game/controller/dialog_controller.dart';
import 'package:necopia/model/animal_data.dart';

class CatComponent extends AnimalComponent with TapCallbacks {
  CatComponent._(super.data, super.animations, super.movingSize, super.offset);
  static create(AnimalData data,
      {required Vector2 movingSize, required Vector2 offset}) async {
    final animations = await _createAnimations();
    return CatComponent._(data, animations, movingSize, offset);
  }

  static Future<Map<AnimalState, SpriteAnimation>> _createAnimations() async {
    List<Sprite> idleSprites = [];
    for (var i = 0; i < 4; i++) {
      final sprite =
          await Sprite.load('cat/cat-idle_${i.toString().padLeft(2, '0')}.png');
      idleSprites.add(sprite);
    }
    final idle = SpriteAnimation.spriteList(idleSprites, stepTime: 0.5);

    List<Sprite> moveSprites = [];
    for (var i = 0; i < 8; i++) {
      final sprite =
          await Sprite.load('cat/cat-move_${i.toString().padLeft(2, '0')}.png');
      moveSprites.add(sprite);
    }
    final move = SpriteAnimation.spriteList(moveSprites, stepTime: 0.1);

    return {AnimalState.idle: idle, AnimalState.moving: move};
  }

  final dialogController = Get.find<IDialogController>();

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    dialogController.stream.listen((event) {
      print(event);
    });
  }

  @override
  void onTapDown(TapDownEvent event) {
    dialogController.forceDialog();
  }
}
