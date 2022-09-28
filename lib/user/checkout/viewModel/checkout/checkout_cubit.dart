import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/user/addresses/viewModel/myAddress/my_address_cubit.dart';
import 'package:perfume/user/checkout/repo/checkout_repo.dart';
import 'package:perfume/user/checkout/view/payment_success_screen.dart';
import 'package:perfume/user/checkout/view/webview_screen.dart';
import 'package:perfume/user/home/view/home_screen.dart';
import '../../repo/delivery_price_repo.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  num? _deliveryPrice;
  String _paymentMethod = 'credit';
  String get paymentMethod => _paymentMethod;
  num get deliveryPrice => _deliveryPrice ?? 0.0;

  void onPaymentMethodChanged(String? v) {
    if (v == null) {
      return;
    }
    _paymentMethod = v;
    emit(PaymentMethodStateChanged(
      method: v,
    ));
  }

  Future<bool> getDeliveryPrice({
    required int addressId,
  }) async {
    emit(GetDeliveryPriceLoading());
    try {
      var deliveryPriceData = await DeliveryPriceRepo.getDeliveryPrice(body: {
        'address_id': addressId,
      });
      if (deliveryPriceData == null) {
        emit(GetDeliveryPriceError());
        Fluttertoast.showToast(
          msg: 'network'.translate,
          backgroundColor: Colors.red,
        );
        return false;
      }
      if (deliveryPriceData.success == true) {
        _deliveryPrice = deliveryPriceData.data;
        emit(GetDeliveryPriceDone());
        return true;
      } else {
        emit(GetDeliveryPriceError());
      }
    } on LaravelException catch (error) {
      emit(GetDeliveryPriceError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
    return false;
  }

  Future<void> checkout(
    BuildContext context,
  ) async {
    emit(CheckoutLoading());
    try {
      var read = context.read<MyAddressCubit>();
      var checkoutData = await CheckoutRepo.checkout(
        body: {
          'payment_method': paymentMethod,
          'address_id': read.addresses[read.selectedAddress].id,
        },
      );
      if (checkoutData == null) {
        emit(CheckoutError());
        Fluttertoast.showToast(
          msg: 'network'.translate,
          backgroundColor: Colors.red,
        );
        return;
      }
      if (checkoutData.success == true) {
        if (_paymentMethod == 'cash') {
          NavigationService.pushReplacementAll(
              page: PaymentSuccessScreen.routeName,
              arguments: {
                'message': checkoutData.message,
                'success': (checkoutData.success ?? false),
              });
        } else {
          NavigationService.push(
            page: WebViewScreen.routeName,
            arguments: checkoutData.data ?? '',
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: checkoutData.message ?? '',
          backgroundColor: Colors.red,
        );
      }
      emit(CheckoutDone());
    } on LaravelException catch (error) {
      emit(CheckoutError());
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
    }
  }
}
