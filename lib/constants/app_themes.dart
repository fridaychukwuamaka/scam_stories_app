import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppThemes {
  AppThemes._();

  static const String font = "Montserrat";

  static TextStyle smallestText = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w500,
    fontSize: 9,
  );

   static snackBar(msg) {
    return Get.snackbar(
      'Message',
      msg,
      backgroundColor: Colors.white,
      margin: EdgeInsets.zero,
      borderRadius: 0,
    );
  }

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    primaryColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    platform: TargetPlatform.windows,
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontFamily: font,
        fontWeight: FontWeight.w600,
        fontSize: 14.5,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
        fontFamily: font,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: Colors.black,
      indicator: BoxDecoration(
        color: Colors.transparent,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: font,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontFamily: font,
      ),
      bodyText2: TextStyle(
        fontFamily: font,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      subtitle2: TextStyle(
        fontFamily: font,
        fontWeight: FontWeight.normal,
      ),
      headline5: TextStyle(
        fontFamily: font,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
      headline6: TextStyle(
        fontFamily: font,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      button: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: font,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
  );
}
