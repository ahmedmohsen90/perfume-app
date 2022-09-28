part of 'search_products_cubit.dart';

abstract class SearchProductsState extends Equatable {
  const SearchProductsState();

  @override
  List<Object> get props => [];
}

class SearchProductsInitial extends SearchProductsState {}

class SearchProductsLoading extends SearchProductsState {}

class SearchProductsDone extends SearchProductsState {}

class SearchProductsError extends SearchProductsState {}

class ResultProductFavStateChanged extends SearchProductsState {
  const ResultProductFavStateChanged({
    required this.product,
  });
  final Result product;

  @override
  List<Object> get props => [
        product,
      ];
}
