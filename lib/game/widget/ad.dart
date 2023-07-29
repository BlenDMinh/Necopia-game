import 'package:flutter/widgets.dart';
import 'package:necopia/game/necopia_game.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';
import 'package:video_player/video_player.dart';

import '../../widget/pixelate/pixel_button.dart';

class Ad extends StatefulWidget {
  final NecopiaGame game;
  const Ad(this.game, {super.key});

  @override
  State<StatefulWidget> createState() => _AdState();
}

class _AdState extends State<Ad> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/ad/neco-ads.mp4")
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: PixelContainer(
        margin: EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: PixelButton(
                onPressed: () {
                  widget.game.overlays.remove('ad');
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
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Column(children: [
                      Text(
                        "INSERT",
                        style: TextStyle(fontFamily: "Pixelate", fontSize: 70),
                      ),
                      Text(
                        "AD",
                        style: TextStyle(fontFamily: "Pixelate", fontSize: 70),
                      ),
                      Text(
                        "HERE",
                        style: TextStyle(fontFamily: "Pixelate", fontSize: 70),
                      )
                    ]),
            ),
          ],
        ),
      ),
    );
  }
}
