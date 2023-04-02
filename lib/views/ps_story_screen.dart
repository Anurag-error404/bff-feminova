import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feminova/app/colors.dart';
import 'package:feminova/data/model/ps_story.dart';
import 'package:feminova/views/post_story.dart';
import 'package:flutter/material.dart';

class PSStoryScreen extends StatefulWidget {
  const PSStoryScreen({super.key});

  @override
  State<PSStoryScreen> createState() => _PSStoryScreenState();
}

class _PSStoryScreenState extends State<PSStoryScreen> {
  var stream = FirebaseFirestore.instance.collection('discover_team');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PeriodStory(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              StreamBuilder(
                stream: stream.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.accentMain,
                      ),
                    );
                  }

                  List<QueryDocumentSnapshot<Map<String, dynamic>?>> psData = snapshot.data!.docs;
                  if (psData.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: psData.length,
                      itemBuilder: (context, index) {
                        return PSStoryCard(ps: PSStory.fromMap(psData[index].data()!));
                      },
                    );
                  }
                  return Container(
                    child: Text("you are the first one here,"),
                  );
                },
              )
            ],
          )),
        ));
  }
}

class PSStoryCard extends StatelessWidget {
  final PSStory ps;
  const PSStoryCard({super.key, required this.ps});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
