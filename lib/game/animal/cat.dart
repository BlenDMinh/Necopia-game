import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/game/animal/animal_component.dart';
import 'package:necopia/game/animal/cat_cloth.dart';
import 'package:necopia/game/animal/cat_dialog.dart';
import 'package:necopia/game/controller/dialog_controller.dart';
import 'package:necopia/model/animal_data.dart';

import '../../environment/air_visual_service.dart';

class CatComponent extends AnimalComponent with TapCallbacks {
  // CONSTRUCTOR

  CatComponent._(super.data, super.animations, super.movingSize, super.offset);
  static create(AnimalData data,
      {required Vector2 movingSize, required Vector2 offset}) async {
    final animations = await _createAnimations();
    CatComponent cat = CatComponent._(data, animations, movingSize, offset);
    cat.catDialogComponent = await CatDialogComponent.create(cat);
    cat.glasses = await CatClothComponent.create(cat, "cat/glasses.png");
    cat.mask = await CatClothComponent.create(cat, "cat/mask.png");
    // cat.add(cat.catDialogComponent);
    return cat;
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

  // Sub-Components
  late CatDialogComponent catDialogComponent;
  late CatClothComponent glasses;
  late CatClothComponent mask;

  // Controllers
  final dialogController = Get.find<ICatDialogController>();
  final envionmentController = Get.find<IEnvironmentController>();

  // Logics

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    catDialogComponent = await CatDialogComponent.create(this);
    envionmentController.stream.listen((environment) {
      if (environment!.uv.index > 0) {
        glasses.visible = true;
      } else {
        glasses.visible = false;
      }
      if (environment.airQuality.index >= AirQuality.sensitive.index) {
        mask.visible = true;
      } else {
        mask.visible = false;
      }
    });
  }

  @override
  void onTapDown(TapDownEvent event) {
    dialogController.forceDialog();
  }

  void meow() async {
    debugPrint("Meowing");
    final catPlayer = AudioPlayer();
    await catPlayer.setVolume(0.2);
    await catPlayer.play(AssetSource("audio/meow-effect.mp3"),
        mode: PlayerMode.lowLatency);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
