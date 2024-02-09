part of 'signin_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  final String uid;
  SignInSuccess({required this.uid});
}

class SignInFailure extends SignInState {
  final String error;
  SignInFailure(this.error);
}

class SignInLoading extends SignInState{}
