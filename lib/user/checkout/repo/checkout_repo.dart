import 'package:dio/dio.dart';

import '../model/checkout_model.dart';
import '../../../core/helper/laravel_exception.dart';
import '../../../core/helper/network_utils.dart';
import '../../../core/extensions/string.dart';

class CheckoutRepo {
  static Future<CheckoutModel?> checkout({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();
    var response = await util.post(
      'checkout',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }

    var statusCode = response.statusCode ?? 0;

    if (statusCode >= 500 || statusCode == 404) {
      throw LaravelException(
        '${'something_wrong'.translate} \n${statusCode >= 500 ? 'Server Error' : 'Not Found'}',
      );
    }
    try {
      var model = CheckoutModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException(
        '${'something_wrong'.translate} \n$error',
      );
    }
  }
}
