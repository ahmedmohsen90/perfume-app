import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../model/areas_model.dart';
import '../../repo/area_repo.dart';

part 'areas_state.dart';

class AreasCubit extends Cubit<AreasState> {
  AreasCubit() : super(AreasInitial());

  Future<void> getAreasByCityId({
    @required int? cityId,
  }) async {
    _areas?.clear();
    emit(AreasLoading());
    try {
      var areasData = await AreasRepo.areas(
        cityId: cityId,
      );
      if (areasData == null) {
        emit(AreasError());
        return;
      }
      if (areasData.success == true) {
        _areas = areasData.data;
        emit(AreasDone());
      } else {
        emit(AreasError());
      }
    } on LaravelException catch (error) {
      emit(AreasError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }

  List<Area>? _areas = [];
  List<Area> get areas => [...?_areas];
}
