import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/game/controller/dialog_controller.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

import '../necopia_game.dart';

class DialogPanel extends StatelessWidget {
  final NecopiaGame game;
  DialogPanel(this.game, {super.key});

  final dialogController = Get.find<ICatDialogController>();

  @override
  Widget build(BuildContext context) {
    return PixelContainer(
        color: Colors.white,
        child: StreamBuilder(
            stream: dialogController.stream,
            builder: (context, snapshot) {
              debugPrint(snapshot.data?.message ?? "test");
              return AnimatedTextKit(
                key: ValueKey<CatDialog?>(snapshot.data),
                animatedTexts: [
                  TyperAnimatedText(snapshot.data?.message ?? "Hello")
                ],
              );
            }));
  }
}
