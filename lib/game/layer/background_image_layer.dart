import 'package:flame/components.dart';
import 'package:flame/layers.dart';

class BackgroundImageLayer extends PreRenderedLayer {
  final Sprite sprite;
  final Vector2 size;
  Vector2? offset;
  BackgroundImageLayer({required this.sprite, required this.size, this.offset});

  @override
  void drawLayer() {
    offset ??= Vector2.all(0);
    sprite.render(canvas,
        size: size, position: offset, anchor: const Anchor(0.5, 0.5));
  }
}
