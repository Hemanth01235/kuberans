import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuberans/LoginScreen.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF3D3D3D),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "We sent you a verification code to your email.",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF707070),
              ),
            ),
            SizedBox(height: 40,),
             Form(
                 child:Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   SizedBox(
                     height: 68,
                     width: 64,
                     child: TextFormField(
                       onChanged: (value){
                         if(value.length == 1)
                           {
                             FocusScope.of(context).nextFocus();
                           }
                         else if(value.length == 0)
                           {
                             FocusScope.of(context).previousFocus();
                           }
                       },
                       decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                       style: Theme.of(context).textTheme.headline6,
                       keyboardType: TextInputType.number,
                       textAlign: TextAlign.center,
                       inputFormatters: [LengthLimitingTextInputFormatter(1),
                       FilteringTextInputFormatter.digitsOnly,
                       ],
                     ),
                   ),
                     SizedBox(
                       height: 68,
                       width: 64,
                       child: TextFormField(
                         onChanged: (value){
                           if(value.length == 1)
                           {
                             FocusScope.of(context).nextFocus();
                           }
                           else if(value.length == 0)
                           {
                             FocusScope.of(context).previousFocus();
                           }
                         },
                         decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                         style: Theme.of(context).textTheme.headline6,
                         keyboardType: TextInputType.number,
                         textAlign: TextAlign.center,
                         inputFormatters: [LengthLimitingTextInputFormatter(1),
                           FilteringTextInputFormatter.digitsOnly,
                         ],
                       ),
                     ),
                     SizedBox(
                       height: 68,
                       width: 64,
                       child: TextFormField(
                         onChanged: (value){
                           if(value.length == 1)
                           {
                             FocusScope.of(context).nextFocus();
                           }
                           else if(value.length == 0)
                           {
                             FocusScope.of(context).previousFocus();
                           }
                         },
                         decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                         style: Theme.of(context).textTheme.headline6,
                         keyboardType: TextInputType.number,
                         textAlign: TextAlign.center,
                         inputFormatters: [LengthLimitingTextInputFormatter(1),
                           FilteringTextInputFormatter.digitsOnly,
                         ],
                       ),
                     ),
                     SizedBox(
                       height: 68,
                       width: 64,
                       child: TextFormField(
                         onChanged: (value){
                           if(value.length == 1)
                           {
                             FocusScope.of(context).nextFocus();
                           }
                           else if(value.length == 0)
                           {
                             FocusScope.of(context).previousFocus();
                           }
                         },
                         decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
                         style: Theme.of(context).textTheme.headline6,
                         keyboardType: TextInputType.number,
                         textAlign: TextAlign.center,
                         inputFormatters: [LengthLimitingTextInputFormatter(1),
                           FilteringTextInputFormatter.digitsOnly,
                         ],
                       ),
                     ),
                 ],
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
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                  },
                  child: Text(
                    "Verify",
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
    );
  }
}
