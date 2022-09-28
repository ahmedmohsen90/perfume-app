import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perfume/core/extensions/string.dart';

import '../components/sized_box_helper.dart';
import '../themes/themes.dart';
import './app_localization.dart';

class Helper {
  static String get currentLanguage => localization.currentLanguage.toString();
  static bool get isArabic => currentLanguage == 'ar';
  static Alignment get appAlignment =>
      isArabic ? Alignment.centerRight : Alignment.centerLeft;
  static bool get isLoggedIn => GetStorage().hasData('token');
  static String get token => GetStorage().read<String>('token') ?? '';
  static String get appDomain => 'https://ghayorofficial.com/api/';

  static DataColumn buildColumn({required String title}) => DataColumn(
        label: Text(
          title.isEmpty ? '' : title.translate,
          style: MainTheme.headerStyle3.copyWith(
            color: Colors.white,
          ),
        ),
      );
  static DataCell buildCell({
    Widget? child,
    String? title,
  }) =>
      DataCell(
        title != null
            ? Text(
                title,
                style: MainTheme.headerStyle3.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              )
            : child ?? const BoxHelper(),
      );
}
