part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

final class SignUpRequest extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword
  });
}