import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../model/cities_model.dart';
import '../../repo/cities_repo.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(CitiesInitial());

  Future<void> getCities() async {
    emit(CitiesLoading());

    try {
      var citiesData = await CitiesRepo.cities();
      if (citiesData == null) {
        emit(CitiesError());
        return;
      }
      if (citiesData.success == true) {
        _cities = citiesData.data;
        emit(CitiesDone());
      } else {
        emit(CitiesError());
      }
    } on LaravelException catch (error) {
      emit(CitiesError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  List<Cities>? _cities = [];
  List<Cities> get cities => [...?_cities];
}
