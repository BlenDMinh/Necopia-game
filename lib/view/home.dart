import 'package:flutter/material.dart';
import 'package:necopia/game/necopia_game.dart';

class Home extends StatelessWidget {
  static Home _instance = Home._();
  const Home._({super.key});
  factory Home({Key? key}) {
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: necopiaGameWidget,
    );
  }
}
