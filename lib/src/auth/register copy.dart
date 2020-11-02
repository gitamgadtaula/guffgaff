import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

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
  File _image;
  bool loading = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future register() async {
    var url = 'https://guffgaffchat.herokuapp.com/api/user/create';

    setState(() {
      this.loading = true;
    });
    List<int> imageBytes = _image.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    Map payload = {
      "full_name": fullname,
      "email": email,
      "password": password,
      "username": username,
      "avatar": baseimage
    };
    print('register function called');
    var response = await http.post(url, body: payload);
    if (response.statusCode == 200) {
      setState(() {
        this.loading = false;
      });
      var decodedResponse = jsonDecode(response.body);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Success')));
      print(decodedResponse);
    } else {
      setState(() {
        this.loading = false;
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
          title: Text('Register'),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      loading
                          ? LinearProgressIndicator(
                              minHeight: 0.1,
                              backgroundColor: Colors.white,
                            )
                          : SizedBox(height: 0),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Enter Username'),
                        onChanged: (value) {
                          setState(() => username = value);
                        },
                        validator: (value) {
                          var temp = value.split(" ").length;
                          if (temp >= 2) {
                            return 'username cannot have spaces';
                          }
                          if (value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
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
                      SizedBox(height: 20),
                      //show image if uploaded
                      _image == null
                          ? FlatButton.icon(
                              onPressed: () {
                                getImage();
                              },
                              icon: Icon(Icons.add_a_photo),
                              label: Text('Upload profile avatar'))
                          : Image.file(_image),

                      FlatButton.icon(
                          color: Colors.black12,
                          focusColor: Colors.deepOrange,
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side:
                                  BorderSide(width: 0.5, color: Colors.white)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              register();
                            }
                          },
                          icon: Icon(Icons.person_add),
                          label: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ],
                  ))),
        ));
  }
}
