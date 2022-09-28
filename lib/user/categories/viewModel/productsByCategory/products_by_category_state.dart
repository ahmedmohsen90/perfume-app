part of 'products_by_category_cubit.dart';

abstract class ProductsByCategoryState extends Equatable {
  const ProductsByCategoryState();

  @override
  List<Object> get props => [];
}

class ProductsByCategoryInitial extends ProductsByCategoryState {}

class ProductsByCategoryLoading extends ProductsByCategoryState {}

class ProductsByCategoryLoadingMore extends ProductsByCategoryState {}

class ProductsByCategoryDone extends ProductsByCategoryState {}

class ProductsByCategoryError extends ProductsByCategoryState {}

class CategoryProductFavStateChanged extends ProductsByCategoryState {
  const CategoryProductFavStateChanged({
    required this.product,
  });
  final CategoryProducts product;

  @override
  List<Object> get props => [
        product,
      ];
}
