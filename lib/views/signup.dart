import 'package:feminova/app/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/app_constants.dart';
import '../utils/size_config.dart';
import 'login.dart';
import 'verify_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _email, _password;
  final auth = FirebaseAuth.instance;

  var _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _signUpWithMail() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      try {
        final User? user =
            (await auth.createUserWithEmailAndPassword(email: _email!, password: _password!)).user;

        if (user!.uid.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VerifyScreen()),
          );
        } else {
          setState(() {
            print('sign in failed!');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Failed to Signup , Try again later")));
          });
        }
      } catch (e) {
        var errorCode = e.toString();
        if (errorCode ==
            '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
          print('this email is already registered ! Login to continue');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Email is already registered ! Login to continue")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Some Unexpected Error occured please try again later.")));
        }
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpaceSmall,
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(curve15),
                  child: Container(
                    height: SizeConfig.screenHeight * 0.45,
                    // width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(curve15),
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/img6.png",
                            ),
                            fit: BoxFit.cover)),
                    // child: Image.asset("assets/img5.png", fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _email = value.trim();
                        });
                      },
                      // controller: emailTextController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.red,
                      key: ValueKey('UserMail'),
                      onSaved: (value) {
                        // userMail = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can not be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.mail),
                          onPressed: (null),
                        ),
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                      // controller: passwordTextController,
                      obscureText: _obscureText,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.red,
                      key: ValueKey('Password'),
                      onSaved: (value) {
                        // userMail = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can not be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.lock),
                          onPressed: (null),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            _toggle();
                          },
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.8,
                  decoration:
                      BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      _signUpWithMail();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextButton(
                    child: Text(
                      'Already have an account ? Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
