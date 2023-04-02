import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feminova/app/app_constants.dart';
import 'package:feminova/app/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PeriodStory extends StatefulWidget {
  const PeriodStory({super.key});

  @override
  State<PeriodStory> createState() => _PeriodStoryState();
}

class _PeriodStoryState extends State<PeriodStory> {
  final TextEditingController _title = TextEditingController();
  bool isAnonymous = false;
  final TextEditingController _story = TextEditingController();
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

  @override
  void initState() {
    inputData();
    super.initState();
  }

  createPS() {
    DocumentReference documentReference =
        firestore.collection("users_app").doc(userUid).collection("my_ps").doc();

    documentReference.get().then((value) async {
      await firestore.collection("users_app").doc(userUid).collection("my_ps").doc().set({
        "name": "Anurag Verma",
        "userName": "anurag2276",
        "mail": userMail,
        "uid": userUid,
        "isAnonymous": isAnonymous,
        "timestamp": DateTime.now(),
        "title": _title.text.trim().toString(),
        "story": _story.text.trim().toString(),
      });
    });
    DocumentReference documentReference2 = firestore.collection("ps_story").doc();

    documentReference2.get().then((value) async {
      await firestore.collection("ps_story").doc().set({
        "name": "Anurag Verma",
        "userName": "anurag2276",
        "mail": userMail,
        "uid": userUid,
        "isAnonymous": isAnonymous,
        "timestamp": DateTime.now(),
        "title": _title.text.trim().toString(),
        "story": _story.text.trim().toString(),
      });
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Story Posted Sucessfully")));
  }

  Widget _customTextField({
    final String? Function(String?)? validator,
    final Function(String)? onChanged,
    final String? label,
    final int? maxLines,
    final TextEditingController? textEditingController,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        controller: textEditingController,
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        validator: (validator == null)
            ? (value) {
                if (value!.isEmpty) {
                  return "This field can't be emtpy";
                } else {
                  return null;
                }
              }
            : validator,
        style: const TextStyle(color: AppColor.secondaryText),
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          // labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          fillColor: Colors.black54,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.accentMain,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.accentMain,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.chevron_left)),
                  verticalSpaceSmall,
                  const Text(
                    "Share your PERIOD Story with others",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpaceSmall,
                  SwitchListTile(
                    value: isAnonymous,
                    onChanged: (bool value) {
                      setState(() {
                        isAnonymous = value;
                      });
                    },
                    title: const Text("Post Anonymously"),
                  ),
                  verticalSpaceSmall,
                  const Text("Title of Story"),
                  _customTextField(label: "Title of Story", textEditingController: _title),
                  verticalSpaceSmall,
                  const Text("Story Details"),
                  _customTextField(
                      label: "Story Details", textEditingController: _story, maxLines: 10),
                  MaterialButton(
                    onPressed: createPS,
                    child: Text("Post Story"),
                    color: AppColor.accentMain,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
