import 'package:flame/components.dart';
import 'package:flame/layers.dart';
import 'package:flame/sprite.dart';
import 'package:necopia/environment/environment_controller.dart';

class RainSkyLayer extends DynamicLayer {
  EnvWeather weather = EnvWeather.normal;
  late SpriteAnimation animation;
  late SpriteAnimationTicker ticker;
  final Vector2 size;
  Vector2? offset;

  static create({required Vector2 size, Vector2? offset}) async {
    List<Sprite> rainSprites = [];
    for (int i = 1; i < 6; i++) {
      rainSprites.add(await Sprite.load("rain/${i}.png"));
    }
    RainSkyLayer skyLayer = RainSkyLayer._(size: size, offset: offset);
    skyLayer.animation = SpriteAnimation.spriteList(rainSprites, stepTime: 0.4);
    skyLayer.ticker = skyLayer.animation.createTicker();
    return skyLayer;
  }

  RainSkyLayer._({required this.size, this.offset});
  @override
  void drawLayer() {
    if (weather != EnvWeather.normal) {
      ticker.currentFrame.sprite
          .render(canvas, size: size, position: offset, anchor: Anchor.center);
    }
  }

  update(double dt) {
    ticker.update(dt);
  }
}
