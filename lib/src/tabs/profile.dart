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
  var user;
  var token;

  Future fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fetchedToken = prefs.getString('token');
    token = fetchedToken;
  }

  Future fetchProfile() async {
    final response = await http
        .get('https://guffgaffchat.herokuapp.com/api/user/me', headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      user = decodedResponse;
      return decodedResponse;
    } else {
      print(token);
      print(response.statusCode);
      print(response.reasonPhrase);
      throw Exception('Failed to load user information');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FutureBuilder(
                future: fetchProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 30,
                    );
                  }
                  if (snapshot.hasData) {
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
                          style: TextStyle(fontSize: 18))
                    ]);
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}
