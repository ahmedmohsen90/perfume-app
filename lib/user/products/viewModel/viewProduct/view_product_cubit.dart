import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../model/view_product_model.dart';
import '../../repo/view_product_repo.dart';

part 'view_product_state.dart';

class ViewProductCubit extends Cubit<ViewProductState> {
  ViewProductCubit({
    required this.productSlug,
  }) : super(ViewProductInitial());
  final String productSlug;

  Future<void> viewProduct() async {
    emit(ViewProductLoading());
    try {
      var viewData = await ViewProductRepo.viewProducts(
        productSlug: productSlug,
      );
      if (viewData == null) {
        emit(ViewProductError());
        return;
      }
      if (viewData.success == true) {
        _productData = viewData.data;
        emit(ViewProductDone());
      } else {
        emit(ViewProductError());
      }
    } on LaravelException catch (error) {
      emit(ViewProductError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }

  ProductData? _productData;
  int _page = 0;
  int _quantity = 1;
  int _miniScrollIndex = 0;
  ProductData? get productData => _productData;
  int get page => _page;
  int get quantity => _quantity;
  double get differenceBetweenPrice =>
      (double.tryParse(_productData?.oldPrice ?? '') ?? 0) -
      (double.tryParse(_productData?.newPrice ?? '') ?? 0);
  double get differencePercentage =>
      (differenceBetweenPrice /
          ((double.tryParse(_productData?.oldPrice ?? '') ?? 0))) *
      100;
  ItemScrollController itemScrollController = ItemScrollController();
  CarouselController carouselController = CarouselController();

  void onPageChanged(
    int index,
  ) {
    log('index $index');
    // carouselController.animateToPage(index);
    itemScrollController.jumpTo(
      index: index,
      // duration: const Duration(
      //   milliseconds: 200,
      // ),
    );
    _page = index;
    emit(
      ImagePaginated(
        index: index,
      ),
    );
  }

  void onScrollChanged(
    int index,
  ) {
    log('index $index');
    carouselController.animateToPage(index);
    itemScrollController.isAttached;
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInOut);
    _page = index;
    emit(
      ImagePaginated(
        index: index,
      ),
    );
  }

  void next() {
    if (_miniScrollIndex < _productData!.images!.length) {
      _miniScrollIndex++;
      scrollTo();
    }
  }

  void prev() {
    if (_miniScrollIndex > 0) {
      _miniScrollIndex--;
      scrollTo();
    }
  }

  Future<void> scrollTo() {
    return itemScrollController.scrollTo(
      index: _miniScrollIndex,
      duration: Duration(milliseconds: 1),
    );
  }

  void changeQuantity({
    bool increment = true,
  }) {
    if (increment) {
      _quantity++;
    } else if (!increment && _quantity > 1) {
      _quantity--;
    }
    emit(QuantityChanged(
      quantity: _quantity,
    ));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
