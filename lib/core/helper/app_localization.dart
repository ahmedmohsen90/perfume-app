import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

const String _storageKey = "MyApplication_";
const List<Locale> _supportedLanguages = [
  Locale('en', 'US'),
  Locale('ar', 'SA'),
];

class GlobalTranslations {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;
  VoidCallback? _onLocaleChangedCallback;

  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => lang);

  String text(String key) {
    return (_localizedValues == null || _localizedValues?[key] == null)
        ? '$key not found'
        : _localizedValues?[key];
  }

  get currentLanguage => _locale?.languageCode;

  Locale get locale => _locale ?? _supportedLanguages[0];

  Future<void> init([String? language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    // return null;
  }

  getPreferredLanguage() async {
    return _getApplicationSavedInformation('language');
  }

  setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('language', lang);
  }

  Future<void> setNewLanguage(
      [String? newLanguage, bool saveInPrefs = false]) async {
    String? language = newLanguage;
    language ??= await getPreferredLanguage();
    // if (language == null) {
    // }

    if (language == "") {
      language = 'en'; //Platform.localeName.split('_').first;
    }

    _locale = Locale(language!, "");

    String jsonContent =
        await rootBundle.loadString("assets/lang/$language.json");
    _localizedValues = json.decode(jsonContent);

    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }

    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback!();
    }

    // return null;
  }

  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  Future<String> _getApplicationSavedInformation(String name) async {
    return GetStorage().read<String>(_storageKey + name) ?? 'en';
  }

  Future<void> _setApplicationSavedInformation(
      String name, String value) async {
    return await GetStorage().write(_storageKey + name, value);
  }

  static final GlobalTranslations _translations =
      GlobalTranslations._internal();

  factory GlobalTranslations() {
    return _translations;
  }
  GlobalTranslations._internal();
}

GlobalTranslations localization = GlobalTranslations();
