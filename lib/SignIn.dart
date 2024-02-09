import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuberans/Bloc/SignIn/signin_bloc.dart';
import 'package:kuberans/SignUp.dart';
import 'package:kuberans/main.dart';

import 'LoginScreen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   passwordVisible = true;
  // }

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<SignInBloc, SignInState>(
       listener: (context, state){
         if(state is SignInFailure){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error),
           ),
           );
         }
         if(state is SignInSuccess){
           Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
         }
       },
       builder: (context, state){
         if(state is SignInLoading){
           return Center(
             child: CircularProgressIndicator(),
           );
         }
         return SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: Form(
               key: _formKey,
               child:
               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 Text(
                   "Welcome Back,",
                   style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 22),
                 ),
                 Text(
                   "Good to see you again",
                   style: TextStyle(color: Color(0xFF707070), fontSize: 12),
                 ),
                 SizedBox(height: 40),
                 TextFormField(
                   controller: emailController,
                   focusNode: emailFocus,
                   decoration: InputDecoration(
                     labelText: 'Email',
                     labelStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 10),
                     prefixIcon: Icon(
                       Icons.email_outlined,
                       color: Color(0xFF707070),
                       size: 14,
                     ),
                     border: OutlineInputBorder(),
                     hintText: 'Email',
                     hintStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 10),
                   ),

                 ),
                 SizedBox(
                   height: 40,
                 ),
                 TextFormField(
                   controller: passwordController,
                   focusNode: passwordFocus,
                   obscureText: !passwordVisible,
                   obscuringCharacter: '*',
                   decoration: InputDecoration(
                     labelText: 'Password',
                     labelStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 10),
                     border: OutlineInputBorder(),
                     hintText: 'Password',
                     hintStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 10),
                     prefixIcon: Icon(
                       Icons.lock,
                       color: Color(0xFF707070),
                       size: 14,
                     ),
                     suffixIcon: IconButton(
                       icon: Icon(
                           passwordVisible ? Icons.visibility : Icons.visibility_off,
                           color: Color(0xFF707070),
                           size: 16),
                       onPressed: () {
                         setState(
                               () {
                             passwordVisible = !passwordVisible;
                           },
                         );
                       },
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     InkWell(
                       child: Text(
                         "forgot password",
                         style: TextStyle(
                           fontSize: 12,
                           color: Color(0xFFAAB3AF),
                           decoration: TextDecoration.underline,
                         ),
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 30),
                 Center(
                   child: SizedBox(
                     width: 500,
                     child: ElevatedButton(
                       style: ButtonStyle(backgroundColor:  MaterialStatePropertyAll(Color(0xFF0FFDA3C5B))),
                       onPressed: () {
                         context.read<SignInBloc>().add(
                             SignInRequest(email: emailController.text.trim(),
                           password: passwordController.text.trim())
                         );
                       },
                       child: Text(
                         "Sign In",
                         style: TextStyle(
                           fontSize: 16,
                           color: Color(0xFFFFFFFF),
                         ),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 30),
                 Row(
                   children: [
                     Expanded(
                       child: Divider(
                         color: Color(0xFF707070),
                         thickness: 1,
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child: Text(
                         "Or continue with",
                         style: TextStyle(color: Color(0xFF7F0E25), fontSize: 12),
                       ),
                     ),
                     Expanded(
                       child: Divider(
                         color: Color(0xFF707070),
                         thickness: 1,
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 30),
                 Center(
                   child: ElevatedButton(
                     style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                     onPressed: () {},
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         SizedBox(
                             height: 20, child: Image.asset("images/google.PNG")),
                         SizedBox(width: 10),
                         Text(
                           "Google",
                           style: TextStyle(
                             fontSize: 12,
                             color: Color(0xFF707070),
                           ),
                         ),
                       ],
                     ),
                   ),
                 )
               ]),
             ),
           ),
         );
       }
     );


  }
}
