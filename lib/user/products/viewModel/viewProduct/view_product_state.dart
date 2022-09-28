part of 'view_product_cubit.dart';

abstract class ViewProductState extends Equatable {
  const ViewProductState();

  @override
  List<Object> get props => [];
}

class ViewProductInitial extends ViewProductState {}

class ViewProductLoading extends ViewProductState {}

class ViewProductDone extends ViewProductState {}

class ViewProductError extends ViewProductState {}

class ImagePaginated extends ViewProductState {
  const ImagePaginated({
    required this.index,
  });
  final int index;

  @override
  List<Object> get props => [
        index,
      ];
}

class QuantityChanged extends ViewProductState {
  const QuantityChanged({
    required this.quantity,
  });
  final int quantity;

  @override
  List<Object> get props => [
        quantity,
      ];
}
