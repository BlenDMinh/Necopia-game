import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/game/controller/dialog_controller.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

import '../necopia_game.dart';

class DialogPanel extends StatelessWidget {
  final NecopiaGame game;
  DialogPanel(this.game, {super.key});

  // final dialogController = Get.find<IDialogController>();

  @override
  Widget build(BuildContext context) {
    return PixelContainer(
      child: StreamBuilder(
          // stream: dialogController.stream,
          builder: (context, snapshot) => AnimatedTextKit(
                animatedTexts: [TyperAnimatedText("Testing")],
              )),
    );
  }
}
