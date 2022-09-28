import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../model/all_categories_model.dart';
import '../../repo/categories_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      var categoriesData = await CategoriesRepo.getCategories();
      if (categoriesData == null) {
        emit(CategoriesError());
        return;
      }

      if (categoriesData.success == true) {
        _categories = categoriesData.data;
        emit(CategoriesDone());
      } else {
        emit(CategoriesError());
      }
    } on LaravelException catch (error) {
      emit(CategoriesError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }

  List<Categories>? _categories = [];
  List<Categories> get categories => [...?_categories];
}
