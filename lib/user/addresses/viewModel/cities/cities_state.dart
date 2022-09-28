part of 'cities_cubit.dart';

abstract class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object> get props => [];
}

class CitiesInitial extends CitiesState {}

class CitiesLoading extends CitiesState {}

class CitiesDone extends CitiesState {}

class CitiesError extends CitiesState {}
