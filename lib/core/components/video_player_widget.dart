import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './video_player_full_screen.dart';
import '../helper/navigator.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);
  final String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isInit = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((value) {
        setState(() {
          Future.delayed(const Duration(seconds: 1), () {
            _controller.play();
          });
          _controller.setVolume(0);
        });
      });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      // _controller.play();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_controller.value.isInitialized
        ? SpinKitFadingCircle(
            color: Theme.of(context).primaryColor,
          )
        : InkWell(
            onTap: () {
              // NavigationService.push(
              //   isNamed: false,
              //   page: VideoPlayerFullScreen(
              //     controller: _controller,
              //   ),
              // );
            },
            child: VideoPlayer(
              _controller,
            ),
            // child: FlickVideoPlayer(
            //   flickManager: FlickManager(
            //     videoPlayerController: _controller,
            //   ),
            // ),
          );
  }
}
