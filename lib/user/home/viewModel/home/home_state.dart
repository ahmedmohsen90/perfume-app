part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDone extends HomeState {}

class HomeError extends HomeState {}

class HomeFavStateChanged extends HomeState {
  const HomeFavStateChanged({
    required this.product,
  });
  final Product product;

  @override
  List<Object> get props => [
        product,
      ];
}

class VideoStateChanged extends HomeState {
  const VideoStateChanged({
    required this.state,
  });
  final String state;

  @override
  List<Object> get props => [
        state,
      ];
}
