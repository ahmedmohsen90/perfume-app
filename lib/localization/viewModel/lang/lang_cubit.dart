import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perfume/core/helper/helper.dart';
import 'package:perfume/user/home/view/home_screen.dart';
import '../../../core/helper/navigator.dart';

import '../../../../core/helper/app_localization.dart';
import '../../model/language_model.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());
  Future<void> _changeLanguage({
    required BuildContext context,
  }) async {
    emit(
      LoadingState(),
    );
    await GetStorage().write(
      'language',
      _currentLanguage,
    );

    await GetStorage().write(
      'lang',
      true,
    );
    await localization.setNewLanguage(
      _currentLanguage,
      true,
    );
    emit(
      ChosenLanguage(
        language: _currentLanguage,
      ),
    );
    // var canPop = context.router.canNavigateBack;
    Phoenix.rebirth(context);
    await NavigationService.goBack();
    NavigationService.pushReplacementAll(
      page: HomeScreen.routeName,
    );
  }

  String _currentLanguage = localization.currentLanguage.toString();
  String get currentLanguage => _currentLanguage;

  void chooseLanguage({
    required String? code,
    required BuildContext context,
  }) {
    if (code == null || code == Helper.currentLanguage) {
      // NavigationService.goBack();
      return;
    }
    _currentLanguage = code;
    emit(
      ChosenLanguage(
        language: code,
      ),
    );
    _changeLanguage(
      context: context,
    );
  }

  List<Languages> langs = [
    Languages(
      language: 'العربية',
      code: 'ar',
      flag: 'assets/icons/lang/arabic.png',
    ),
    Languages(
      language: 'English',
      code: 'en',
      flag: 'assets/icons/lang/english.png',
    ),
  ];
}
