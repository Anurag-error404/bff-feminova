import 'package:feminova/views/landing.dart';
import 'package:feminova/views/login.dart';
import 'package:flutter/material.dart';

import '../views/bottom_navigation_screen.dart';
// import '../common/route/route_generator.dart';
// import '../common/route/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: RouteGenerator.generateRoute,
      // initialRoute: Routes.landing,
      theme: ThemeData(),
      // home: const BottomNavigationScreen(),
      home: const LandingPage(),
      themeMode: ThemeMode.light,
    );
  }
} 