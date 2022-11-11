import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import '../../common/contants/color_contants.dart';

import '../../common/widgets/app_bar.dart';

// ignore: must_be_immutable
class PlayVideoScreen extends StatefulWidget {
  String videoPath;

  PlayVideoScreen(this.videoPath, {Key? key}) : super(key: key);

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  VideoPlayerController? playerController;

  @override
  void dispose() {
    super.dispose();
    if (playerController != null) {
      playerController!.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    print("videopath--->${widget.videoPath}");
    playerController = VideoPlayerController.network(widget.videoPath)
      ..initialize().then((_) => setState(() {}));
    playerController!.setVolume(1.0);
    playerController!.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 100,
          color: ColorConstants.appColor,
          margin: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: CommonAppBar(title: "Video"),
        ),
        Center(
          child: (playerController != null)
              ? (playerController!.value.isInitialized)
                  ? Center(
                      child: Stack(
                        children: [
                          AspectRatio(
                              aspectRatio: 9 / 5,
                              child: VideoPlayer(playerController!)),
                          Positioned(
                              top: 40,
                              bottom: 40,
                              right: 40,
                              left: 40,
                              child: Center(
                                child: FloatingActionButton(
                                  onPressed: () => videoPlayButtonOnTap(),
                                  child: (playerController!.value.isPlaying)
                                      ? const Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                ),
                              )),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.appColor,
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.appColor,
                  ),
                ),
        ),
      ]),
    );
  }

  Future<void> videoPlayButtonOnTap() async {
    if (playerController!.value.isPlaying) {
      await playerController!.pause();
    } else {
      await playerController!.play();
    }
    setState(() {});
  }
}
