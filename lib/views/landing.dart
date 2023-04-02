import 'package:feminova/app/app_constants.dart';
import 'package:feminova/utils/size_config.dart';
import 'package:feminova/views/bottom_navigation_screen.dart';
import 'package:feminova/views/login.dart';
import 'package:feminova/widgets/carousal.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xfff97171),
      body: SafeArea(
        child: Column(
          children: [
            verticalSpaceLarge,
            AppCarousalSlider(
              aspectRatio: 0.7,
              height: SizeConfig.screenHeight * 0.6,
              carouselItems: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(curve30),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(curve30)),
                    child: Image.asset(
                      "assets/img1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(curve30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(curve30),
                    ),
                    child: Image.asset(
                      "assets/img2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(curve30),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(curve30)),
                    child: Image.asset(
                      "assets/img3.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(curve30),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(curve30)),
                    child: Image.asset(
                      "assets/calender.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            const Text(
              "Feminova",
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 50,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(curve15), color: Colors.white),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BottomNavigationScreen(),
                ));
              },
              child: const Text(
                "continue without signin",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
