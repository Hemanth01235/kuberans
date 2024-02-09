import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuberans/Bloc/SignIn/signin_bloc.dart';
import 'package:kuberans/Bloc/TabBar/tab_bar_bloc.dart';
import 'Bloc/SignUp/sign_up_bloc.dart';
import 'LoginScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => TabBarBloc(),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: LoginScreen()),
    );
  }
}


