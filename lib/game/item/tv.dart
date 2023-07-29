import 'package:flame/components.dart';
import 'package:flame/events.dart';

class TvComponent extends SpriteComponent with TapCallbacks {
  Function? onTap;
  TvComponent._(this.onTap);
  static create({Function? onTap}) async {
    final sprite = await Sprite.load("item/tv.png");
    final tv = TvComponent._(onTap);
    tv.sprite = sprite;
    tv.size /= 1.5;
    tv.anchor = Anchor.center;
    return tv;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onTap?.call();
  }
}
