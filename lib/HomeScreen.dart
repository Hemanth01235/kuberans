import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuberans/Controller/user_controller.dart';
import 'package:kuberans/LoginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            icon: Icon(Icons.navigate_before)),
        actions: [
          ElevatedButton(style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
            onPressed: () {
            UserController.signOut();
            UserController.signOutFacebook();
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            },
              child: Text("Log Out"),
          ),
        ],
      ),
      body: Center(
        child: Text("hi"),
      ),
    );
  }
}
