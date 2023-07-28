import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/air_visual_service.dart';
import '../../environment/environment_controller.dart';
import '../../widget/pixelate/pixel_container.dart';

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
          if (snapshot.data != null) {
            if (snapshot.data!.airVisualResult != null) {
              quality = snapshot
                  .data!.airVisualResult!.currentPollution.airQualityStatus;
              aqi = snapshot.data!.airVisualResult!.currentPollution.aqi;
            }
          }
          return PixelContainer(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/icon/air.png",
                  filterQuality: FilterQuality.none,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                Row(
                  children: [
                    Text(" AQI: $aqi | ",
                        style: TextStyle(
                          fontFamily: "Minecraft",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        )),
                    Text(
                      _qualityString[quality.index].padLeft(14),
                      style: TextStyle(
                          fontFamily: "Minecraft",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 13,
                          color: quality == AirQuality.good
                              ? Colors.greenAccent.shade700
                              : quality == AirQuality.moderate
                                  ? primaryYellowLighter
                                  : quality == AirQuality.unhealthy
                                      ? Colors.red
                                      : Colors.red.shade800),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
