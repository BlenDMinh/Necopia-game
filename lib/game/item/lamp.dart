import 'package:flame/components.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/game/layer/glow_layer.dart';

class LampComponent extends SpriteComponent {
  late RoundGlowLayer lampGlow;

  LampComponent._();
  static create() async {
    final sprite = await Sprite.load('item/lamp.png');
    LampComponent lamp = LampComponent._();
    lamp.sprite = sprite;
    lamp.size *= 2;
    lamp.lampGlow = RoundGlowLayer(lamp.position.toOffset(),
        color: primaryYellowLighter, outerRadius: 300, radius: 50);
    return lamp;
  }
}
