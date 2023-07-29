import 'package:flutter/widgets.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

import '../../widget/pixelate/pixel_button.dart';

class Ad extends StatelessWidget {
  final NecopiaGame game;
  const Ad(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return PixelContainer(
      margin: EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: PixelButton(
              onPressed: () {
                game.overlays.remove('ad');
              },
              aspect: PixelButtonAspect.oneOne,
              width: 40,
              child: Text(
                "X",
                style: TextStyle(
                  fontFamily: "Pixelate",
                ),
              ),
            ),
          ),
          Text(
            "INSERT",
            style: TextStyle(fontFamily: "Pixelate", fontSize: 70),
          ),
          Text(
            "AD",
            style: TextStyle(fontFamily: "Pixelate", fontSize: 70),
          ),
          Text(
            "HERE",
            style: TextStyle(fontFamily: "Pixelate", fontSize: 70),
          ),
        ],
      ),
    );
  }
}
