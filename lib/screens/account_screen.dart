import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/navigation_drawer.dart';
import '../main.dart';


class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
//  final GoogleSignIn googleSignIn;
//  AccountScreen({this.googleSignIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('account screen'),
        actions: <Widget>[

        ],
      ),
      drawer: NavigationDrawer(),
      body: Center(

          child: Text('account: ' + (googleSignIn == null ? 'nullSignIn' : (googleSignIn.currentUser == null ? 'null' : (googleSignIn.currentUser.displayName == null ? "null" : googleSignIn.currentUser.displayName))))
      )
    );
  }
}