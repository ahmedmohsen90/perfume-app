import '../../../core/helper/network_utils.dart';
import '../../../core/helper/laravel_exception.dart';
import '../../../core/extensions/string.dart';
import '../model/products_by_category_model.dart';

class ProductsByCategoryRepo {
  static Future<ProductsByCategoryModel?> getProducts({
    required int page,
    required String? categorySlug,
  }) async {
    final util = NetworkUtil();

    var response = await util.get(
      'categories/$categorySlug?page=$page',
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
      var model = ProductsByCategoryModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException(
        '${'something_wrong'.translate} \n $error',
      );
    }
  }
}
