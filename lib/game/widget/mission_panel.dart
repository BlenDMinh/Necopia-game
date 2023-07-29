import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/game/necopia_game.dart';

import '../../widget/pixelate/pixel_button.dart';
import '../../widget/pixelate/pixel_container.dart';

Widget DailyMissionWidget(
    {required Image missionIcon,
    required String title,
    required String description,
    required int reward,
    required Image stateIcon}) {
  return PixelContainer(
    color: lightPurplePalette,
    margin: const EdgeInsets.only(bottom: 30),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        flex: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 2, child: missionIcon),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontFamily: "Inscryption",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: 2),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontFamily: "Inscryption",
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(children: [
              Text(
                "Reward: $reward",
                style: const TextStyle(
                  fontFamily: "Inscryption",
                  fontSize: 15,
                  color: primaryPurpleDarker,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, bottom: 4),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/coin.png",
                  filterQuality: FilterQuality.none,
                  width: 15,
                  height: 15,
                ),
              )
            ])
          ],
        ),
      ),
      Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                debugPrint("Click on task:  $title");
              },
              icon: stateIcon))
    ]),
  );
}

class MissionPanel extends StatelessWidget {
  final NecopiaGame game;
  List<String> missions = [
    "test1",
    "test2",
    "test3",
    "test4",
    "test5",
    "test6",
  ];
  MissionPanel(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return PixelContainer(
      margin: const EdgeInsets.all(32.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          flex: 0,
          child: Container(
            alignment: Alignment.centerRight,
            child: PixelButton(
              onPressed: () {
                game.overlays.remove('mission');
              },
              aspect: PixelButtonAspect.oneOne,
              width: 25,
              child: const Text(
                "x",
                style: TextStyle(
                    fontFamily: "Minecraft", fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: const Text("DAILY MISSION",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: "Minecraft",
                    fontSize: 30,
                    color: primaryPurpleDarker)),
          ),
        ),
        Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                children: missions
                    .map((e) => DailyMissionWidget(
                        title: e,
                        description: "Description",
                        reward: 1,
                        missionIcon: Image.asset(
                          "assets/icon/cart.png",
                          filterQuality: FilterQuality.none,
                        ),
                        stateIcon: Image.asset(
                          "assets/icon/tick.png",
                          height: 30,
                          width: 30,
                          filterQuality: FilterQuality.none,
                        )))
                    .toList(),
              ),
            ))
        // Container(
        //   width: ,
        // )
      ]),
    );
  }
}
