import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequest>((event, emit) async {
      emit(SignUpLoading());
        try{
        final name = event.name;
        final email = event.email;
        final password = event.password;
        final confirmPassword = event.confirmPassword;

        // if(name == null || RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name))
        //   {
        //     return emit(
        //       SignUpFailure('Enter valid name')
        //     );
        //   }
        // if(email == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email))
        // {
        //   return emit(
        //       SignUpFailure('Enter valid email')
        //   );
        // }
        // if(password.length < 6 )
        // {
        //   return emit(
        //     SignUpFailure('password cannot be less than 6 characters'),
        //   );
        // }
        // if(confirmPassword.length < 6 )
        // {
        //   return emit(
        //     SignUpFailure('password cannot be less than 6 characters'),
        //   );
        // }
        // else if(password != confirmPassword)
        //   {
        //     return emit(
        //       SignUpFailure('Password does not match'),
        //     );
        //   }
        await Future.delayed(const Duration(seconds: 2),(){
          return emit(SignUpSuccess(uid: '$email-$password'));
        });
      }catch(e){
        return emit(SignUpFailure(e.toString()));
      }
    });
  }
}
