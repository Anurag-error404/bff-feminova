import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feminova/app/colors.dart';
import 'package:feminova/views/bottom_navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? userUid = "";
  String? userMail = "";
  var id = "-1";

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  void inputData() {
    setState(() {
      final User? user = auth.currentUser;
      userUid = user!.uid.toString();
      userMail = user.email;
    });
  }

  getID() {
    setState(() {
      id = firestore.collection("users_app").doc(userUid).id;
    });
  }

  @override
  void initState() {
    super.initState();
    inputData();
    getID();
  }

  _trySubmit() {
    DocumentReference documentReference = firestore.collection("users_app").doc(userUid);

    documentReference.get().then((value) async {
      await firestore.collection("users_app").doc(userUid).set({
        "name": "Anurag Verma",
        "userName": "anurag2276",
        "contact": "7838063139",
        "mail" : userMail,
        "uid" : userUid,
        "profileCompleted": false,
        "isAdmin": false,
      });
    });

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const BottomNavigationScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentMainDark,
      body: SafeArea(
          child: Column(
        children: [
          Image.asset("assets/logo.png"),
          GestureDetector(
              onTap: _trySubmit,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Text("Continue"),
              )),
        ],
      )),
    );
  }
}
