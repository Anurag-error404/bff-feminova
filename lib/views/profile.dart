import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feminova/views/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userUid = "";
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  bool isProfileUpdated = false;

  void userActive() async {
    setState(() {
      final User? user = auth.currentUser;
      userUid = user?.uid.toString() ?? "";
    });
  }

  @override
  void initState() {
    userActive();
    super.initState();
  }

  getUserInfo() {
    
  }

  _logout() async {
    await auth.signOut();
    Future.delayed(Duration.zero, () {
      Navigator.of(context, rootNavigator: true)
          .pushReplacement(MaterialPageRoute(builder: (context) => LandingPage()));
    });
  }

  Widget signOut() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: () {
          _logout();
        },
        child: Text(
          "Sign Out",
          style: TextStyle(color: Color(0xff202020)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: const Text("Profile")),
    );
  }
}
