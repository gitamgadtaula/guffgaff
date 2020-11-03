import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';

class Chat extends StatefulWidget {
  final String username;
  final String userId;
  Chat({this.username, this.userId});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var chatMsg;
  String token;
  TextEditingController myMsgController = TextEditingController();
  Future fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fetchedToken = prefs.getString('token');

    setState(() {
      token = fetchedToken;
    });
    // token = fetchedToken;
  }

  Future getMessages() async {
    final response = await http
        .post('https://guffgaffchat.herokuapp.com/api/chat/getall', body: {
      "recipient_id": widget.userId
    }, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      print(decodedResponse);
      return decodedResponse;
    } else {
      print(response.statusCode);
      print(token);
      // print(response.reasonPhrase);
      // return Exception('failed to load user');
      throw Exception('Failed to load messages');
    }
  }

  Future sendMessage() async {
    Map payload = {
      "message": this.myMsgController.text,
      "recipient_id": widget.userId
    };

    final response = await http.post(
        'https://guffgaffchat.herokuapp.com/api/chat/create',
        body: payload,
        headers: {
          'Authorization': 'Bearer $token',
        });
    this.myMsgController.clear();
    // this.chatMsg = '';
    if (response.statusCode == 200) {
      print('message is sent');
      getMessages();
    } else {
      print('error');
      print(payload);
      print(json.decode(response.body));
    }
  }

  // var messages;
  // @override
  void initState() {
    super.initState();
    fetchToken();
    // messages = getMessages();
  }

  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    myMsgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getMessages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 30,
                ),
              );
            } else {
              var item = snapshot.data['messages'];
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 80),
                reverse: true,
                itemCount: item.length,
                itemBuilder: (context, index) {
                  var name =
                      (item[index]['full_name']).split(' ')[0].toUpperCase();
                  print(index);
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: ChatBubble(
                            backGroundColor: Colors.redAccent,
                            clipper:
                                ChatBubbleClipper1(type: BubbleType.sendBubble),
                            child: Text(item[index]['msg']),
                          ),
                        ),
                        CircleAvatar(
                            child: widget.userId == item[index]['sender']
                                ? Text(name[0])
                                : Text('Me'))
                      ],
                    ),
                  );
                  // return ListTile(

                  //   trailing: CircleAvatar(
                  //       child: widget.userId == item[index]['sender']
                  //           ? Text(name[0])
                  //           : Text('Me')),
                  //   // title: Text(item[index]['username']),
                  //   // trailing: Text(item[index]['date'].split("T")[0]),
                  //   subtitle: Text(item[index]['msg']),
                  // );
                },
              );
            }
          }),
      bottomSheet: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: TextFormField(
          controller: myMsgController,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  }),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.orangeAccent, width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              labelText: 'Your sweet message ....'),
          onChanged: (value) {
            // setState(() => this.chatMsg = value);
          },
        ),
      ),
    );
  }
}
