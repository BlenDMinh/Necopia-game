import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/openuv_service.dart';

enum AnnouColor {
  low(Colors.green, Colors.green, "LOW", "No protection needed"),
  moderate(Color.fromARGB(255, 210, 196, 69), Color.fromARGB(255, 210, 196, 69),
      "MODERATE", "Some protection is required"),
  high(Colors.orange, Colors.orange, "HIGH", "Protection essential"),
  veryHigh(Colors.red, Colors.red, "VERY HIGH", "Extra protection is needed"),
  extreme(Colors.deepPurple, Colors.deepPurple, "EXTREME", "Stay inside");

  const AnnouColor(
      this.titleColor, this.desColor, this.title, this.description);

  final Color titleColor;
  final Color desColor;
  final String title;
  final String description;
}

// ignore: must_be_immutable
class UVIndexScreen extends StatelessWidget {
  final double width;
  final double heigth;
  final BuildContext? context;
  final OpenUVResult openUVResult;

  num _uv = 1;
  num _uvMax = 11;
  num _ozone = 0;
  DateTime _uvTime = DateTime.now();
  DateTime _uvMaxTime = DateTime.now();
  DateTime _ozoneTime = DateTime.now();
  AnnouColor _annouColor = AnnouColor.veryHigh;

  UVIndexScreen({
    super.key,
    required this.width,
    required this.heigth,
    this.context,
    required this.openUVResult,
  });

  String dateFormat(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}  ${dateTime.hour}:${dateTime.minute}";
  }

  void _getInfor() {
    debugPrint("Open UV Service in UV_INDEX_SCREEN");
    _uv = openUVResult.uv;
    _uvMax = openUVResult.uvMax;
    _ozone = openUVResult.ozone;
    _uvTime = openUVResult.uvTime;
    _uvMaxTime = openUVResult.uvMaxTime;
    _ozoneTime = openUVResult.ozoneTime;
    _annouColor = (_uv <= 2)
        ? AnnouColor.low
        : (_uv <= 5)
            ? AnnouColor.moderate
            : (_uv <= 7)
                ? AnnouColor.high
                : (_uv <= 10)
                    ? AnnouColor.veryHigh
                    : AnnouColor.extreme;
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
                  "OPEN UV",
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: _uv.toStringAsFixed(1),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "Minecraft",
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: "/${_uvMax.toStringAsFixed(1)}",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "Minecraft",
                                      fontSize: 30))
                            ])),
                            const Text("UV index",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Minecraft",
                                    fontSize: 18))
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(_ozone.toStringAsFixed(1),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Minecraft",
                                    fontSize: 50,
                                    fontWeight: FontWeight.w500)),
                            const Text("Ozone index",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Minecraft",
                                    fontSize: 18))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: lightPurplePalette,
                      border:
                          Border.all(color: _annouColor.titleColor, width: 5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(_annouColor.title,
                            style: TextStyle(
                                color: _annouColor.titleColor,
                                fontFamily: "Minecraft",
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5)),
                        Text(_annouColor.description,
                            style: TextStyle(
                                color: _annouColor.desColor,
                                fontFamily: "Minecraft",
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5)),
                      ],
                    ),
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
                      "UV Time",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    ),
                    Text(
                      dateFormat(_uvTime),
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
                      "UV Max Time",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    ),
                    Text(
                      dateFormat(_uvMaxTime),
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
                      "Ozone Time",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Minecraft",
                          fontSize: 20),
                    ),
                    Text(
                      // openUVResult.uvMaxTime.toString(),
                      dateFormat(_ozoneTime),
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
