

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color Button_1 = Colors.deepPurple;
const Color yellowClr = Color(0xFFFFB300);
const Color whiteClr = Colors.white;
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF142124);
const Color redClr = Colors.red;
const Color orangeClr = Colors.deepOrange;
Color darkHeaderClr = Color(0xFF37474F);




class Themes{

  static final light = ThemeData(

    primaryColor: whiteClr,
    brightness: Brightness.light);

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    brightness: Brightness.dark);
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400]:Colors.grey
    )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white:Colors.black
      )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white:Colors.black
      )
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white:Colors.grey[00]
      )
  );
}
TextStyle get dropDownStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white:Colors.grey[500]
      )
  );
}