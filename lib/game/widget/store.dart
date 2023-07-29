import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "500 ",
                  style: TextStyle(
                      fontFamily: "Pixelate",
                      color: Colors.deepPurple.shade800,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      fontSize: 30),
                ),
                Image.asset(
                  "assets/images/coin.png",
                  width: 35,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_circle_rounded,
                      color: Colors.green[300],
                      size: 35,
                    ))
              ],
            ),
            PixelButton(
              onPressed: () {
                game.overlays.remove('store');
              },
              aspect: PixelButtonAspect.oneOne,
              width: 40,
              child: Text(
                "X",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontFamily: "Minecraft",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 15,
            mainAxisSpacing: 45,
            crossAxisCount: 2,
            children: <Widget>[
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/item/lamp.png"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "100 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/item/tv.png",
                        width: 65,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "500 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/cat-1.png",
                        width: 65,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1000 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/cat-4.png", width: 65),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1000 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/cat-2.png", width: 65),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1000 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/cat-3.png", width: 65),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "2000 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/carpet.png", width: 65),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "200 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
              PixelContainer(
                  color: deepPurplePalette,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/cat_img_1.png", width: 65),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "50 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pixelate",
                                fontSize: 17),
                          ),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 20,
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
