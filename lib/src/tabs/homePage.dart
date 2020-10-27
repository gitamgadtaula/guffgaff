import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var token;
  Future fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fetchedToken = prefs.getString('token');
    setState(() {
      token = fetchedToken;
    });
  }

  @override
  void initState() {
    fetchToken();
    print(this.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Hello World'));
  }
}
