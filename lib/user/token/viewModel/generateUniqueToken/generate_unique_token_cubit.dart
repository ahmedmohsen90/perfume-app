import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perfume/core/helper/helper.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../repo/generate_unique_token_repo.dart';

part 'generate_unique_token_state.dart';

class GenerateUniqueTokenCubit extends Cubit<GenerateUniqueTokenState> {
  GenerateUniqueTokenCubit() : super(GenerateUniqueTokenInitial());

  Future<void> generateToken() async {
    if (Helper.isLoggedIn) {
      return;
    }
    try {
      var tokenData = await GenerateUniqueTokenRepo.generateToken();
      if (tokenData == null) {
        return;
      }
      if (tokenData.success == true) {
        await GetStorage().write('token', tokenData.data);
      }
    } on LaravelException catch (error) {
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }
}
