import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../model/products_by_category_model.dart';
import '../../repo/products_by_category_repo.dart';

part 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  ProductsByCategoryCubit({
    required this.categorySlug,
    required this.categoryName,
  }) : super(ProductsByCategoryInitial());
  final String categorySlug;
  final String categoryName;

  List<CategoryProducts>? _categoryProducts = [];
  List<CategoryProducts> get categoryProducts => [...?_categoryProducts];
  int _page = 1;
  bool _hasNext = false;
  var scrollController = ScrollController();

  Future<void> getProductsByCategory() async {
    emit(_page > 1
        ? ProductsByCategoryLoadingMore()
        : ProductsByCategoryLoading());
    try {
      var productsCategoryData = await ProductsByCategoryRepo.getProducts(
        page: _page,
        categorySlug: categorySlug,
      );
      if (productsCategoryData == null) {
        emit(ProductsByCategoryError());
        return;
      }
      if (productsCategoryData.success == true) {
        if (_page > 1) {
          _categoryProducts?.addAll(productsCategoryData.data!.map((e) => e));
        } else {
          _categoryProducts = productsCategoryData.data;
        }
        _hasNext = (productsCategoryData.paginate?.hasPages ?? false);
        if (_hasNext) {
          _page++;
        }
        emit(ProductsByCategoryDone());
      }
    } on LaravelException catch (error) {
      emit(ProductsByCategoryError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }

  void initScroll() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getProductsByCategory();
    }
  }

  @override
  Future<void> close() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    return super.close();
  }

  void changeFavStatus({required int productId}) {
    var index =
        _categoryProducts?.indexWhere((element) => element.id == productId) ??
            -1;
    if (index < 0) {
      return;
    }
    _categoryProducts?[index].inWishlist =
        !(_categoryProducts?[index].inWishlist ?? false);
    emit(
      CategoryProductFavStateChanged(
        product: _categoryProducts![index],
      ),
    );
  }
}
