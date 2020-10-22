import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final Function checkAuthStatus;
  Login({this.checkAuthStatus});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool isLoading = false;
  Future login() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = 'https://guffgaffchat.herokuapp.com/api/user/login';
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    // var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      var decodedResponse = jsonDecode(response.body);
      prefs.setString('token', decodedResponse['token']);
      prefs.setBool('isAuthenticated', true);
      widget.checkAuthStatus();
      print(decodedResponse['token']);
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.statusCode);
      print('api Error');
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('login'),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(4),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Enter email'),
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightGreenAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password'),
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    FlatButton.icon(
                        color: Colors.black12,
                        focusColor: Colors.deepOrange,
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 50, right: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(width: 0.5, color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            login();
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        icon: Icon(Icons.account_box),
                        label: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                    SizedBox(height: 10),
                    isLoading
                        ? CircularProgressIndicator()
                        : SizedBox(
                            height: 0,
                          )
                  ],
                )),
          ),
        ));
  }
}
