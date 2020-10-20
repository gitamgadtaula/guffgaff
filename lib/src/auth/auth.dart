import 'package:flutter/material.dart';
import 'package:guffgaff/src/auth/register.dart';
import 'login.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // final AuthService _auth = authService();

  // authService() => AuthService();
  bool isAuth = false;
  void toggleAuth() {
    setState(() {
      isAuth = !isAuth;
    });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (isAuth) {
      print(isAuth);
      _pushPage(context, Login());
      // return 'login';
      // return Login(toggleAuth: toggleAuth);
      //passing the function to Auth class constructor
    } else
      print(isAuth);
    _pushPage(context, Register());
    // return Register(toggleAuth: toggleAuth);
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
