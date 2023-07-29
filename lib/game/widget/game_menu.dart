import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/game/layer/uv_layer.dart';
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
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 20,
                  height: 25,
                  decoration:
                      BoxDecoration(color: Colors.grey[800], boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 3),
                        blurRadius: 0,
                        spreadRadius: 4)
                  ]),
                ),
                Container(
                  width: 20,
                  height: 25,
                  decoration:
                      BoxDecoration(color: Colors.grey[800], boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 3),
                        blurRadius: 0,
                        spreadRadius: 4)
                  ]),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.grey),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 8),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  image: DecorationImage(
                      filterQuality: FilterQuality.none,
                      image: AssetImage(
                        "assets/images/tv_background1.jpeg",
                      ),
                      fit: BoxFit.fitWidth)),
              width: game.size.x,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [UVBar(), AirQualityBar()],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/headphone.png",
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "japanese night cafe vibes\na lofi hip hop mix ~\nchill with taiki",
                      style: TextStyle(
                          fontFamily: "Pixelate",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      softWrap: true,
                      maxLines: 3,
                    )
                  ],
                ),
              ),
              Column(
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
                          color: Colors.white, fontFamily: "Minecraft"),
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
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  PixelButton(
                    onPressed: () {
                      if (game.overlays.isActive('mission'))
                        game.overlays.remove('mission');
                      else
                        game.overlays.add('mission');
                    },
                    aspect: PixelButtonAspect.oneOne,
                    width: 50,
                    child: Image.asset(
                      "assets/images/mission.png",
                      filterQuality: FilterQuality.none,
                      color: Colors.white,
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
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
