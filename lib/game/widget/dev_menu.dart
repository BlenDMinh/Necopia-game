import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

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
              style: TextStyle(fontFamily: "Minecraft"),
            )),
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
        children: [_AutoUpdateSwitch()],
      ),
    );
  }
}
