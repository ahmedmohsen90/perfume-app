part of 'create_new_address_cubit.dart';

abstract class CreateNewAddressState extends Equatable {
  const CreateNewAddressState();

  @override
  List<Object> get props => [];
}

class CreateNewAddressInitial extends CreateNewAddressState {}

class CreateNewAddressLoading extends CreateNewAddressState {}

class CreateNewAddressDone extends CreateNewAddressState {}

class CreateNewAddressError extends CreateNewAddressState {}
