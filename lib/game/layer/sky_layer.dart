import 'package:flame/components.dart';
import 'package:flame/layers.dart';
import 'package:necopia/environment/environment_controller.dart';

class SkyLayer extends DynamicLayer {
  EnvTime envTime;
  final Vector2 size;
  Vector2? offset;
  SkyLayer(this.envTime, {required this.size, this.offset});

  Sprite? _sprite;

  changeTime(EnvTime envTime) async {
    if (envTime == EnvTime.morning)
      _sprite = await Sprite.load("sky/early.png");
    if (envTime == EnvTime.noon) _sprite = await Sprite.load("sky/noon.png");
    if (envTime == EnvTime.afternoon)
      _sprite = await Sprite.load("sky/afternoon.png");
    if (envTime == EnvTime.night) _sprite = await Sprite.load("sky/night.png");
  }

  @override
  void drawLayer() {
    offset ??= Vector2(0, 0);
    _sprite?.render(canvas,
        size: size, position: offset, anchor: Anchor.center);
  }
}
