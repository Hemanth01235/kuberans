import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuberans/Bloc/SignUp/SignUp.dart';
import 'package:kuberans/Controller/user_controller.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInRequest>((event, emit) async {
      emit(SignInLoading());

      try{
        final email = event.email;
        final password = event.password;

        await Future.delayed(const Duration(seconds: 2),(){
          return emit(SignInSuccess(uid: '$email-$password'));
        });
    }
     catch(e){
       return emit(SignInFailure(e.toString()));
     }
     });
  }
}
