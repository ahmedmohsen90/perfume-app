import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/helper/network_utils.dart';
import '../../../core/helper/laravel_exception.dart';
import '../../../core/extensions/string.dart';
import '../model/add_to_cart_model.dart';
import '../model/my_cart_model.dart';

class AddToCartRepo {
  static Future<MyCartModel?> addToCart({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'carts/create',
      body: FormData.fromMap(
        body,
      ),
    );

    if (response == null) {
      return null;
    }

    var statusCode = response.statusCode ?? 0;

    if (statusCode >= 500 || statusCode == 404) {
      throw LaravelException(
          '${'something_wrong'.translate} \n ${statusCode >= 500 ? 'Server Error' : 'Not Found'}');
    }
    try {
      var model = MyCartModel.fromJson(response.data);
      return model;
    } catch (error) {
      log(' $error');
      throw LaravelException(
        '${'something_wrong'.translate} \n $error',
      );
    }
  }
}
