import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/view/login.dart';
import 'package:necopia/widget/pixelate/pixel_button.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgPurple,
      //Color(0xffb39ddb),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background.png"),
                filterQuality: FilterQuality.none)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row(
              //   children: [
              //     Image.asset(
              //       'assets/images/tophead.png',
              //       width: width / 2.5,
              //       fit: BoxFit.fitWidth,
              //       color: Colors.deepPurpleAccent,
              //     ),
              //   ],
              // ),
              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "NECO",
                    //       style: TextStyle(
                    //           letterSpacing: 7.5,
                    //           fontSize: 45,
                    //           fontWeight: FontWeight.w900,
                    //           fontFamily: "Minecraft",
                    //           color: primaryYellow),
                    //     ),
                    //     Text(
                    //       "PIA",
                    //   style: TextStyle(
                    //       letterSpacing: 7.5,
                    //       fontSize: 45,
                    //       fontWeight: FontWeight.w900,
                    //       fontFamily: "Minecraft",
                    //       color: primaryYellow),
                    // )
                    //   ],
                    // ))
                    child: Text(
                      "NECOPIA",
                      style: TextStyle(
                          letterSpacing: 7.5,
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Minecraft",
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: primaryPurpleLighter,
                                offset: Offset(0, 6))
                          ]),
                    )),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Image.asset(
                    'assets/images/coin.png',
                    width: width / 2,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PixelContainer(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "“We are the first generation to feel the impact of climate change and the last generation that can do something about it.”",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: "Inscryption",
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "-  Barack Obama  -",
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontFamily: "Inscryption",
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(left: 35, right: 35),
                      ),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  child: PixelButton(
                      child: Text("Join with us",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Minecraft",
                              fontSize: 20,
                              letterSpacing: 3)),
                      width: width,
                      onPressed: () {
                        Get.to(LoginScreen());
                      }),
                ),
              )
            ]),
      ),
    );
  }
}
