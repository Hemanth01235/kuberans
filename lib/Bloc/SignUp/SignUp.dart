import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Controller/user_controller.dart';
import 'sign_up_bloc.dart';
import '../../LoginScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool passwordVisible1 = false;
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode ConfirmPasswordFocus = FocusNode();
  var confirmPassword;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello there,",
                    style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 22),
                  ),
                  Text(
                    "We are exited to see you here",
                    style: TextStyle(color: Color(0xFF707070), fontSize: 12),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return "Enter valid name";
                      }
                    },
                    controller: nameController,
                    focusNode: nameFocus,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF707070),
                        size: 14,
                      ),
                      border: OutlineInputBorder(),
                      hintText: nameFocus.hasFocus ? "" : 'Name',
                      hintStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || !RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
                          value)) {
                        return "Enter valid email";
                      }
                    },
                    controller: emailController,
                    focusNode: emailFocus,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color(0xFF707070),
                        size: 14,
                      ),
                      border: OutlineInputBorder(),
                      hintText: emailFocus.hasFocus ? "" : 'Email',
                      hintStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 6) {
                        return "password cannot be less than 6 characters";
                      } else if (value != confirmPasswordController.text) {
                        return "Password does not match";
                      }
                    },
                    controller: passwordController,
                    focusNode: passwordFocus,
                    obscureText: !passwordVisible,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                      border: OutlineInputBorder(),
                      hintText: passwordFocus.hasFocus ? '' : "Password",
                      hintStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
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
                          size: 16,
                        ),
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
                    height: 40,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 6) {
                        return "password cannot be less than 6 characters";
                      } else if (value != passwordController.text) {
                        return "Password does not match";
                      }
                    },
                    controller: confirmPasswordController,
                    focusNode: ConfirmPasswordFocus,
                    obscureText: !passwordVisible1,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      labelText: 'ConfirmPassword',
                      labelStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                      border: OutlineInputBorder(),
                      hintText: ConfirmPasswordFocus.hasFocus
                          ? ''
                          : 'Confirm Password',
                      hintStyle:
                      TextStyle(color: Color(0xFFAAB3AF), fontSize: 12),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF707070),
                        size: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xFF707070),
                          size: 16,
                        ),
                        onPressed: () {
                          setState(
                                () {
                              passwordVisible1 = !passwordVisible1;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 500,
                      child: BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          if(state is SignUpLoading)
                          {
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final email = emailController.text.trim();
                                final querySnapshot = await FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .where('email', isEqualTo: email)
                                    .get();
                                if (querySnapshot.docs.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Email already exists. Please try a different one."),
                                      ));
                                } else {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => LoginScreen(),));
                                  context.read<SignUpBloc>().add(
                                    SignUpRequest(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      confirmPassword:
                                      confirmPasswordController.text.trim(),
                                    ),
                                  );
                                  UserController.saveUserDetailsFromControllers(
                                    nameController.text.trim(),
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                }
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF0FFDA3C5B))),
                            child: Text(
                              "Sign Up",
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
                          style: TextStyle(
                              color: Color(0xFF7F0E25), fontSize: 12),
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
                      style:
                      ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset("images/google.PNG")),
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
                ]),
          ),
        ),
      ),
    );
  }
}
