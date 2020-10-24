import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

Future fetchToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print('token is $token');
  return token;
}

Future fetchProfile(token) async {
  final response = await http
      .get('https://guffgaffchat.herokuapp.com/api/user/me', headers: {
    'authorization': 'Bearer $token',
  });
  print('Bearer $token');
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print(response.statusCode);
    throw Exception('Failed to load user information');
  }
}

class _ProfileState extends State<Profile> {
  var user;
  var token;

  @override
  void initState() {
    super.initState();
    token = fetchToken();
    user = fetchProfile(token);
    print('token is $token');
    for (var item in token) {
      print(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: IconButton(
                icon: Icon(Icons.drag_handle),
                onPressed: () {
                  fetchProfile(token);
                })));
  }
}
