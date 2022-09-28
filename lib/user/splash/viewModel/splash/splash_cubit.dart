import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  VideoPlayerController playerController = VideoPlayerController.asset(
    'assets/video/splash_video.mp4',
  );
  Stopwatch stopwatch = Stopwatch();

  Future<void> initVideoController() async {
    stopwatch.start();
    emit(Initializing());
    await playerController.initialize();
    playerController.play();
    stopwatch.stop();
    log('time ${stopwatch.elapsed.inSeconds}');
    emit(Initialized());
  }
}
