import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../model/search_model.dart';
import '../../repo/search_repo.dart';

part 'search_products_state.dart';

class SearchProductsCubit extends Cubit<SearchProductsState> {
  SearchProductsCubit() : super(SearchProductsInitial());
  List<Result>? _result = [];
  List<Result> get result => [...?_result];

  var keywordController = TextEditingController();

  Future<void> searchProduct() async {
    if (keywordController.text.isEmpty) {
      return;
    }
    _result?.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    emit(SearchProductsLoading());
    try {
      var result = await SearchRepo.searchProducts(body: {
        'word': keywordController.text,
      });
      if (result == null) {
        emit(SearchProductsError());
        return;
      }
      if (result.success == true) {
        _result = result.data;
        emit(SearchProductsDone());
      } else {
        emit(SearchProductsError());
      }
    } on LaravelException catch (error) {
      emit(SearchProductsError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  void changeFavStatus({
    required int productId,
  }) {
    var index = _result?.indexWhere((element) => element.id == productId) ?? -1;
    if (index < 0) {
      return;
    }
    _result?[index].inWishlist = !(_result?[index].inWishlist ?? false);
    emit(ResultProductFavStateChanged(product: _result![index]));
  }

  @override
  Future<void> close() {
    keywordController.dispose();
    return super.close();
  }
}
