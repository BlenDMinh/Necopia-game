import 'package:flame/components.dart';

class TvComponent extends SpriteComponent {
  TvComponent._();
  static create() async {
    final sprite = await Sprite.load("item/tv.png");
    final tv = TvComponent._();
    tv.sprite = sprite;
    tv.size /= 1.5;
    tv.anchor = Anchor.center;
    return tv;
  }
}
