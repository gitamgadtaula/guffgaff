import 'package:flutter/material.dart';
import 'package:guffgaff/src/auth/register.dart';
import 'login.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isAuth = false;
  void toggleAuth() {
    setState(() {
      isAuth = !isAuth;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAuth) {
      print(isAuth);
      return Login(toggleAuth: toggleAuth);
      //passing the function to Auth class constructor
    } else
      print(isAuth);
    return Register(toggleAuth: toggleAuth);
  }
}
