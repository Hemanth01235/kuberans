import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class UserController{
  static User? user = FirebaseAuth.instance.currentUser;

  static Future<User?> loginWithGoogle() async{
    final googleAccount = await GoogleSignIn().signIn();

    final googleAuth =  await googleAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
     accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    return userCredential.user;
  }

  static Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static Future<User?> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final credential = FacebookAuthProvider.credential(accessToken.token);

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      return user;
    } else {
      return null;
    }
  }
  static Future<void> signOutFacebook() async {
   // await FirebaseAuth.instance.signOut();
    //await FacebookAuth.instance.logOut();
    await FacebookAuth.instance.logOut();
  }

  static Future<void> saveUserDetailsToFirestore(User user) async {
    final DateTime now = DateTime.now();
    final Timestamp timestamp = Timestamp.fromDate(now);

    CollectionReference collRef =
    FirebaseFirestore.instance.collection('users');
       try
       {
            await collRef.add({
           'email': user.email,
           'createdAt': timestamp,
         });
       }catch(error){}
  }

  static Future<void> saveUserDetailsFromControllers(
      String name, String email, String password) async {
    final DateTime now = DateTime.now();
    final Timestamp timestamp = Timestamp.fromDate(now);
    CollectionReference collRef =
    FirebaseFirestore.instance.collection('users');
    await collRef.add({
      'name': name,
      'email': email,
      'password': password,
      'CreatedAt': timestamp,
    });
  }

  // Future addUserDetails(String name,String email) async{
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'name': name,
  //     'email': email,
  //   });
  }

