import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:necopia/game/animal/cat.dart';

import '../../model/animal_data.dart';

enum AnimalState { idle, moving }

class AnimalComponent extends SpriteAnimationGroupComponent<AnimalState> {
  static Future<AnimalComponent> fromAnimalData(AnimalData data,
      {Vector2? movingSize, Vector2? offset}) async {
    movingSize = movingSize ?? Vector2.all(100);
    offset = offset ?? Vector2.all(0);
    final cat =
        await CatComponent.create(data, movingSize: movingSize, offset: offset);
    return cat;
  }

  // Layers

  AnimalData data;

  AnimalComponent(this.data, Map<AnimalState, SpriteAnimation> animations,
      this.movingSize, this.offset)
      : super(animations: animations, current: AnimalState.idle) {}

  bool isMoving = false;
  bool isTargetReach = false;
  bool moveDirection = false;
  double speed = 1;
  Vector2 movingSize;
  Vector2 offset;
  Vector2? target;

  @override
  FutureOr<void> onLoad() {
    position = Vector2(Random().nextDouble() * movingSize[0],
            Random().nextDouble() * movingSize[1]) +
        offset;
    anchor = Anchor.center;
    size = Vector2.all(100 + data.level * 1);
  }

  void _triggerMove() {
    target = Vector2(Random().nextDouble() * movingSize[0],
            Random().nextDouble() * movingSize[1]) +
        offset;
    final moveDirection = (target! - position).x > 0;
    if (moveDirection != this.moveDirection) {
      flipHorizontally();
      this.moveDirection = moveDirection;
    }
    isMoving = true;
    current = AnimalState.moving;
  }

  void _onTargetReach() {
    target = null;
    isMoving = false;
    current = AnimalState.idle;
  }

  @override
  void update(double dt) {
    // print(position);
    super.update(dt);
    if (isMoving) {
      Vector2 moveDirection = target! - position;
      moveDirection = moveDirection * speed / moveDirection.length;
      position += moveDirection;
      if ((target! - position).length < speed) _onTargetReach();
    } else {
      bool trigger = Random().nextDouble() < 0.002;
      if (trigger) _triggerMove();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
