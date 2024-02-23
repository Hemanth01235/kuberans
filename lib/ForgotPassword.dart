import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuberans/LoginScreen.dart';
import 'package:kuberans/Verification.dart';
import 'package:email_auth/email_auth.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  FocusNode emailFocus = FocusNode();
  final emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.navigate_before)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF3D3D3D),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Fill in your email and we’ll send a code to reset your password.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF707070),
                  ),
                ),
                SizedBox(height: 40,),
                TextFormField(
                  validator: (value) {
                    if (value == null ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
                            value)) {
                      return "Enter valid email";
                    }
                  },
                  controller: emailController,
                  focusNode: emailFocus,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Color(0xFFAAB3AF), fontSize: 12),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xFF707070),
                      size: 14,
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Color(0xFFAAB3AF), fontSize: 12),
                  ),
                ),
                SizedBox(height: 50,),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(
                            0xFF0FFDA3C5B),
                        ),
                      ),
                      onPressed: ()  async {
                        if (emailController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Email field cannot be empty"),
                            ),
                          );
                          return;
                        }
                          var forgotEmail = emailController.text.trim();
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: forgotEmail).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Email sent, check your email")));
                            });
                          } catch (e) {
                            print(e.toString());
                          }
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("fields cannot be empty")));
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => LoginScreen(),));
                        },
                      child: Text(
                        "Send Code",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
