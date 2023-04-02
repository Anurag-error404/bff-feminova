import 'dart:io';

import 'package:feminova/app/colors.dart';
import 'package:feminova/views/calender_screen.dart';
import 'package:feminova/views/faq_screen.dart';
import 'package:feminova/views/home_screen.dart';
import 'package:feminova/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/custom_navbar.dart';
import '../utils/size_config.dart';
import 'maps_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _children = <Widget>[
    HomeScreen(),
    MapsScreen(),
    FaqScreen(),
    CalendarScreen(),
  ];


  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int selectedIndex = 0;
  List<IconData> navItems = [
    FontAwesomeIcons.houseMedical,
    FontAwesomeIcons.mapLocation,
    // FontAwesomeIcons.sugg,
    Icons.chat_bubble_outlined,
    FontAwesomeIcons.newspaper,
    // FontAwesomeIcons.education,
  ];

  List<String> navLabels = ['Home', 'Categories', 'Support', 'Profile'];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      // ),
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: _children,
        ),
      ),
      floatingActionButton: SizedBox(
        height: SizeConfig.screenHeight * 0.2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomNavigationBar(
              iconSize: 20.0,
              selectedColor: Colors.white,
              strokeColor: Colors.white,
              unSelectedColor: Colors.white54,
              borderRadius: const Radius.circular(18.0),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 254, 105, 105),
                  AppColor.accentMain,
                  // AppColor.accentMainDark,
                  Color.fromARGB(255, 254, 105, 105),
                ],
              ),
              blurEffect: false,
              opacity: 1.0,
              items: List.generate(
                navItems.length,
                (index) => CustomNavigationBarItem(
                  icon: FaIcon(
                    index == selectedIndex ? navItems[index] : navItems[index],
                  ),
                  // title: index == selectedIndex ? Text(navLabels[index]) : SizedBox.shrink(),
                ),
              ),
              currentIndex: selectedIndex,
              onTap: (index) => changePage(index),
              isFloating: true,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: Platform.isIOS
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Schedule',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'profile',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.question_answer),
      //       label: 'FAQ',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   unselectedItemColor: Colors.black,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
