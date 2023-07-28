import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

class UVBar extends StatelessWidget {
  UVBar({super.key});

  final environmentController = Get.find<IEnvironmentController>();

  final _uvString = ["Low", "Moderarte", "High", "Very high", "Extreme"];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Environment?>(
        stream: environmentController.stream,
        builder: (context, snapshot) {
          double uvIndex = 0;
          double uvMax = 0;
          EnvUv uv = EnvUv.low;
          if (snapshot.data != null) {
            if (snapshot.data!.openUvResult != null) {
              uvIndex = snapshot.data!.openUvResult!.uv;
              uvMax = snapshot.data!.openUvResult!.uvMax;
              uv = snapshot.data!.uv;
            }
          }
          return PixelContainer(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/icon/uv.png",
                  filterQuality: FilterQuality.none,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                Row(
                  children: [
                    Text(
                      "UV: ${uvIndex.toStringAsFixed(2)} / ${uvMax.toStringAsFixed(2)} | ",
                      style: TextStyle(
                        fontFamily: "Minecraft",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      _uvString[uv.index].padLeft(14),
                      style: TextStyle(
                        fontFamily: "Minecraft",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
