part of 'generate_unique_token_cubit.dart';

abstract class GenerateUniqueTokenState extends Equatable {
  const GenerateUniqueTokenState();

  @override
  List<Object> get props => [];
}

class GenerateUniqueTokenInitial extends GenerateUniqueTokenState {}

class GenerateUniqueTokenLoading extends GenerateUniqueTokenState {}

class GenerateUniqueTokenDone extends GenerateUniqueTokenState {}

class GenerateUniqueTokenError extends GenerateUniqueTokenState {}
