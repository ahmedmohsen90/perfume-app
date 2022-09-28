part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class GetDeliveryPriceLoading extends CheckoutState {}

class GetDeliveryPriceDone extends CheckoutState {}

class GetDeliveryPriceError extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutDone extends CheckoutState {}

class CheckoutError extends CheckoutState {}

class PaymentMethodStateChanged extends CheckoutState {
  const PaymentMethodStateChanged({
    required this.method,
  });
  final String method;

  @override
  List<Object> get props => [
        method,
      ];
}
