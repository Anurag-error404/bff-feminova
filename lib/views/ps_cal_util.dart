import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feminova/app/femenova_constant.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/model/ps_reminder.dart';

final _followUpDocSnap =
    FirebaseFirestore.instance.collection('users_app').doc(Femenova.userId).collection("ps_rem");

final kEvents = LinkedHashMap<DateTime, List<PSReminders>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(eventList);

Map<DateTime, List<PSReminders>> eventList = {};

psReminderEvent() async {
  List<PSReminders> psReminderList = [];
  await _followUpDocSnap.get().then((value) {
    for (var i = 0; i < value.docs.length; i++) {
      print(value.docs[i].data());
      psReminderList.add(PSReminders(
        followUpDate: (value.docs[i].data()['follow_up_date'] as Timestamp).toDate(),
        name: value.docs[i].data()['name'],
        lastDate: (value.docs[i].data()['last_date'] as Timestamp).toDate(),
        // status: value.docs[i].data()['status'],
        // userId: value.docs[i].data()['uid'],
        // followUpDate: value.docs[i].data()['follow_up_date'],
        // followUpDate: value.docs[i].data()['follow_up_date'],
      ));
    }
  });

  _groupEvents(psReminderList);
}

_groupEvents(List<PSReminders> events) {
  for (var event in events) {
    DateTime date =
        DateTime.utc(event.followUpDate.year, event.followUpDate.month, event.followUpDate.day, 12);
    if (eventList[date] == null) eventList[date] = [];
    eventList[date]!.add(event);
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 2, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 2, kToday.month, kToday.day);
