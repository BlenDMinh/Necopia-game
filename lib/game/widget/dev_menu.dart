import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/environment/air_visual_service.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

import '../../widget/pixelate/pixel_button.dart';

class _AutoUpdateSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AutoUpdateSwitchState();
}

class _AutoUpdateSwitchState extends State<_AutoUpdateSwitch> {
  final environmentController = Get.find<IEnvironmentController>();
  @override
  Widget build(BuildContext context) {
    bool updateStatus = environmentController.updateStatus;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Update:",
          style: TextStyle(fontFamily: "Minecraft"),
        ),
        TextButton(
            onPressed: () {
              environmentController.setUpdate(!updateStatus);
              setState(() {});
            },
            child: Text(
              updateStatus ? "ON" : "OFF",
              style: const TextStyle(
                  fontFamily: "Minecraft",
                  color: primaryPurpleDarker,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}

class _TimeSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<_TimeSlider> {
  final environmentController = Get.find<IEnvironmentController>();

  @override
  Widget build(BuildContext context) {
    Environment env = environmentController.currentEnvironment;
    return Row(
      children: [
        const Text(
          "Time:",
          style: TextStyle(fontFamily: "Minecraft"),
        ),
        Slider(
          value: env.time.index.toDouble(),
          max: EnvTime.values.length.toDouble() - 1,
          divisions: EnvTime.values.length - 1,
          onChanged: (value) {
            int index = value.toInt();
            env.time = EnvTime.values[index];
            environmentController.updateEnv(env);
            setState(() {});
          },
          activeColor: primaryPurple,
          inactiveColor: primaryPurpleLighter.withOpacity(0.6),
        )
      ],
    );
  }
}

class _UvSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UvSliderState();
}

class _UvSliderState extends State<_UvSlider> {
  final environmentController = Get.find<IEnvironmentController>();
  @override
  Widget build(BuildContext context) {
    Environment env = environmentController.currentEnvironment;
    return Row(
      children: [
        const Text(
          "UV:",
          style: TextStyle(fontFamily: "Minecraft"),
        ),
        Slider(
          value: env.uv.index.toDouble(),
          max: EnvUv.values.length.toDouble() - 1,
          divisions: EnvUv.values.length - 1,
          onChanged: (value) {
            int index = value.toInt();
            env.uv = EnvUv.values[index];
            environmentController.updateEnv(env);
            setState(() {});
          },
          activeColor: primaryPurple,
          inactiveColor: primaryPurpleLighter.withOpacity(0.6),
        )
      ],
    );
  }
}

class _AirSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AirSliderState();
}

class _AirSliderState extends State<_AirSlider> {
  final environmentController = Get.find<IEnvironmentController>();
  @override
  Widget build(BuildContext context) {
    Environment env = environmentController.currentEnvironment;
    return Row(
      children: [
        const Text(
          "Air:",
          style: TextStyle(fontFamily: "Minecraft"),
        ),
        Slider(
          value: env.airQuality.index.toDouble(),
          max: AirQuality.values.length.toDouble() - 1,
          divisions: AirQuality.values.length - 1,
          onChanged: (value) {
            int index = value.toInt();
            env.airQuality = AirQuality.values[index];
            environmentController.updateEnv(env);
            setState(() {});
          },
          activeColor: primaryPurple,
          inactiveColor: primaryPurpleLighter.withOpacity(0.6),
        )
      ],
    );
  }
}

class _WeatherSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherSliderState();
}

class _WeatherSliderState extends State<_WeatherSlider> {
  final environmentController = Get.find<IEnvironmentController>();
  @override
  Widget build(BuildContext context) {
    Environment env = environmentController.currentEnvironment;
    return Row(
      children: [
        const Text(
          "Weather:",
          style: TextStyle(fontFamily: "Minecraft"),
        ),
        Slider(
          value: env.weather.index.toDouble(),
          max: EnvWeather.values.length.toDouble() - 1,
          divisions: EnvWeather.values.length - 1,
          onChanged: (value) {
            int index = value.toInt();
            env.weather = EnvWeather.values[index];
            environmentController.updateEnv(env);
            setState(() {});
          },
          activeColor: primaryPurple,
          inactiveColor: primaryPurpleLighter.withOpacity(0.6),
        )
      ],
    );
  }
}

class DevMenu extends StatelessWidget {
  final NecopiaGame game;
  DevMenu(this.game, {super.key});

  final environmentController = Get.find<IEnvironmentController>();

  @override
  Widget build(BuildContext context) {
    return PixelContainer(
      margin: EdgeInsets.all(32.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: PixelButton(
              onPressed: () {
                game.overlays.remove('dev');
              },
              aspect: PixelButtonAspect.oneOne,
              width: 40,
              child: Text(
                "X",
                style: TextStyle(
                  fontFamily: "Pixelate",
                ),
              ),
            ),
          ),
          _AutoUpdateSwitch(),
          _TimeSlider(),
          _UvSlider(),
          _AirSlider(),
          _WeatherSlider(),
          PixelButton(
            onPressed: () {
              environmentController.forceUpdate();
            },
            aspect: PixelButtonAspect.sixOne,
            child: Text("Force update",
                style: TextStyle(fontFamily: "Pixelate", color: Colors.white)),
          )
        ],
      ),
    );
  }
}
