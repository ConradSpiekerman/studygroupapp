import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './sign_in_screen.dart';
import './home_page_screen.dart';
import '../main.dart';

class LandingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GoogleSignInAccount>(
      stream: googleSignIn.onCurrentUserChanged,
      builder: (context, snapshot) {
//        if (snapshot.connectionState == ConnectionState.active) {
          GoogleSignInAccount user = snapshot.data;

          if (user == null) {
            return SignInScreen();
          }
          print("google sign in");
          print(googleSignIn);
          print(googleSignIn.currentUser.displayName);
          return HomePageScreen();
//        } else {
//          return Scaffold(
//            body: Center(
//              child: CircularProgressIndicator(),
//            ),
//          );
//        }
      },
    );
  }
}
