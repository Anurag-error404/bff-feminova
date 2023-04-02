import 'package:flutter/material.dart';

// spacers
const Widget horizontalSpaceTiny_0 = SizedBox(height: 2.5);
const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny_0 = SizedBox(height: 2.5);
const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceLarge_1 = SizedBox(height: 75.0);

const Widget verticalSpaceMassive = SizedBox(height: 120.0);
const Widget spaceDividerExtraThin = Divider(height: 1, thickness: 0.15, color: Colors.black);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    const Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context, {int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context, {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 3);

const String rupeeUnicode = "\u20B9";

const double priceFontSize = 12.0;
const double subtitleFontSize = 12;
const double titleFontSize = 14;

// curves
const double curve5 = 5;
const double curve10 = 10;
const double curve15 = 15;
const double curve30 = 30;
