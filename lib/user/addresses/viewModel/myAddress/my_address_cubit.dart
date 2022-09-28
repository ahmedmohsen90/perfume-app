import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import '../../model/my_address_model.dart';
import '../../repo/my_address_repo.dart';

part 'my_address_state.dart';

class MyAddressCubit extends Cubit<MyAddressState> {
  MyAddressCubit() : super(MyAddressInitial());

  Future<void> getAddresses() async {
    emit(MyAddressLoading());
    try {
      var addressData = await MyAddressesRepo.getMyAddresses();

      if (addressData == null) {
        emit(MyAddressError());
        return;
      }
      if (addressData.success == true) {
        _addresses = addressData.data;
        emit(MyAddressDone());
      } else {
        emit(MyAddressError());
      }
    } on LaravelException catch (error) {
      emit(MyAddressError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }

  List<Address>? _addresses = [];
  int _selectedAddress = 0;
  List<Address> get addresses => [...?_addresses];
  int get selectedAddress => _selectedAddress;

  void addNewAddress(
    Map<String, dynamic> json, {
    required addressId,
  }) {
    var address = Address.fromJson(json);
    _addresses?.add(address);
    emit(
      NewAddressAdded(
        address: address,
      ),
    );
  }

  void onRadioChanged(
    int? selectedIndex,
  ) {
    if (selectedIndex == null) {
      return;
    }
    _selectedAddress = selectedIndex;
    emit(RadioButtonChanged(
      index: selectedIndex,
    ));
  }
}
