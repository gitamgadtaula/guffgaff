import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            child: TabBarView(children: [Text('1'), Text('2'), Text('3')]),
          )),
    );
  }
}
