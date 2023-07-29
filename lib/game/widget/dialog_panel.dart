import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/game/controller/dialog_controller.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

import '../necopia_game.dart';

class DialogPanel extends StatefulWidget {
  final NecopiaGame game;
  const DialogPanel(this.game, {super.key});

  @override
  State<StatefulWidget> createState() => _DialogPanelState();
}

class _DialogPanelState extends State<DialogPanel> {
  final dialogController = Get.find<ICatDialogController>();
  bool isDisplay = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: StreamBuilder(
          stream: dialogController.stream,
          builder: (context, snapshot) {
            if (snapshot.data?.message != null) {
              isDisplay = true;
            } else {
              isDisplay = false;
            }
            debugPrint(snapshot.data?.message ?? "test");
            if (!isDisplay) return SizedBox.shrink();
            return PixelContainer(
              color: Colors.white,
              child: Container(
                width: 300,
                height: 50,
                child: AnimatedTextKit(
                  onNext: (ind, s) async {
                    isDisplay = false;
                    // await Future.delayed(duration)
                    dialogController.endDialog();
                  },
                  key: ValueKey<CatDialog?>(snapshot.data),
                  animatedTexts: [
                    TyperAnimatedText(snapshot.data?.message ?? "Hello",
                        speed: const Duration(milliseconds: 50),
                        textStyle: const TextStyle(
                            fontFamily: "Minecraft", letterSpacing: 1.5)),
                  ],
                  totalRepeatCount: 1,
                  isRepeatingAnimation: false,
                  pause: const Duration(seconds: 3),
                ),
              ),
            );
          }),
    );
  }
}
