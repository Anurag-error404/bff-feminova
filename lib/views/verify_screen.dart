import 'dart:async';

import 'package:feminova/views/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/orDivider.dart';
import 'signup.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: size.width * 0.80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Theme.of(context).canvasColor),
              child: Column(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                    radius: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'An email has been sent to ${user!.email} please verify to continue.',
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Text(
                'Haven\'t recieved mail yet ? Lookout for mail in spam or Wait for a moment ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const OrDivider(),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) => const SignupScreen()));
                },
                child: const Text(
                  'Sign up with another Mail',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => WelcomePage()));
    }
  }
}
