import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  ThemeData theme() {
    return ThemeData(
      dividerColor: Colors.transparent,
      colorScheme: const ColorScheme.dark(
        primary: AppColor.accentMain,
        primaryContainer: AppColor.background,
        onBackground: AppColor.background_1,
      ),
      primaryColor: AppColor.accentMain,
      cardColor: AppColor.background,
      fontFamily: GoogleFonts.poppins().fontFamily,
      
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryText,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryText,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.accentMain,
        iconTheme: IconThemeData(color: AppColor.primaryText),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            AppColor.accentMain,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
