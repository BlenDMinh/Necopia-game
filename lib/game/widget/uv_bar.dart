import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/environment_controller.dart';

class UVBar extends StatelessWidget {
  UVBar({super.key});

  final environmentController = Get.find<IEnvironmentController>();

  final _uvString = ["Low", "Moderarte", "High", "Very high", "Extreme"];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Environment?>(
        stream: environmentController.stream,
        builder: (context, snapshot) {
          num uvIndex = 0;
          num uvMax = 0;
          EnvUv uv = EnvUv.low;
          debugPrint(snapshot.data.toString());
          if (snapshot.data != null) {
            if (snapshot.data!.openUvResult != null) {
              uvIndex = snapshot.data!.openUvResult!.uv;
              uvMax = snapshot.data!.openUvResult!.uvMax;
            }
            uv = snapshot.data!.uv;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icon/uv.png",
                filterQuality: FilterQuality.none,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              Text(
                  "UV: ${uvIndex.toStringAsFixed(2)} / ${uvMax.toStringAsFixed(2)} | ",
                  style: TextStyle(
                    fontFamily: "Pixelate",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 13,
                    color: Colors.white,
                  )),
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(0, 3))
                ]),
                padding: EdgeInsets.all(3),
                child: Text(
                  _uvString[uv.index],
                  style: TextStyle(
                    fontFamily: "",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              )
            ],
          );
        });
  }
}
