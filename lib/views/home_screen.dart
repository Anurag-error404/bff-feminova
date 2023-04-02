import 'dart:developer';

import 'package:feminova/data/model/products_list.dart';
import 'package:feminova/data/repo/get_products.dart';
import 'package:feminova/views/calender_screen.dart';
import 'package:feminova/widgets/carousal.dart';
import 'package:feminova/widgets/user_profile.dart';
import 'package:flutter/material.dart';

import '../app/app_constants.dart';
import 'ps_story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductsList? _itemsList;

  @override
  void initState() {
    getAllListedProducts();
    super.initState();
  }

  getAllListedProducts() async {
    var res = await GetProducts().getAllProducts();

    if (res != null) {
      log("hey");
      setState(() {
        log("hello");
        _itemsList = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log((_itemsList?.product.length ?? 0).toString());
    // getAllListedProducts();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    const UserProfileWidget(
                      fullName: "Anurag Verma",
                      userName: "anurag2276",
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => const CalendarScreen()));
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                    horizontalSpaceTiny_0,
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => const CalendarScreen()));
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              AppCarousalSlider(
                carouselItems: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(curve15),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(curve15)),
                      child: Image.asset(
                        "assets/flash1.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(curve15),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(curve15)),
                      child: Image.asset(
                        "assets/flash2.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>const PSStoryScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(curve15),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(curve15)),
                        child: Image.asset(
                          "assets/flash3.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Text("Trending"),
              _itemsList != null
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: [
                              Image.network(
                                _itemsList!.product[index].image,
                                height: 80,
                              ),
                              Text(_itemsList!.product[index].name),
                            ],
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink(),
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 120,
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
