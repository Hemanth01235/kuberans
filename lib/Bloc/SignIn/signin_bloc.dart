import 'package:bloc/bloc.dart';
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
        if(email == null && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email))
          {
            return emit(
                SignInFailure('Enter valid email')
            );
          }
        if(password.length < 6 )
          {
            return emit(
              SignInFailure('password cannot be less than 6 characters'),
            );
          }
        await Future.delayed(const Duration(seconds: 2),(){
          return emit(SignInSuccess(uid: '$email-$password'));
        });
     }catch(e){
       return emit(SignInFailure(e.toString()));
     }
    });
  }
}
