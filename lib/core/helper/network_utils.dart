import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './helper.dart';
// import 'helper.dart';

class NetworkUtil {
  // ignore: prefer_final_fields
  static NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();

  Future<Response?> get(
    String url, {
    BuildContext? context,
    String? specificLangCode,
    Map? headers,
    bool withHeader = true,
    bool useDefaultDomain = true,
  }) async {
    log('url is $url token ${Helper.token}');
    Response? response;
    log('lang ${specificLangCode ?? Helper.currentLanguage}');
    try {
      if (useDefaultDomain) {
        dio.options.baseUrl = Helper.appDomain;
      }
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      response = await dio.get(url,
          options: Options(
              headers: withHeader
                  ? {
                      // if (Helper.isLoggedIn) ...{
                      // },
                      HttpHeaders.authorizationHeader:
                          Helper.isLoggedIn ? 'Bearer ${Helper.token}' : '',

                      // HttpHeaders.contentTypeHeader: 'application/json',
                      // HttpHeaders.acceptHeader: 'application/json',
                      'Accept-Language':
                          specificLangCode ?? Helper.currentLanguage,
                    }
                  : headers == null
                      ? null
                      : headers as Map<String, dynamic>));
    } on DioError catch (e) {
      log('Error is : ${e.message}');
      response = e.response;

      // var prefs = context.read(sharedPreferences).prefs;
      // var _prefs = prefs;
      // if (e.response != null) {
      //   if (e.response.statusCode >= 500) {
      //     log('ssgggdsdsdsd yup');

      //     await N.replaceAll(
      //       const SplashScreen(),
      //     );
      //     log('ssgggdsdsdsd yup');
      //     await _prefs.clear().then((value) => log('done'));
      //     Phoenix.rebirth(context);
      //   }
      //   response = e.response;
      //   log("response bbb: " + e.response.toString());
      // } else {}
    }
    return response == null ? null : handleResponse(response, url);
  }

  Future<Response?> post(
    String url, {
    // BuildContext? context,
    Map? headers,
    FormData? body,
    bool withHeader = true,
    encoding,
  }) async {
    log('url is $url token ${Helper.token}');

    Response? response;

    dio.options.baseUrl = Helper.appDomain;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    try {
      response = await dio.post(url,
          data: body,
          options: Options(
              headers: withHeader
                  ? {
                      HttpHeaders.authorizationHeader:
                          Helper.isLoggedIn ? 'Bearer ${Helper.token}' : '',

                      // if (Helper.isLoggedIn) ...{
                      //   HttpHeaders.authorizationHeader:
                      //       'Bearer ${Helper.currentUser?.accessToken}',
                      // },

                      // HttpHeaders.contentTypeHeader: 'application/json',
                      // HttpHeaders.acceptHeader: 'application/json',
                      'Accept-Language': Helper.currentLanguage,
                    }
                  : headers == null
                      ? null
                      : headers as Map<String, dynamic>,
              requestEncoder: encoding));
    } on DioError catch (e) {
      log(' from post ${e.error} + message ${e.message}');
      if (e.response != null) {
        log('$url response : => ${e.response?.data}');
        response = e.response;
      }
      // var prefs = context.read(sharedPreferences).prefs;

      // var _prefs = prefs;
      // if (e.response != null) {
      //   if (e.response.statusCode >= 500) {
      //     log('ssdsdsdsd yup');
      //     await N.replaceAll(
      //       const SplashScreen(),
      //     );
      //     await _prefs.clear().then((value) => log('done'));
      //     Phoenix.rebirth(context);
      //   }
      //   response = e.response;
      //   log("response bb: " + e.response.toString());
      // } else {}
    }
    return response == null ? null : handleResponse(response, url);
  }

  Future<Response?> handleResponse(Response response, String url) async {
    final int? statusCode = response.statusCode;
    log("$url response: ..." + response.toString());
    if (response.statusCode! >= 500 || response.data['success'] != null) {
      log('ssdsdsdsd yup');
      // if (response.data.runtimeType == String &&
      //     (response.data['message'] as String)
      //         .toLowerCase()
      //         .contains('token')) {
      //   await GetStorage().remove('user');
      //   Phoenix.rebirth(context!);
      //   NavigationService.pushAndRemoveUntil(
      //     page: const SplashScreen(),
      //     predicate: (_) => false,
      //   );
      //   return null;
      // }
    }
    // Future.delayed(const Duration(milliseconds: 1), () async {
    //   var _prefs = context.read(sharedPreferences).prefs;
    //   if (response.statusCode >= 500 || response.data['success'] != null) {
    //     log('ssdsdsdsd yup');
    //     if ((response.data['message'] as String)
    //         .toLowerCase()
    //         .contains('token')) {
    //       await _prefs.remove('user').then((value) => log('done'));
    //       Phoenix.rebirth(context);
    //       N.replaceAll(
    //         const SplashScreen(),
    //       );
    //       return;
    //     }
    //   }
    // });
    if (statusCode! >= 200 && statusCode < 300) {
      return response;
    } else {
      return response;
    }
  }
}
