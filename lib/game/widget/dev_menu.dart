import 'package:flutter/widgets.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

class DevMenu extends StatelessWidget {
  final NecopiaGame game;
  const DevMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return PixelContainer(
      child: Text("For dev"),
    );
  }
}
