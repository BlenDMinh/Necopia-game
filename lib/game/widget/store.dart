import 'package:flutter/material.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/widget/pixelate/pixel_button.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

class StoreWidget extends StatelessWidget {
  final NecopiaGame game;
  const StoreWidget(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return PixelContainer(
      margin: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
      child: Column(children: [
        Align(
          alignment: Alignment.topRight,
          child: PixelButton(
            onPressed: () {
              game.overlays.remove('store');
            },
            aspect: PixelButtonAspect.oneOne,
            width: 40,
            child: Text("Close"),
          ),
        )
      ]),
    );
  }
}
