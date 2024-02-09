part of 'signin_bloc.dart';

@immutable
abstract class SignInEvent {}

final class SignInRequest extends SignInEvent {
  final String email;
  final String password;

  SignInRequest({
      required this.email,
      required this.password
  });
}