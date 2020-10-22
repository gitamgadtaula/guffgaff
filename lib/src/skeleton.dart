import 'package:flutter/material.dart';
import 'package:guffgaff/src/auth/login.dart';
import 'package:guffgaff/src/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'auth/auth.dart';

class Skeleton extends StatefulWidget {
   final Function checkAuthStatus;
  //accepting the function passed via login Class inside of constructor to access those function inside this class
  Skeleton({this.checkAuthStatus});
  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  bool isAuthenticated = false;
  void checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAuthenticated = prefs.getBool('isAuthenticated');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.orangeAccent,
        ),
        home: isAuthenticated ?  MainPage() : Login(checkAuthStatus:checkAuthStatus);

    //  body: MyPage()
  }
}
