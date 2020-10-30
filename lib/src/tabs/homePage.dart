import 'package:flutter/material.dart';
import 'package:guffgaff/src/chat/chat.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var token;
  var users;
  Future fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fetchedToken = prefs.getString('token');
    setState(() {
      token = fetchedToken;
    });
  }

  Future fetchUsers() async {
    final response =
        await http.get('https://guffgaffchat.herokuapp.com/api/user');

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      // setState(() {
      //   users = decodedResponse;
      // });
      return decodedResponse;
    } else {
      print(response.statusCode);
      // print(token);
      print(response.reasonPhrase);
      // return Exception('failed to load user');
      throw Exception('Failed to load users information');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchToken();
    users = fetchUsers();
    print(this.users);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
              var item = snapshot.data;
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://guffgaffchat.herokuapp.com/users/${item[index]['avatar']}'),
                          radius: 28,
                        ),
                        title: Text(item[index]['username']),
                        subtitle: Text(item[index]['full_name']),
                        trailing: IconButton(
                            icon: Icon(Icons.navigate_next),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Chat(username: item[index]['email'])),
                              );
                            }),
                      ),
                    );
                  });
              // return Text(snapshot.data[0]['username']);
            }
          }
        });
  }
}
