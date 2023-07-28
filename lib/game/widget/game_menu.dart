import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/game/widget/air_quality_bar.dart';
import 'package:necopia/game/widget/uv_bar.dart';
import 'package:necopia/widget/pixelate/pixel_button.dart';

class GameMenu extends StatelessWidget {
  final NecopiaGame game;
  const GameMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(children: [
            UVBar(),
            SizedBox(
              height: 20,
            ),
            AirQualityBar()
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                PixelButton(
                  onPressed: () {
                    if (game.overlays.isActive('dev'))
                      game.overlays.remove('dev');
                    else
                      game.overlays.add('dev');
                  },
                  aspect: PixelButtonAspect.oneOne,
                  width: 50,
                  child: Text(
                    "DEV",
                    style: TextStyle(
                        color: primaryPurpleDarker, fontFamily: "Minecraft"),
                  ),
                ),
                PixelButton(
                  onPressed: () {
                    if (game.overlays.isActive('store'))
                      game.overlays.remove('store');
                    else
                      game.overlays.add('store');
                  },
                  aspect: PixelButtonAspect.oneOne,
                  width: 50,
                  child: Image.asset(
                    "assets/icon/cart.png",
                    filterQuality: FilterQuality.none,
                    color: primaryPurpleDarker,
                    width: 20,
                    height: 20,
                  ),
                ),
                PixelButton(
                  onPressed: () {
                    if (game.overlays.isActive('profile'))
                      game.overlays.remove('profile');
                    else
                      game.overlays.add('profile');
                  },
                  aspect: PixelButtonAspect.oneOne,
                  width: 50,
                  child: Image.asset(
                    "assets/icon/person.png",
                    filterQuality: FilterQuality.none,
                    color: primaryPurpleDarker,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
