import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:equatable/equatable.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import 'package:video_player/video_player.dart';

import '../../../settings/viewModel/settings/settings_cubit.dart';
import '../../model/home_model.dart';
import '../../repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHome({
    required BuildContext context,
  }) async {
    emit(HomeLoading());

    try {
      await context.read<SettingsCubit>().getSettingsData();
      var homeData = await HomeRepo.home();
      if (homeData == null) {
        emit(HomeError());
        return;
      }
      if (homeData.success == true) {
        var data = homeData.data;
        _sliders = data?.sliders;
        _categories = data?.categories;
        _suggestProducts = data?.suggestProducts;
        _bestSellerProducts = data?.bestSellerProducts;
        emit(HomeDone());
        Future.delayed(const Duration(milliseconds: 20), () {
          initVideoController();
        });
      }
    } on LaravelException catch (error) {
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
      emit(HomeError());
    }
  }

  List<Sliders>? _sliders = [];
  List<Sliders> get sliders => [...?_sliders];
  List<Category>? _categories = [];
  List<Category> get categories => [...?_categories];
  List<Product>? _suggestProducts = [];
  List<Product> get suggestProducts => [...?_suggestProducts];
  List<Product>? _bestSellerProducts = [];
  List<Product> get bestSellerProducts => [...?_bestSellerProducts];
  int currentPage = 0;
  VideoPlayerController? controller;
  FlickManager? flickManager;
  CarouselController carouselController = CarouselController();

  void initVideoController() async {
    controller = VideoPlayerController.network(
      _sliders![currentPage].url!,
    );
    flickManager = FlickManager(
      videoPlayerController: controller!,
    );
    await controller?.play();
    carouselController.startAutoPlay();

    emit(
      VideoStateChanged(
        state: '$currentPage $flickManager',
      ),
    );
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {}

  void changeFavStatus({
    required int productId,
  }) {
    var suggestedIndex =
        _suggestProducts?.indexWhere((element) => element.id == productId) ??
            -1;
    var bestSellerIndex =
        _bestSellerProducts?.indexWhere((element) => element.id == productId) ??
            -1;
    if (bestSellerIndex < 0 && suggestedIndex < 0) {
      return;
    }

    if (suggestedIndex >= 0) {
      _suggestProducts![suggestedIndex].inWishlist =
          !(_suggestProducts![suggestedIndex].inWishlist ?? false);
      emit(HomeFavStateChanged(
        product: _suggestProducts![suggestedIndex],
      ));
    }
    if (bestSellerIndex >= 0) {
      _bestSellerProducts![suggestedIndex].inWishlist =
          !(_bestSellerProducts![suggestedIndex].inWishlist ?? false);
      emit(HomeFavStateChanged(
        product: _bestSellerProducts![suggestedIndex],
      ));
    }
  }
}
