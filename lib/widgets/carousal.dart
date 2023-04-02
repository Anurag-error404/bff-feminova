import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppCarousalSlider extends StatelessWidget {
  final double? height;
  final List<Widget>? carouselItems;
  final double? aspectRatio;
  const AppCarousalSlider({super.key, this.height, this.carouselItems, this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    List<Widget> testItems = [
      Container(
        height: 20,
        width: 350,
        color: Colors.red,
      ),
      Container(
        height: 20,
        width: 350,
        color: Colors.green,
      ),
      Container(
        height: 20,
        width: 350,
        color: Colors.blue,
      ),
    ];
    return CarouselSlider(
      options: CarouselOptions(
        height: height ?? 200,
        pageSnapping: true,
        autoPlay: true,
        aspectRatio: aspectRatio?? 1.5,
        enlargeCenterPage: true,
      ),
      items: carouselItems ?? testItems,
    );
  }
}
