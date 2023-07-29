import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/openuv_service.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/view/login.dart';
import 'package:necopia/widget/air_quality.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';
import 'package:necopia/widget/uv_index.dart';

import '../environment/air_visual_service.dart';
import '../widget/pixelate/pixel_button.dart';

class Profile extends StatelessWidget {
  final NecopiaGame? game;
  const Profile({super.key, this.game});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Center(
        child: PixelContainer(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Text(
                //   "Profile",
                //   style: TextStyle(fontSize: 20),
                // ),
                // Text(
                //   "Hello ${FirebaseAuth.instance.currentUser!.email}",
                //   style: const TextStyle(fontSize: 20, color: Colors.red),
                // ),
                PixelButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Get.to(LoginScreen());
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                          fontFamily: "Minecraft",
                          color: Colors.white,
                          fontSize: 20),
                    )),
                PixelButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ));
                      OpenUVService()
                          .getUVData()
                          .then((value) => {
                                Navigator.pop(context),
                                showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                        child: UVIndexScreen(
                                            width: width,
                                            heigth: height,
                                            context: context,
                                            openUVResult: value)))
                              })
                          .onError((error, stackTrace) => {
                                printError(info: error.toString()),
                                Navigator.pop(context)
                              });
                    },
                    child: const Text(
                      "Open UV",
                      style: TextStyle(
                          fontFamily: "Minecraft",
                          color: Colors.white,
                          fontSize: 20),
                    )),
                PixelButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          // barrierDismissible: false,
                          builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ));
                      AirVisualService()
                          .getNearestCityData()
                          .then((value) => {
                                Navigator.pop(context),
                                showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                            child: AirQualityScreen(
                                          width: width,
                                          heigth: height,
                                          context: context,
                                          airVisualResult: value,
                                        )))
                              })
                          .onError((error, stackTrace) => {
                                printError(info: error.toString()),
                                Navigator.pop(context)
                              });
                    },
                    child: const Text(
                      "Air Quality",
                      style: TextStyle(
                          fontFamily: "Minecraft",
                          color: Colors.white,
                          fontSize: 20),
                    ))
              ]),
        ),
      ),
    );
  }
}
