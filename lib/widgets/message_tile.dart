import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feminova/app/colors.dart';
import 'package:feminova/app/femenova_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_time_patterns.dart';

import '../data/model/message.dart';

class MessageWidget extends StatefulWidget {
  Message message;
  String type;
  Function delMessage;
  Function makeAdmin;
  Function removeAdmin;
  Function checkAdmin;

  MessageWidget(
      {required this.message,
      required this.type,
      required this.delMessage,
      required this.makeAdmin,
      required this.removeAdmin,
      required this.checkAdmin});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  //Fields Which are not available with message object
  bool isAdmin = false;
  String fullName = "";
  String contact = "";

  Future<void> _getUserInfo(String uid) async {
    await FirebaseFirestore.instance
        .collection("users_app")
        .doc(uid)
        .collection("general_info")
        .doc("venatus")
        .get()
        .then((val) {
      fullName = val["name"];
      contact = val["phoneNumber"];
    });
  }

  Widget _userInfoPopupWidget(BuildContext context) {
    return AlertDialog(
      title: Text(widget.message.uname + "'s" + " Info"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Full Name:${this.fullName}"),
          Text("UID:${widget.message.uid}"),
          Text("Contact:${this.contact}"),
          Text("Admin:${this.isAdmin ? "Yes" : "No"}"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: AppColor.primaryText),
          ),
        ),
      ],
    );
  }

  Widget _holdPopUpWidget(BuildContext context) {
    return AlertDialog(
      title: Text(widget.message.uname + "'s" + " message"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Femenova.isAdmin
              ? MaterialButton(
                  onPressed: () {
                    this.isAdmin
                        ? widget.removeAdmin(widget.message.uid)
                        : widget.makeAdmin(widget.message.uid);
                  },
                  child: this.isAdmin ? Text("Remove Admin") : Text("Make Admin"),
                )
              : Container(),
          MaterialButton(
            onPressed: () {
              widget.delMessage(widget.message.msgID);
            },
            child: Text("Delete Message"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _userInfoPopupWidget(context);
                  });
            },
            child: Text("User Info"),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: AppColor.primaryText),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (widget.message.uid == Femenova.userId || Femenova.isAdmin) {
          this.widget.checkAdmin(widget.message.uid).then((val) {
            setState(() {
              this.isAdmin = val;
            });
            _getUserInfo(widget.message.uid);

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _holdPopUpWidget(context);
                });
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Align(
                alignment: (widget.type == "receiver" ? Alignment.topLeft : Alignment.topRight),
                child: Text(
                  widget.message.uname,
                  style: const TextStyle(fontFamily: "Inter", color: Colors.white),
                )),
            Container(
              child: Align(
                alignment: (widget.type == "receiver" ? Alignment.topLeft : Alignment.topRight),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: widget.type == "receiver"
                          ? null
                          : const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(42, 69, 164, 100),
                                Color.fromRGBO(155, 54, 54, 100),
                              ],
                            ),
                      borderRadius: widget.type == "receiver"
                          ? const BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                      color: (widget.type == "receiver"
                          ? const Color.fromRGBO(222, 202, 202, 0.2)
                          : null),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.message.content,
                      style:
                          const TextStyle(fontSize: 15, fontFamily: "Inter", color: Colors.white),
                    )),
              ),
            ),
            Align(
                alignment: (widget.type == "receiver" ? Alignment.topLeft : Alignment.topRight),
                child: Text(widget.message.atTime)),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
