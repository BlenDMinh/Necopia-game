import 'package:flame/layers.dart';
import 'package:necopia/game/layer/processor/glow_processor.dart';
import 'package:necopia/game/necopia_game.dart';

class GameLayer extends DynamicLayer {
  NecopiaGame game;
  GameLayer(this.game) {
    preProcessors.add(GlowProcessor());
  }
  @override
  void drawLayer() {
    for (var animal in game.animals) {
      if (animal.animation != null) {
        animal.animationTicker
            ?.getSprite()
            .render(canvas, size: animal.size, position: animal.position);
      }
    }
  }
}
