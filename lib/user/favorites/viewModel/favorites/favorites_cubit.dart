import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import 'package:perfume/user/categories/viewModel/productsByCategory/products_by_category_cubit.dart';
import 'package:perfume/user/home/viewModel/home/home_cubit.dart';
import 'package:perfume/user/search/viewModel/searchProducts/search_products_cubit.dart';
import '../../model/favorites_model.dart';
import '../../repo/my_favorites_repo.dart';
import '../../repo/toggle_product_repo.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  List<FavProducts>? _favProducts = [];
  int _page = 1;
  bool _hasNext = false;
  List<FavProducts> get favProducts => [...?_favProducts];
  int get favListCount => _favProducts?.length ?? 0;
  var scrollController = ScrollController();

  void initController() => scrollController.addListener(_onScroll);

  void _onScroll() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getFavList(
        isInit: false,
      );
    }
  }

  Future<void> getFavList({
    bool isInit = true,
  }) async {
    if (isInit) {
      _page = 1;
      _hasNext = false;
      _favProducts?.clear();
    }
    emit(_page > 1 ? FavoritesLoadingMore() : FavoritesLoading());
    try {
      var favData = await FavoritesRepo.getFavorites();
      if (favData == null) {
        emit(FavoritesError());
        return;
      }
      if (favData.success == true) {
        if (_page > 1) {
          _favProducts?.addAll(favData.data!.map((e) => e));
        } else {
          _favProducts = favData.data;
        }
        _hasNext = (favData.paginate?.hasPages ?? false);
        if (_hasNext) {
          _page++;
        }
        emit(FavoritesDone());
      }
    } on LaravelException catch (error) {
      emit(FavoritesError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }

  void toggleProduct({
    required BuildContext context,
    @required int? productId,
    required Map<String, dynamic> productJson,
  }) async {
    var productIndex =
        _favProducts?.indexWhere((element) => element.id == productId) ?? -1;
    var productData = FavProducts.fromJson(productJson);
    var hasProduct = productIndex >= 0;

    if (hasProduct) {
      _favProducts?.removeAt(productIndex);
    } else {
      _favProducts?.add(productData);
    }
    emit(ToggleProductDone(productId: productId ?? 0));
    _changeFavData(context: context, productId: productId ?? 0);

    try {
      var toggleData = await ToggleProductRepo.toggleProduct(body: {
        'product_id': productId,
      });
      if (toggleData == null || toggleData.success == false) {
        if (hasProduct) {
          _favProducts?.add(productData);
        } else {
          _favProducts?.removeAt(productIndex);
        }
        emit(ToggleProductError(productId: productId ?? 0));
        _changeFavData(context: context, productId: productId ?? 0);
      }
    } on LaravelException catch (error) {
      if (hasProduct) {
        _favProducts?.add(productData);
      } else {
        _favProducts?.removeAt(productIndex);
      }
      emit(ToggleProductError(productId: productId ?? 0));
      _changeFavData(context: context, productId: productId ?? 0);

      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Future<void> close() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    return super.close();
  }

  void _changeFavData({
    required BuildContext context,
    required int productId,
  }) {
    try {
      context.read<HomeCubit>().changeFavStatus(
            productId: productId,
          );
    } catch (error) {
      log('homeCubit $error');
    }
    try {
      context.read<ProductsByCategoryCubit>().changeFavStatus(
            productId: productId,
          );
    } catch (error) {
      log('ProductsByCategoryCubit $error');
    }
    try {
      context.read<SearchProductsCubit>().changeFavStatus(
            productId: productId,
          );
    } catch (error) {
      log('SearchProductsCubit $error');
    }
  }
}
