import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import 'package:perfume/user/cart/repo/delete_cart_item_repo.dart';
import 'package:perfume/user/cart/repo/my_cart_repo.dart';
import '../../model/my_cart_model.dart';
import '../../repo/add_to_cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> addToCart({
    @required int? productId,
    int? quantity,
  }) async {
    emit(AddToCartLoading(productId: productId ?? 0));
    try {
      var addToCartData = await AddToCartRepo.addToCart(
        body: {
          'product_id': productId,
          'quantity': quantity ?? '1',
        },
      );

      if (addToCartData == null) {
        Fluttertoast.showToast(
          msg: 'network'.translate,
          backgroundColor: Colors.red,
        );
        emit(CartError());
        return;
      }
      if (addToCartData.success == true) {
        Fluttertoast.showToast(
          msg: addToCartData.message ?? '',
        );
        var index =
            _cartData?.products?.indexWhere((e) => e.id == productId) ?? -1;

        if (index < 0) {
          await getMyCartItems(
            showLoader: false,
          );
        }
        emit(CartDone());
      } else {
        emit(CartError());
        Fluttertoast.showToast(
          msg: addToCartData.message ?? 'something_wrong'.translate,
          backgroundColor: Colors.red,
        );
      }
    } on LaravelException catch (error) {
      emit(CartError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  Future<void> getMyCartItems({
    bool showLoader = true,
  }) async {
    if (showLoader) {
      emit(CartLoading());
    }
    try {
      var cartData = await MyCartRepo.myCart();

      if (cartData == null) {
        Fluttertoast.showToast(
          msg: 'network'.translate,
          backgroundColor: Colors.red,
        );
        emit(CartError());
        return;
      }
      if (cartData.success == true) {
        _cartData = cartData.data;

        emit(CartDone());
      } else {
        emit(CartError());
        Fluttertoast.showToast(
          msg: cartData.message ?? 'something_wrong'.translate,
          backgroundColor: Colors.red,
        );
      }
    } on LaravelException catch (error) {
      emit(CartError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  CartData? _cartData;
  CartData? get cartData => _cartData;
  int get cartCount => _cartData?.products?.length ?? 0;
  var scrollController = ScrollController();

  Future<void> deleteItem({
    int? productId,
  }) async {
    emit(DeleteCartItemLoading(productId: productId ?? 0));
    try {
      var deleteCartItemData = await DeleteCartItemRepo.delete(
        body: {
          'product_id': productId,
        },
      );

      if (deleteCartItemData == null) {
        Fluttertoast.showToast(
          msg: 'network'.translate,
          backgroundColor: Colors.red,
        );
        emit(CartError());
        return;
      }
      if (deleteCartItemData.success == true) {
        Fluttertoast.showToast(
          msg: deleteCartItemData.message ?? '',
        );
        _cartData = deleteCartItemData.data;
        getMyCartItems(
          showLoader: false,
        );
        emit(CartDone());
      } else {
        emit(CartError());
        Fluttertoast.showToast(
          msg: deleteCartItemData.message ?? 'something_wrong'.translate,
          backgroundColor: Colors.red,
        );
      }
    } on LaravelException catch (error) {
      emit(CartError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  updateCartQuantity(
    BuildContext context, {
    required bool isMinus,
    int? productId,
  }) {
    var index = _cartData?.products?.indexWhere(
          (element) => element.id == productId,
        ) ??
        -1;
    if (index >= 0) {
      var product = _cartData?.products![index];
      product!.quantity != product.quantity! + 1;
      _cartData?.products![index] = product;
      emit(
        ProductUpdated(
          product: product,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
