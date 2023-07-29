import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/game/animal/animal_component.dart';
import 'package:necopia/game/animal/cat.dart';
import 'package:necopia/game/item/bookshelf.dart';
import 'package:necopia/game/item/carpet.dart';
import 'package:necopia/game/item/lamp.dart';
import 'package:necopia/game/item/tv.dart';
import 'package:necopia/game/layer/air_quality_layer.dart';
import 'package:necopia/game/layer/background_image_layer.dart';
import 'package:necopia/game/layer/color_tint_layer.dart';
import 'package:necopia/game/layer/game_layer.dart';
import 'package:necopia/game/layer/glow_layer.dart';
import 'package:necopia/game/layer/rain_layer.dart';
import 'package:necopia/game/layer/rain_sky_layer.dart';
import 'package:necopia/game/layer/sky_layer.dart';
import 'package:necopia/game/layer/uv_layer.dart';
import 'package:necopia/game/widget/ad.dart';
import 'package:necopia/game/widget/dev_menu.dart';
import 'package:necopia/game/widget/dialog_panel.dart';
import 'package:necopia/game/widget/game_menu.dart';
import 'package:necopia/game/widget/mission_panel.dart';
import 'package:necopia/game/widget/store.dart';
import 'package:necopia/model/animal.dart';
import 'package:necopia/model/animal_data.dart';
import 'package:necopia/model/user.dart';
import 'package:necopia/service/user_service.dart';
import 'package:necopia/view/loading.dart';
import 'package:necopia/view/profile.dart';

class NecopiaGame extends FlameGame with TapCallbacks {
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

  final bgmPlayer = AudioPlayer();

  // Game layers

  late SkyLayer skyLayer;
  late RainSkyLayer rainSkyLayer;
  late Layer backgroundLayer;
  late ColorTintLayer colorTintLayer;
  late UvLayer uvLayer;
  late AirQualityLayer airQualityLayer;
  late RainLayer rainLayer;
  late Layer gameLayer;
  late RoundGlowLayer windowGlowLayer;

  // Components
  late LampComponent lamp;
  late BookShelfComponent shelf;
  late CarpetComponent carpet;
  late TvComponent tv;

  // Game logics

  @override
  FutureOr<void> onLoad() async {
    bgmPlayer.setReleaseMode(ReleaseMode.loop);
    bgmPlayer.play(AssetSource("audio/bgm.mp3"));
    NecopiaUser? user = NecopiaUser.currentUser;
    await user?.ensureInit();

    skyLayer = SkyLayer(environmentController.currentEnvironment.time,
        size: Vector2(size.x / 2, size.x / 2),
        offset: Vector2(size.x / 2, size.y / 2.5));

    rainSkyLayer = await RainSkyLayer.create(
        size: Vector2(size.x / 2, size.x / 2),
        offset: Vector2(size.x / 2, size.y / 2.5));

    final backgroundSprite = await Sprite.load('room.png');

    backgroundLayer = BackgroundImageLayer(
        sprite: backgroundSprite,
        size: backgroundSprite.srcSize *
            (size.x / (backgroundSprite.srcSize.x / 3)),
        offset: Vector2(size.x / 2 - 10, size.y / 2));

    colorTintLayer = ColorTintLayer();
    uvLayer = UvLayer();
    airQualityLayer = AirQualityLayer();
    rainLayer = RainLayer();

    gameLayer = GameLayer(this);
    windowGlowLayer = RoundGlowLayer(Offset(size.x / 2, size.y / 2.5),
        color: primaryPurpleLighter.withOpacity(0.6),
        radius: 100,
        blurRadius: 50,
        outerRadius: 175,
        outerBlurRadius: 50);

    // Environment change listen
    environmentController.listen((environment) async {
      colorTintLayer.envTime = environment!.time;
      skyLayer.changeTime(environment.time);
      uvLayer.uv = environment.uv;
      airQualityLayer.airQuality = environment.airQuality;
      rainLayer.weather = environment.weather;
      rainSkyLayer.weather = environment.weather;
    });

    carpet = await CarpetComponent.create();
    carpet.position = Vector2(size.x / 2, size.y / 1.4);
    add(carpet);

    shelf = await BookShelfComponent.create();
    shelf.position = Vector2(-20, size.y / 2.7);
    add(shelf);

    tv = await TvComponent.create(onTap: () {
      overlays.add('ad');
    });
    tv.position = Vector2(320, size.y / 1.75);
    add(tv);

    lamp = await LampComponent.create();
    lamp.position = Vector2(-30, 550);
    lamp.lampGlow.position = lamp.position.toOffset() + Offset(70, 30);
    add(lamp);

    if (user == null || user.animalDatas == null || user.animalDatas!.isEmpty) {
      AnimalComponent animal = await AnimalComponent.fromAnimalData(
          AnimalData(Animal('Cat'), null),
          movingSize: Vector2(size.x * 3 / 4, size.y / 4),
          offset: Vector2(size.x / 8, size.y * 3.3 / 5));
      animals.add(animal);
      add(animal);
      CatComponent cat = animal as CatComponent;
      add(cat.catDialogComponent);
    }
    for (AnimalData data in user!.animalDatas!) {
      if (!data.isActive) continue;
      animalData = data;
      AnimalComponent animal = await AnimalComponent.fromAnimalData(data,
          movingSize: Vector2(size.x * 3 / 4, size.y / 5),
          offset: Vector2(size.x / 8, size.y * 3.3 / 5));
      animals.add(animal);
      add(animal);
      CatComponent cat = animal as CatComponent;
      add(cat.catDialogComponent);
      add(animal.mask);
      add(animal.glasses);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    rainSkyLayer.update(dt);
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
    rainSkyLayer.render(canvas);
    backgroundLayer.render(canvas);
    super.render(canvas);
    colorTintLayer.render(canvas);
    uvLayer.render(canvas);
    airQualityLayer.render(canvas);
    rainLayer.render(canvas);
    lamp.lampGlow.render(canvas);
    windowGlowLayer.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    animals[0].triggerMove(targetPosition: event.canvasPosition);
  }
}

GameWidget necopiaGameWidget = GameWidget.controlled(
  gameFactory: NecopiaGame.instance,
  overlayBuilderMap: {
    'game_menu': ((context, game) => GameMenu(game as NecopiaGame)),
    'profile': (context, game) => Profile(game: game as NecopiaGame),
    'store': (context, game) => StoreWidget(game as NecopiaGame),
    'dev': (context, game) => DevMenu(game as NecopiaGame),
    'mission': (context, game) => MissionPanel(game as NecopiaGame),
    'dialog': (context, game) => DialogPanel(game as NecopiaGame),
    'ad': (context, game) => Ad(game as NecopiaGame)
  },
  loadingBuilder: (p0) => loading(p0),
  initialActiveOverlays: const ['game_menu', 'dialog'],
);
