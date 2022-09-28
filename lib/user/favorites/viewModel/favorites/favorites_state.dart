part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoadingMore extends FavoritesState {}

class FavoritesDone extends FavoritesState {}

class FavoritesError extends FavoritesState {}

class ToggleProductDone extends FavoritesState {
  const ToggleProductDone({
    required this.productId,
  });

  final int productId;

  @override
  List<Object> get props => [
        productId,
      ];
}

class ToggleProductError extends FavoritesState {
  const ToggleProductError({
    required this.productId,
  });
  final int productId;
  @override
  List<Object> get props => [
        productId,
      ];
}
