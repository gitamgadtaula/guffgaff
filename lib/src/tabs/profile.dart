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

class _ProfileState extends State<Profile> {
  // Future user;
  String token;

  Future fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fetchedToken = prefs.getString('token');

    setState(() {
      token = fetchedToken;
    });
    // token = fetchedToken;
  }

  Future fetchProfile() async {
    final response = await http
        .get('https://guffgaffchat.herokuapp.com/api/user/me', headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } else {
      print(response.statusCode);
      print(token);
      print(response.reasonPhrase);
      // return Exception('failed to load user');
      throw Exception('Failed to load user information');
    }
  }

  // @override
  void initState() {
    super.initState();
    fetchToken();
    // user = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FutureBuilder(
                future: this.fetchProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 30,
                      );
                    } else {
                      print(snapshot.data);
                      return Column(children: [
                        SizedBox(height: 10),
                        CircleAvatar(
                          radius: 50,
                          child: Text(snapshot.data['username'][0],
                              style: TextStyle(fontSize: 24)),
                        ),
                        SizedBox(height: 10),
                        Text(snapshot.data['username'],
                            style: TextStyle(fontSize: 18)),
                        Text(snapshot.data['email'],
                            style: TextStyle(fontSize: 18))
                      ]);
                    }
                  }
                })));
  }
}
