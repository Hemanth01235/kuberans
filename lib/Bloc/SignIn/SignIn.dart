import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuberans/Bloc/SignIn/signin_bloc.dart';
import 'package:kuberans/ForgotPassword.dart';
import 'package:kuberans/HomeScreen.dart';

import '../../Controller/user_controller.dart';
import '../../LoginScreen.dart';

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
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Enter valid email";
                  }
                },
                controller: emailController,
                focusNode: emailFocus,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color(0xFF707070),
                    size: 14,
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.length < 6) {
                    return "password cannot be less than 6 characters";
                  }
                },
                controller: passwordController,
                focusNode: passwordFocus,
                obscureText: !passwordVisible,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF707070),
                    size: 14,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                    },
                    child: Text(
                      "Forgot password",
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
                  child: BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      if(state is SignInLoading)
                        {
                          return Center(child: CircularProgressIndicator());
                        }
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color(0xFF0FFDA3C5B),
                          ),
                        ),
                        onPressed: () async {
                         // if (_formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            context.read<SignInBloc>().add(SignInRequest(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()));

                            final querySnapshot = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .where('email', isEqualTo: email)
                                .get();

                              if (querySnapshot.docs.isNotEmpty) {
                              var userDoc = querySnapshot.docs.first;
                              var storedPassword = userDoc['password'];
                              if (storedPassword == password) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Password does not match"),
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Email not registred signup"),
                              ));
                            }
                       //   }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      );
                    },
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
                  onPressed: () async {
                    try {
                      final user = await UserController.loginWithGoogle();
                      if (user != null && mounted) {
                        await UserController.saveUserDetailsToFirestore(user);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    } catch (error) {
                      print(error);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Something went wrong",
                          ),
                        ),
                      );
                    }
                  },
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
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                  onPressed: () async {
                    try {
                      final user = await UserController.loginWithFacebook();
                      if (user != null && mounted) {
                        await UserController.saveUserDetailsToFirestore(user);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      }
                    } catch (error) {
                      print(error);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Something went wrong",
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook),
                      SizedBox(width: 10),
                      Text(
                        "Facebook",
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
      ),
    );
  }
}
