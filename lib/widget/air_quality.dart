import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/air_visual_service.dart';

enum AnnouColor {
  good(Colors.green, Colors.green, "GOOD", ""),
  moderate(Color.fromARGB(255, 210, 196, 69), Color.fromARGB(255, 210, 196, 69),
      "MODERATE", ""),
  sensitive(Colors.orange, Colors.orange, "SENSITIVE", ""),
  unhealthy(Colors.red, Colors.red, "UNHEALTHY", ""),
  veryUnhealthy(Colors.blue, Colors.blue, "VERYUNHEALTHY", ""),
  hazardous(Colors.deepPurple, Colors.deepPurple, "HAZARDOUS", "");

  const AnnouColor(
      this.titleColor, this.desColor, this.title, this.description);

  final Color titleColor;
  final Color desColor;
  final String title;
  final String description;
}

// ignore: must_be_immutable
class AirQualityScreen extends StatelessWidget {
  final double width;
  final double heigth;
  final BuildContext? context;
  final AirVisualResult airVisualResult;

  String _city = "Thanh Khe";
  String _state = "Thanh pho Da Nang";
  String _country = "Viet Nam";
  Pollution _currentPollution = Pollution.fromJson(
      {"ts": "2023-07-23T09:53:54.913Z", "aqius": 46, "aqicn": 46});
  AnnouColor _annouColor = AnnouColor.hazardous;

  AirQualityScreen({
    super.key,
    required this.width,
    required this.heigth,
    this.context,
    required this.airVisualResult,
  });

  void _getInfor() {
    debugPrint("Open UV Service in UV_INDEX_SCREEN");
    _city = airVisualResult.city;
    _state = airVisualResult.state;
    _country = airVisualResult.country;
    _currentPollution = airVisualResult!.currentPollution;
    switch (_currentPollution.airQualityStatus) {
      case AirQuality.good:
        _annouColor = AnnouColor.good;
        break;
      case AirQuality.moderate:
        _annouColor = AnnouColor.moderate;
        break;
      case AirQuality.sensitive:
        _annouColor = AnnouColor.sensitive;
        break;
      case AirQuality.unhealthy:
        _annouColor = AnnouColor.unhealthy;
        break;
      case AirQuality.veryUnhealth:
        _annouColor = AnnouColor.veryUnhealthy;
        break;
      case AirQuality.hazardous:
        _annouColor = AnnouColor.hazardous;
    }
  }

  @override
  Widget build(BuildContext context) {
    _getInfor();
    return Container(
      width: width / 1.1,
      height: heigth / 2,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: primaryYellowLighter,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(30 / 255),
              spreadRadius: 4,
              offset: const Offset(0, 8)),
          BoxShadow(
              color: _annouColor.titleColor,
              spreadRadius: 4,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "AIR QUALITY",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "Minecraft",
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("AQI Index",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "Minecraft",
                                fontSize: 38)),
                        Text(_currentPollution.aqi.toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontFamily: "Minecraft",
                                fontSize: 50,
                                fontWeight: FontWeight.w500)),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: lightPurplePalette,
                      border:
                          Border.all(color: _annouColor.titleColor, width: 5),
                    ),
                    child: Text(_annouColor.title,
                        style: TextStyle(
                            color: _annouColor.titleColor,
                            fontFamily: "Minecraft",
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "City",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    ),
                    Text(
                      _city,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "State",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    ),
                    Text(
                      _state,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Country",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    ),
                    Text(
                      _country,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
