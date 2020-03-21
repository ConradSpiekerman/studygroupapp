import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';



class SignInScreen extends StatelessWidget {
//  final GoogleSignIn googleSignIn;
//  SignInScreen({this.googleSignIn});
//  @override
//  State createState() => SignInScreenState();


  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  Future<void> _signInWithGoogle() async {
    print("sigining in with google");
    try {
        googleSignIn.signIn();

        print("we are here");
    } catch (e) {
      print("in signinwithgoogle error");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in with Google')),
      body: Center(
        child: RaisedButton(
          child: Text('Sign in with Google'),
          onPressed: _signInWithGoogle,
        ),
      ),
    );
  }
}

//class SignInScreenState extends State<SignInScreen> {
//
//  @override
//  void ininState() {
//    super.initState();
//    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      setState(() {
//        googleAccount = account;
//      });
//      if (googleAccount != null) {
//
//      }
//    });
//  }
//
//
//}