import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

fetchToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  // print(token);
  if (token != null) {
    return token;
  }
}

Future fetchProfile(token) async {
  final response = await http
      .get('https://guffgaffchat.herokuapp.com/api/user/me', headers: {
    'Authorization': 'Bearer $token',
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
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child:
                IconButton(icon: Icon(Icons.drag_handle), onPressed: () {})));
  }
}
