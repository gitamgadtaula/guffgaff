import 'package:flutter/material.dart';
// import 'package:guffgaff/src/auth/login.dart';
// import 'package:guffgaff/src/auth/register.dart';

import 'auth/auth.dart';

class Skeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.orangeAccent,
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                  // leading: Icon(Icons.message),
                  centerTitle: true,
                  title: Text('GuffGaff'),
                  bottom: TabBar(tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                      child: Text('Home'),
                    ),
                    Tab(
                      icon: Icon(Icons.message),
                      child: Text('Users'),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                      child: Text('Profile'),
                    )
                  ])),
              body: SafeArea(
                child: TabBarView(children: [Text('1'), Text('2'), Auth()]),
              )),
        ));

    //  body: MyPage()
  }
}
