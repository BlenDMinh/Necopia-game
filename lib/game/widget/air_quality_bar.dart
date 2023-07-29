import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/air_visual_service.dart';
import '../../environment/environment_controller.dart';

class AirQualityBar extends StatelessWidget {
  AirQualityBar({super.key});

  final environmentController = Get.find<IEnvironmentController>();

  final _qualityString = [
    "Good",
    "Moderate",
    "Sensitive",
    "Unhealthy",
    "Very unhealthy",
    "Hazardous"
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Environment?>(
        stream: environmentController.stream,
        builder: (context, snapshot) {
          AirQuality quality = AirQuality.good;
          int aqi = 0;
          num temperature = 0;

          if (snapshot.data != null) {
            if (snapshot.data!.airVisualResult != null) {
              aqi = snapshot.data!.airVisualResult!.currentPollution.aqi;
              temperature =
                  snapshot.data!.airVisualResult!.currentWeather.temperature;
            }
            quality = snapshot.data!.airQuality;
          }
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/air.png",
                        filterQuality: FilterQuality.none,
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      Text(" AQI: $aqi | ",
                          style: TextStyle(
                            fontFamily: "Pixelate",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 14,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.grey, offset: Offset(0, 3))
                    ]),
                    padding: EdgeInsets.all(3),
                    child: Text(
                      _qualityString[quality.index],
                      style: TextStyle(
                          fontFamily: "Pixelate",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 14,
                          color: quality == AirQuality.good
                              ? Colors.greenAccent.shade700
                              : quality == AirQuality.moderate
                                  ? primaryYellowLighter
                                  : quality == AirQuality.unhealthy
                                      ? Colors.red
                                      : Colors.red.shade800),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/icon/thermometer.png",
                          filterQuality: FilterQuality.none,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        Text("Temperature: ",
                            style: TextStyle(
                              fontFamily: "Pixelate",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ]),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.grey, offset: Offset(0, 3))
                    ]),
                    padding: EdgeInsets.all(3),
                    child: Text("$temperature" + "'C",
                        style: TextStyle(
                          fontFamily: "Pixelate",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 14,
                          color: Colors.greenAccent.shade700,
                        )),
                  )
                ],
              )
            ],
          );
        });
  }
}
