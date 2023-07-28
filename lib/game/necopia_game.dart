import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/game/animal/animal_component.dart';
import 'package:necopia/game/item/lamp.dart';
import 'package:necopia/game/layer/background_image_layer.dart';
import 'package:necopia/game/layer/color_tint_layer.dart';
import 'package:necopia/game/layer/game_layer.dart';
import 'package:necopia/game/layer/glow_layer.dart';
import 'package:necopia/game/layer/sky_layer.dart';
import 'package:necopia/game/widget/game_menu.dart';
import 'package:necopia/model/animal_data.dart';
import 'package:necopia/model/user.dart';
import 'package:necopia/service/user_service.dart';
import 'package:necopia/view/loading.dart';
import 'package:necopia/view/profile.dart';

class NecopiaGame extends FlameGame {
  UserService userService = Get.find<UserService>();
  AnimalData? animalData;

  static NecopiaGame _instance = NecopiaGame._();
  NecopiaGame._() {}

  factory NecopiaGame.instance() {
    _instance = _instance ?? NecopiaGame._();
    return _instance;
  }

  List<AnimalComponent> animals = [];

  // Environment Controller

  IEnvironmentController environmentController =
      Get.find<IEnvironmentController>();

  // Game layers

  late SkyLayer skyLayer;
  late Layer backgroundLayer;
  late ColorTintLayer colorTintLayer;
  late Layer gameLayer;
  late RoundGlowLayer windowGlowLayer;

  // Components
  late LampComponent lamp;

  // Game logics

  @override
  FutureOr<void> onLoad() async {
    NecopiaUser? user = NecopiaUser.currentUser;
    await user?.ensureInit();

    skyLayer = SkyLayer(environmentController.currentEnvironment.time,
        size: Vector2(size.x / 2, size.x / 2),
        offset: Vector2(size.x / 2, size.y / 2 - 70));

    final backgroundSprite = await Sprite.load('room.png');

    backgroundLayer = BackgroundImageLayer(
        sprite: backgroundSprite,
        size: backgroundSprite.srcSize *
            (size.x / (backgroundSprite.srcSize.x / 3)),
        offset: Vector2(size.x / 2 - 10, size.y / 2));

    colorTintLayer = ColorTintLayer();

    gameLayer = GameLayer(this);
    windowGlowLayer = RoundGlowLayer(Offset(size.x / 2, size.y / 2 - 70),
        color: primaryPurpleLighter.withOpacity(0.6),
        radius: 100,
        blurRadius: 50,
        outerRadius: 175,
        outerBlurRadius: 50);

    // Environment change listen
    environmentController.listen((environment) async {
      colorTintLayer.envTime = environment!.time;
      skyLayer.changeTime(environment.time);

      // colorTintLayer.envTime = EnvTime.night;
      // skyLayer.changeTime(EnvTime.night);

      // debugPrint(environment.time.toString());
      // windowGlowLayer.color =
      //     Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      //         .withOpacity(1.0);
      // windowGlowLayer.outerColor =
      //     Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      //         .withOpacity(1.0);
    });

    lamp = await LampComponent.create();
    lamp.position = Vector2(0, 450);
    lamp.lampGlow.position = lamp.position.toOffset() + Offset(70, 30);
    add(lamp);

    // SliderComponent slider = await SliderComponent.create();
    // slider.position = Vector2(size.x / 4, size.y / 6);
    // add(slider);

    for (AnimalData data in user!.animalDatas!) {
      if (!data.isActive) continue;
      animalData = data;
      AnimalComponent animal = await AnimalComponent.fromAnimalData(data,
          movingSize: Vector2(size.x * 3 / 4, size.y / 4),
          offset: Vector2(size.x / 8, size.y * 3.3 / 5));
      animals.add(animal);
      add(animal);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onRemove() async {
    super.onRemove();
    userService.updateNecopiaUser(NecopiaUser.currentUser!);
  }

  @override
  Color backgroundColor() => primaryPurpleDarker;

  @override
  void render(Canvas canvas) {
    skyLayer.render(canvas);
    backgroundLayer.render(canvas);
    super.render(canvas);
    colorTintLayer.render(canvas);
    lamp.lampGlow.render(canvas);
    windowGlowLayer.render(canvas);
  }
}

GameWidget necopiaGameWidget = GameWidget.controlled(
  gameFactory: NecopiaGame.instance,
  overlayBuilderMap: {
    'game_menu': ((context, game) => GameMenu(game as NecopiaGame)),
    'profile': (context, game) => Profile(game: game as NecopiaGame)
  },
  loadingBuilder: (p0) => loading(p0),
  initialActiveOverlays: const ['game_menu'],
);
