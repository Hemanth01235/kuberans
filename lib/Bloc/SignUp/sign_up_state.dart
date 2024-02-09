part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String uid;
  SignUpSuccess({required this.uid});
}

class SignUpFailure extends SignUpState {
  final String error;
  SignUpFailure(this.error);
}

class SignUpLoading extends SignUpState{}
