part of 'my_address_cubit.dart';

abstract class MyAddressState extends Equatable {
  const MyAddressState();

  @override
  List<Object> get props => [];
}

class MyAddressInitial extends MyAddressState {}

class MyAddressLoading extends MyAddressState {}

class MyAddressError extends MyAddressState {}

class MyAddressDone extends MyAddressState {}

class RadioButtonChanged extends MyAddressState {
  const RadioButtonChanged({
    required this.index,
  });
  final int index;

  @override
  List<Object> get props => [
        index,
      ];
}

class NewAddressAdded extends MyAddressState {
  const NewAddressAdded({
    required this.address,
  });
  final Address address;
  @override
  List<Object> get props => [
        address,
      ];
}
