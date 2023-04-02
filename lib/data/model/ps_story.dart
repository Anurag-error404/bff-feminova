class PSStory {
  String? name;
  String? uid;
  String? mail;
  String? userName;
  String? title;
  String? story;
  bool? isAnonymous;
  DateTime? timeStamp;

  PSStory(
      {this.isAnonymous,
      this.mail,
      this.name,
      this.story,
      this.timeStamp,
      this.title,
      this.uid,
      this.userName});

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "uid" : uid,
      "userName" : userName,
      "mail" : mail,
      "isAnonymous" : isAnonymous,
      "title" : title,
      "timeStamp" : timeStamp,
      "story" : story,
    };
  }

  factory PSStory.fromMap(Map<String, dynamic> map) {
    return PSStory(
      name: map["name"],
      uid: map["uid"],
      userName: map["userName"],
      mail: map["mail"],
      isAnonymous: map["isAnonymous"],
      timeStamp: map["timeStamp"],
      title: map["title"],
      story: map["story"],
    );
  }
}
