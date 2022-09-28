part of 'areas_cubit.dart';

abstract class AreasState extends Equatable {
  const AreasState();

  @override
  List<Object> get props => [];
}

class AreasInitial extends AreasState {}

class AreasLoading extends AreasState {}

class AreasError extends AreasState {}

class AreasDone extends AreasState {}
