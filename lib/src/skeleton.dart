import 'package:flutter/material.dart';
import 'package:guffgaff/src/auth/login.dart';
import 'package:guffgaff/src/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'auth/auth.dart';

class Skeleton extends StatefulWidget {
  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  bool isAuthenticated = false;
  checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAuthenticated = prefs.getBool('isAuthenticated');
    });
    print(isAuthenticated);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.orangeAccent,
        ),
        home: isAuthenticated
            ? MainPage(checkAuthStatus: checkAuthStatus)
            : Login(checkAuthStatus: checkAuthStatus));

    //  body: MyPage()
  }
}
