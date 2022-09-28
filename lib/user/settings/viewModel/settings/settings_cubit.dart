import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../model/settings_model.dart';
import '../../repo/settings_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  SettingsData? _settingsData;
  SettingsData? get settingsData => _settingsData;

  Future<void> getSettingsData() async {
    emit(SettingsLoading());

    try {
      var settingsData = await SettingsRepo.getSettings();
      if (settingsData == null) {
        emit(SettingsError());
        return;
      }
      if (settingsData.success == true) {
        _settingsData = settingsData.data;
        emit(SettingsDone());
      } else {
        emit(SettingsError());
      }
    } on LaravelException catch (error) {
      emit(SettingsError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }
}
