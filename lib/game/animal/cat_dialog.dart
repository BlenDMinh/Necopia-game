import 'package:flame/components.dart';
import 'package:get/get.dart';
import 'package:necopia/game/animal/cat.dart';
import 'package:necopia/game/controller/dialog_controller.dart';

class CatDialogComponent extends SpriteAnimationComponent {
  CatComponent catComponent;
  CatDialogComponent._(this.catComponent);
  static create(CatComponent catComponent) async {
    List<Sprite> dialogBubbles = [];
    dialogBubbles.add(await Sprite.load("cat/cat-dialog_00.png"));
    dialogBubbles.add(await Sprite.load("cat/cat-dialog_01.png"));
    dialogBubbles.add(await Sprite.load("cat/cat-dialog_02.png"));

    var catDialog = CatDialogComponent._(catComponent);
    catDialog.animation =
        SpriteAnimation.spriteList(dialogBubbles, stepTime: 0.5);
    catDialog.size *= 2.5;
    catDialog.anchor = Anchor.bottomLeft;
    return catDialog;
  }

  final catDialogController = Get.find<ICatDialogController>();

  @override
  void update(double dt) {
    if (catDialogController.dialogStatus == CatDialogStatus.displaying)
      this.setOpacity(1);
    else
      this.setOpacity(0);
    this.position = catComponent.position + Vector2(0, -10);
    super.update(dt);
  }
}
