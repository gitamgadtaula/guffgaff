import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleAuth;
  //accepting the function passed via Auth Class inside of constructor to access those function inside this class
  Register({this.toggleAuth});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String fullname = '';
  String email = '';
  String username = '';
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
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    prefixIcon: Icon(Icons.info_outline),
                    labelText: 'Enter Fullname'),
                onChanged: (value) {
                  setState(() => fullname = value);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    prefixIcon: Icon(Icons.mail),
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
              SizedBox(height: 15),
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
              SizedBox(height: 20),
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
                  icon: Icon(Icons.person_add),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ],
          )),
    );
  }
}
