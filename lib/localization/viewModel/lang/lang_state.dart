part of 'lang_cubit.dart';

@immutable
abstract class LangState {}

class LangInitial extends LangState {}

class LoadingState extends LangState {}

class ChosenLanguage extends LangState {
  final String language;
  ChosenLanguage({
    required this.language,
  });
}
