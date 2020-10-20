import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function toggleAuth;
  Login({this.toggleAuth});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
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
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
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
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(width: 0.5, color: Colors.white)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      widget.toggleAuth();
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  icon: Icon(Icons.account_box),
                  label: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ],
          )),
    );
  }
}
