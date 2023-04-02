class Message {
  final String uname;
  final String content;
  final atTime;
  final String uid;
  final String roomID;
  final msgID;
  // final String email;

  Message(
      {required this.uname,
      this.msgID,
      required this.content,
      this.atTime,
      required this.uid,
      required this.roomID});

  factory Message.fromJson(Map<String, dynamic> data) {
    return Message(
      uname: data["name"],
      content: data["content"],
      atTime: data["atTime"],
      uid: data["uid"],
      roomID: data['roomID'],
    );
  }
}
