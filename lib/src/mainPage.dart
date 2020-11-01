import 'package:flutter/material.dart';
import 'package:guffgaff/src/tabs/home.dart';
import 'package:guffgaff/src/tabs/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget {
  final Function checkAuthStatus;
  MainPage({this.checkAuthStatus});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', false);
    widget.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              // leading: Icon(Icons.message),
              leading: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    logout();
                  }),
              centerTitle: true,
              title: Text('GuffGaff', style: TextStyle(fontSize: 26)),
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  child: Text('Home'),
                ),
                Tab(
                  icon: Icon(CupertinoIcons.mail_solid),
                  child: Text('Chats'),
                ),
                Tab(
                  icon: Icon(Icons.person),
                  child: Text('Profile'),
                )
              ])),
          body: SafeArea(
            child: TabBarView(children: [
              HomePage(),
              Text('Under construction .....'),
              Profile()
            ]),
          )),
    );
  }
}
