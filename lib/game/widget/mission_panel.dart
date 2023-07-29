import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/game/necopia_game.dart';

import '../../widget/pixelate/pixel_button.dart';
import '../../widget/pixelate/pixel_container.dart';

//Check in
//
class Mission {
  String title;
  String description;
  int reward;
  bool isFinish;

  Mission(this.title, this.description, this.reward, this.isFinish);
}

// ignore: non_constant_identifier_names
List<Mission> MissionList = [
  Mission("Check In", "Log in everyday", 100, true),
  Mission("Feed Animal", "Is your cat hungry, let's feed them", 200, true),
  Mission("Bath Animal", "Log in everyday", 300, false),
  Mission(
      "Watch TV", "Your cat is boring ..., Watching Television!", 400, true),
  Mission("EnvQuiz", "Answer 5 questions about global environment", 200, false)
];

// ignore: non_constant_identifier_names
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
                            fontFamily: "Pixelate",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: 2),
                      ),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Pixelate",
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
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(children: [
                Text(
                  "Reward: $reward",
                  style: const TextStyle(
                    fontFamily: "Pixelate",
                    fontSize: 15,
                    color: primaryPurpleDarker,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/coin.png",
                    filterQuality: FilterQuality.none,
                    width: 15,
                    height: 15,
                  ),
                )
              ]),
            )
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
  final missions = MissionList;
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
                    .map((item) => DailyMissionWidget(
                        title: item.title,
                        description: item.description,
                        reward: item.reward,
                        missionIcon: Image.asset(
                          "assets/images/mission.png",
                          filterQuality: FilterQuality.none,
                        ),
                        stateIcon: item.isFinish
                            ? Image.asset(
                                "assets/icon/tick.png",
                                height: 30,
                                width: 30,
                                filterQuality: FilterQuality.none,
                              )
                            : Image.asset(
                                "assets/icon/untick.png",
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
