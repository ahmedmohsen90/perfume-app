import '../model/favorites_model.dart';
import '../../../core/helper/network_utils.dart';
import '../../../core/helper/laravel_exception.dart';
import '../../../core/extensions/string.dart';

class FavoritesRepo {
  static Future<MyFavoritesModel?> getFavorites() async {
    final util = NetworkUtil();

    var response = await util.get(
      'wishlists',
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
      var model = MyFavoritesModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException(
        '${'something_wrong'.translate} \n $error',
      );
    }
  }
}
