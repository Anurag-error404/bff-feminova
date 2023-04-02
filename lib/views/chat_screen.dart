import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:feminova/app/colors.dart';
import 'package:feminova/app/femenova_constant.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import '../data/model/chatUser.dart';
import '../data/model/message.dart';
import '../utils/size_config.dart';
import '../widgets/message_tile.dart';
// import '../../../../../models/chatUser.dart';
// import '../../../../../models/message.dart';
// import 'package:venatus/constants/venatus_constants.dart';

// String svIp = Femenova.socketServer; //ADB loopback address:10.0.2.2

String svIp = "3.110.218.161:3000"; //ADB loopback address:10.0.2.2

class ChatScreen extends StatefulWidget {
  late final String eventName;

  ChatScreen({required this.eventName});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController? _myMessageController = TextEditingController();
  bool isLoading = true;
  bool emojiShowing = false;

  List<Message> messagesList = [];
  List<User> usersList = [];
  bool isSession = false;
  bool isConnectedSocket = false;
  String? userId;
  String? token;
  String _sessionId = "EventChat";
  User user = User(
    uname: Femenova.username ?? "404",
    uid: Femenova.userId ?? "404",
    contactno: Femenova.phoneNo ?? "404",
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> makeAdmin(String uid) async {
    await firestore
        .collection("users_app")
        .doc(uid)
        .collection("general_info")
        .doc("venatus")
        .get()
        .then((doc) {
      firestore.collection('users_app').doc(uid).collection("general_info").doc("venatus").set({
        "isAdmin": true,
      }, SetOptions(merge: true));
      Navigator.of(context).pop();
    });

    socket.emit("admin-modify", {
      "roomID": "#" + _sessionId,
    });
  }

  Future<bool> checkAdmin(String uid) async {
    bool isAdmin = false;
    await firestore
        .collection("users_app")
        .doc(uid)
        .collection("general_info")
        .doc("venatus")
        .get()
        .then((doc) {
      isAdmin = doc.data()!["isAdmin"] ?? false;
    });
    return isAdmin;
  }

  Future<void> removeAdmin(String uid) async {
    await firestore
        .collection("users_app")
        .doc(uid)
        .collection("general_info")
        .doc("venatus")
        .get()
        .then((doc) {
      firestore.collection('users_app').doc(uid).collection("general_info").doc("venatus").set({
        "isAdmin": false,
      }, SetOptions(merge: true));
      Navigator.of(context).pop();
    });
    socket.emit("admin-modify", {
      "roomID": "#" + _sessionId,
    });
  }

  Future<List<Message>> _getMessageOfCurrentSession() async {
    final queryParameters = {
      'roomID': "#" + _sessionId,
    };

    Uri uri = Uri.parse("http://$svIp/api/v1/messages");
    final finalUri = uri.replace(queryParameters: queryParameters);
    var response = await http.get(finalUri, headers: {
      "Content-Type": "application/json; charset=UTF-8",
      // "Authorization":"Bearer $token",
    });

    List<Message> sessionMessages = [];
    // print(response.statusCode);
    if (response.statusCode == 404 || response.statusCode == 502 || response.statusCode == 500) {
      return sessionMessages;
    }

    json.decode(response.body)["messages"].forEach((val) {
      sessionMessages.add(Message(
          uname: val["username"],
          uid: val['uid'],
          atTime: val["datetime"],
          content: val["content"],
          roomID: val['roomID'],
          msgID: val["msgID"]));
    });

    // var revList = sessionMessages.reversed;

    // sessionMessages = List.from(revList);

    return sessionMessages;
  }

  Future<void> deleteMessage(String msgID) async {
    var response = await http.post(Uri.parse("http://$svIp/api/v1/del/message"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          // "Authorization":"Bearer $token",
        },
        body: json.encode({
          "roomID": "#" + _sessionId,
          "msgID": msgID,
        }));
    print(response.statusCode);
    if (response.statusCode == 201) {
      Navigator.of(context).pop();
      socket.emit(
          "delete-message",
          ({
            "roomID": "#" + _sessionId,
            "msgID": msgID,
          }));
    } else {
      //TOAST failed to delete
    }
  }

  void _sendMessageOnSocket() {
    String content = _myMessageController?.text as String;
    if (content == "") {
      return;
    }

    Message message =
        Message(uname: user.uname, content: content, uid: user.uid, roomID: _sessionId);
    // Message loopBackMessage =  Message(uname:user.uname,content:content,atTime:DateTime.now().toString(),uid:user.uid,roomID:_sessionId);

    socket.emit("chat-message", {
      "uname": message.uname,
      "uid": message.uid,
      "content": message.content,
      "atTime": message.atTime.toString(),
      "roomID": "#" + _sessionId,
    });

    setState(() {
      _myMessageController?.clear();
    });
  }

  void _joinSocketRoom(String sessionId) {
    socket.emit("join-room", [
      {"username": user.uname, "uid": user.uid, "contactno": user.contactno},
      "#" + sessionId
    ]);

    setState(() {
      isConnectedSocket = true;
      isSession = true;
      _sessionId = sessionId;
    });

    _setSocketEvents();
    _getMessageOfCurrentSession().then((val) => {
          setState(() {
            messagesList = val;
            isLoading = false;
          })
        });
  }

  Future<void> _createOrFindSession(String roomName) async {
    String url = "http://$svIp/api/v1/get-rooms";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 500) {
      return;
    }

    //Check every roomID if found then room exists on db
    List<dynamic> roomsList = json.decode(response.body)['rooms'];
    bool roomFound = false;
    roomFound = roomsList.any((e) {
      return e['roomID'] == "#" + roomName;
    });

    //Create room if not found on MONGODB
    if (!roomFound) {
      //Create room on mongoDB
      url = "http://$svIp/api/v1/create-room";
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json ; charset=UTF-8"},
          body: json.encode({
            "roomID": "#" + roomName,
            "messages": [],
            "members": [],
          }));
      if (response.statusCode == 500) {
        //  print("Code 500:Room creation failed internal server error");
        return;
      }
      setState(() {
        _sessionId = roomName;
      });
      // print("room created");
    }
  }

  void _setSocketEvents() {
    //Message received from server
    socket.on("message", (response) {
      // print(response['metadata']);

      Map<dynamic, dynamic> newMessage = response["metadata"];
      // print(newMessage['username']);

      Message receivedMessage = Message(
          uname: newMessage["username"],
          uid: newMessage["uid"],
          content: newMessage["content"],
          atTime: newMessage["datetime"],
          roomID: newMessage['roomID'],
          msgID: newMessage['msgID']);
      setState(() {
        messagesList.add(receivedMessage);
      });
    });

    socket.on("greeting-message", (msg) {
      print(msg);
    });

    //Delete msg locally and update state when any user deletes a message on room
    socket.on("delete-message", (id) {
      setState(() {
        messagesList.removeWhere((element) => element.msgID == id);
      });
    });

    //When new Admin is added or removed , fetch isAdmin from firebase and call setState
    //TO UPDATE CURRENT USER's isAdmin field
    socket.on("admin-modify", (_) async {
      await firestore
          .collection("users_app")
          .doc(Femenova.userId)
          .collection("general_info")
          .doc("venatus")
          .get()
          .then((doc) {
        setState(() {
          Femenova.isAdmin = doc.data()!["isAdmin"] ?? false;
        });
      });
    });
  }

  void _connectSocket(String roomId) {
    socket = IO.io('http://$svIp/',
        IO.OptionBuilder().setTransports(["websocket"]).disableAutoConnect().build());

    socket.connect();
    print(socket.connected);
    socket.onConnectError((data) => print(data));
    socket.onConnect((data) {
      _createOrFindSession(roomId).then((_) => {_joinSocketRoom(roomId)});
    });
  }

  void _disconnectSocket() {
    socket.emit("leave-room", _sessionId);
    socket.disconnect();
  }

  @override
  void initState() {
    super.initState();
    _sessionId = widget.eventName;
    _connectSocket(widget.eventName);
  }

  @override
  void dispose() {
    _disconnectSocket();
    _myMessageController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          if (emojiShowing) {
            emojiShowing = false;
          } else {
            Navigator.of(context).pop();
          }
        });
        return emojiShowing;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("${widget.eventName} chatroom"), backgroundColor: AppColor.accentMain,),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     AppColor.,
              //     Colors.black87,
              //   ],
              // ),
            ),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: ListView.builder(
                              itemCount: messagesList.length,
                              shrinkWrap: true,
                              // reverse: true,
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                log(messagesList.length.toString());
                                return MessageWidget(
                                  message: messagesList[index],
                                  type: messagesList[index].uid == user.uid ? "sender" : "receiver",
                                  delMessage: deleteMessage,
                                  checkAdmin: checkAdmin,
                                  makeAdmin: makeAdmin,
                                  removeAdmin: removeAdmin,
                                );
                              }),
                        ),
                      ),
                      Container(
                          padding:const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          height: MediaQuery.of(context).size.height * 0.1,
                          alignment: Alignment.bottomCenter,
                          child: TextFormField(
                            controller: _myMessageController,
                            // onTap: () {
                            //   if (emojiShowing) {
                            //     setState(() {
                            //       emojiShowing = false;
                            //     });
                            //   }
                            // },
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(fontFamily: "Inter", color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Enter your message ...',
                              hintStyle: const TextStyle(fontFamily: "Inter", color: Colors.black),
                              fillColor: AppColor.accentMain.withOpacity(0.5),
                              filled: true,
                              suffixIconColor: Colors.black,
                              
                              suffixIcon: GestureDetector(
                                  child: const Icon(Icons.send),
                                  onTap: () {
                                    setState(() {
                                      if (emojiShowing) {
                                        emojiShowing = false;
                                      }
                                    });
                                    _sendMessageOnSocket();
                                  }),
                            ),
                          )),
                      
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
