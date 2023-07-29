import 'package:flame/components.dart';

class CarpetComponent extends SpriteComponent {
  CarpetComponent._();
  static create() async {
    final sprite = await Sprite.load("carpet.png");
    CarpetComponent carpet = CarpetComponent._();
    carpet.sprite = sprite;
    carpet.anchor = Anchor.center;
    carpet.size *= 6;
    return carpet;
  }
}
