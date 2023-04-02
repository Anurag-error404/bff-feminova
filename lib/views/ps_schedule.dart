import 'package:feminova/app/app_constants.dart';
import 'package:feminova/app/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/model/ps_reminder.dart';
import 'ps_cal_util.dart';

class PSSchedule extends StatefulWidget {
  const PSSchedule({super.key});

  @override
  State<PSSchedule> createState() => _PSScheduleState();
}

class _PSScheduleState extends State<PSSchedule> {
  late final ValueNotifier<List<PSReminders>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<PSReminders> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.chevron_left)),
                Spacer(),
                Text(''),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 450,
              width: 1000,
              child: TableCalendar(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarStyle: CalendarStyle(
                  markersMaxCount: 50,
                  markerDecoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: AppColor.accentMain,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  todayTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
                  weekendTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
                  defaultTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
                  selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  todayDecoration: BoxDecoration(
                    color: AppColor.feildsDefault,
                    border: Border.all(color: AppColor.accentMain, width: 2),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                      color: AppColor.feildsDefault),
                  weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                      color: AppColor.feildsDefault),
                ),
                headerStyle: HeaderStyle(
                  headerMargin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      color: AppColor.accentMain, borderRadius: BorderRadius.circular(10)),
                  leftChevronIcon: const Icon(
                    Icons.chevron_left_rounded,
                    color: AppColor.white,
                    size: 40,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColor.white,
                    size: 40,
                  ),
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.white, fontSize: 24),
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    if (day.weekday == DateTime.sunday) {
                      return const Center(
                        child: Text(
                          "Sun",
                          style: TextStyle(
                            color: AppColor.accentMain,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                    if (day.weekday == DateTime.saturday) {
                      return const Center(
                        child: Text(
                          "Sat",
                          style: TextStyle(
                            color: AppColor.accentMain,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<PSReminders>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return FollowUpTile(
                        psrem: value[index],
                        // contactNumber: value[index].phoneNumber,
                        // name: value[index].name,
                        // followUpDate: value[index].followUpDate,
                        // loanType: value[index].loanType,
                        // referrerId: value[index].referrerId,
                        // salary: value[index].employeeSalary,
                        // leadId: value[index].leadId,
                        // status: value[index].status,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowUpTile extends StatelessWidget {
  final PSReminders psrem;
  const FollowUpTile({super.key, required this.psrem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.accentMain.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Text(
            "This month period begins",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          verticalSpaceSmall,
          Text("Your Next cycle : ${DateFormat.yMMMd().format((psrem.followUpDate).add(Duration(days: 28)))}"),
          verticalSpaceTiny,
          Text("Ovulation On : ${DateFormat.yMMMd().format((psrem.followUpDate).add(Duration(days: 15)))}"),
          // Text("Status : ${psrem.status}"),
        ],
      ),
    );
  }
}
