part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class AddToCartLoading extends CartState {
  const AddToCartLoading({
    required this.productId,
  });
  final int productId;

  @override
  List<Object> get props => [
        productId,
      ];
}
class DeleteCartItemLoading extends CartState {
  const DeleteCartItemLoading({
    required this.productId,
  });
  final int productId;

  @override
  List<Object> get props => [
        productId,
      ];
}
class ProductUpdated extends CartState {
  const ProductUpdated({
    required this.product,
  });
  final Product? product;

  @override
  List<Object> get props => [
        product!,
      ];
}

class CartDone extends CartState {}

class CartError extends CartState {}

class CartLoading extends CartState {}
