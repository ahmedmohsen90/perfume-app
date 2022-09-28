import 'package:dio/dio.dart';

import '../model/search_model.dart';
import '../../../core/helper/network_utils.dart';
import '../../../core/helper/laravel_exception.dart';
import '../../../core/extensions/string.dart';

class SearchRepo {
  static Future<SearchModel?> searchProducts({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'search',
      body: FormData.fromMap(body),
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
      var model = SearchModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException(
        '${'something_wrong'.translate} \n $error',
      );
    }
  }
}
