import 'package:feminova/app/app_constants.dart';
import 'package:feminova/app/colors.dart';
import 'package:feminova/utils/size_config.dart';
import 'package:feminova/views/bottom_navigation_screen.dart';
import 'package:feminova/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/orDivider.dart';
import 'reset_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email, _password;
  final auth = FirebaseAuth.instance;

  var _formKey = GlobalKey<FormState>();
  bool loginFail = true;

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColor.accentMain,
      body: SafeArea(
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: Column(
                    children: [
              verticalSpaceSmall,
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(curve15),
                      
                child: Container(
                  height: SizeConfig.screenHeight*0.45,
                  // width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(curve15),
                    image: DecorationImage(image: AssetImage("assets/img5.png",), fit: BoxFit.cover)
                    ),
                  // child: Image.asset("assets/img5.png", fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor, borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    cursorColor: Colors.red,
                      
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
                      prefixIcon: const IconButton(
                        icon: Icon(
                          Icons.mail,
                          color:AppColor.accentMain,
                        ),
                        onPressed: (null),
                      ),
                      hintText: 'Enter Your Email',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    // controller: emailTextController,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor, borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                    obscureText: _obscureText,
                    style: Theme.of(context).textTheme.bodyText2,
                    cursorColor: Colors.red,
                    key: const ValueKey('Password'),
                    onSaved: (value) {
                      // userMail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password too short";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const IconButton(
                        icon: Icon(
                          Icons.lock,
                          color: AppColor.accentMain,
                        ),
                        onPressed: (null),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(!(_obscureText) ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          _toggle();
                        },
                      ),
                      hintText: 'Password',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    // controller: passwordTextController,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: SizeConfig.screenWidth * 0.8,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 234, 102, 104), borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    login();
                  },
                ),
              ),
              Container(
                child: TextButton(
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetScreen(),
                      ),
                    );
                  },
                ),
              ),
              verticalSpaceSmall,
              OrDivider(),
              Container(
                child: TextButton(
                  child: Text(
                    "Dont' have an account? Register",
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
                        builder: (context) => SignupScreen(),
                      ),
                    );
                  },
                ),
              ),
                    ],
                  ),
            ),
          )),
    );
  }

  Future<void> login() async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        final User? user =
            (await auth.signInWithEmailAndPassword(email: _email!, password: _password!)).user;

        if (user!.uid.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavigationScreen()),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Succesfully Loggedin in as ${user.email}")));
        } else {
          setState(() {
            loginFail = true;
            print('sign in failed!');
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Failed to login. Please try again later")));
          });
        }
      } catch (e) {
        var errorCode = e.toString();
        if (errorCode ==
            '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
          print('this email isnt registered !');
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email isn't registered. Please sign up First")));
        } else if (errorCode ==
            '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
          print('invalid password');
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Password Entered is incorrect")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Some Unexpected Error occured please try again later.")));
        }
        // print(e.toString());
      }
    }
  }
}
