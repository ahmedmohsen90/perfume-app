import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/user/addresses/repo/create_new_address_repo.dart';
import 'package:perfume/user/checkout/viewModel/checkout/checkout_cubit.dart';

import '../myAddress/my_address_cubit.dart';

part 'create_new_address_state.dart';

class CreateNewAddressCubit extends Cubit<CreateNewAddressState> {
  CreateNewAddressCubit() : super(CreateNewAddressInitial());
  Future<void> addNewAddress(BuildContext context) async {
    var validate = formKey.currentState!.validate();
    if (!validate) {
      return;
    }
    var addressCubit = context.read<MyAddressCubit>();
    var checkoutCubit = context.read<CheckoutCubit>();
    FocusManager.instance.primaryFocus?.unfocus();

    emit(CreateNewAddressLoading());

    var addNewAddressData = await CreateNewAddressesRepo.getMyAddresses(
      body: {
        'title': titleController.text,
        'name': nameController.text,
        'area_id': areaId,
        'block': blockController.text,
        'email': emailController.text,
        'street': streetController.text,
        'apartment_no': apartmentController.text,
        'mobile': mobileController.text,
      },
    );

    if (addNewAddressData == null) {
      Fluttertoast.showToast(
        msg: 'network'.translate,
        backgroundColor: Colors.red,
      );
      emit(CreateNewAddressError());
      return;
    }

    if (addNewAddressData.success == true) {
      addressCubit.addNewAddress(
        addNewAddressData.data!.toJson(),
        addressId: addNewAddressData.data?.id,
      );
      if (addressCubit.addresses.length == 1) {
        checkoutCubit.getDeliveryPrice(addressId: addNewAddressData.data?.id ?? 0);
      }
      emit(CreateNewAddressDone());
      NavigationService.goBack();
    } else {
      Fluttertoast.showToast(
        msg: addNewAddressData.message ?? ('something_wrong').translate,
      );
      emit(CreateNewAddressError());
    }
  }

  String? areaValidate(int? v) {
    if (v == null) {
      return ('area_required').translate;
    }
    return null;
  }

  String? titleValidate(String? v) {
    if (v!.isEmpty) {
      return ('title_required').translate;
    }
    return null;
  }

  String? cityValidate(int? v) {
    if (v == null) {
      return ('city_required').translate;
    }
    return null;
  }

  String? emailValidate(String? v) {
    if (v!.isEmpty) {
      return ('email_required').translate;
    }
    return null;
  }

  String? nameValidate(String? v) {
    if (v!.isEmpty) {
      return ('name_required').translate;
    }
    return null;
  }

  String? mobileValidate(String? v) {
    if (v!.isEmpty) {
      return ('mobile_required').translate;
    }
    return null;
  }

  String? streetValidate(String? v) {
    if (v!.isEmpty) {
      return ('street_required').translate;
    }
    return null;
  }

  String? blockValidate(String? v) {
    if (v!.isEmpty) {
      return ('block_required').translate;
    }
    return null;
  }

  String? apartmentValidate(String? v) {
    if (v!.isEmpty) {
      return ('apartment_required').translate;
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  var blockController = TextEditingController();
  var streetController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var apartmentController = TextEditingController();
  var mobileController = TextEditingController();
  var titleController = TextEditingController();
  int? cityId, areaId;
  int cityIndex = 0;
  @override
  Future<void> close() {
    titleController.dispose();
    blockController.dispose();
    streetController.dispose();
    nameController.dispose();
    emailController.dispose();
    apartmentController.dispose();
    mobileController.dispose();
    return super.close();
  }
}
