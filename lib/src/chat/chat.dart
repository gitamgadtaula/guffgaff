import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  final String username;
  Chat({this.username});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var chatMsg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        centerTitle: true,
      ),
      bottomSheet: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.orangeAccent, width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              labelText: 'Your sweet message ....'),
          // onChanged: (value) {
          //   setState(() => this.chatMsg = value);
          // },
        ),
      ),
    );
  }
}
