import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import '../helper/helper.dart';
import '../helper/navigator.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFullScreen extends StatefulWidget {
  const VideoPlayerFullScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final VideoPlayerController controller;

  @override
  State<VideoPlayerFullScreen> createState() => _VideoPlayerFullScreenState();
}

class _VideoPlayerFullScreenState extends State<VideoPlayerFullScreen> {
  late FlickManager flickManager;
  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: widget.controller,
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            NavigationService.goBack();
          },
          color: Colors.white,
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlickVideoPlayer(
            flickManager: flickManager,
          ),
        ],
      ),
    );
  }
}
