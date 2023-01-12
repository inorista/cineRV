import 'package:cinerv/src/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme {
  DarkTheme,
  NormalTheme,
}

final appThemeData = {
  AppTheme.NormalTheme: ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(),
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xff16141A),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 4,
      backgroundColor: Colors.white10,
      titleTextStyle: kStyleAppBarTitle,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white.withOpacity(0.80),
      unselectedItemColor: const Color(0xff828282),
      selectedItemColor: const Color(0xff16141A),
    ),
    fontFamily: "Open Sans",
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color(0xffffffff),
      ),
    ),
    iconTheme: const IconThemeData(
      size: 25,
      color: Color(0xff16141A),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.DarkTheme: ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 31, 31, 31),
      titleTextStyle: kStyleAppBarTitle,
    ),
    backgroundColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      enableFeedback: false,
      backgroundColor: Color.fromARGB(255, 29, 29, 29),
      unselectedItemColor: Color(0xff9f9fa5),
      selectedItemColor: Color(0xffff375f),
    ),
    fontFamily: "Open Sans",
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color(0xffffffff),
      ),
    ),
    iconTheme: const IconThemeData(
      size: 25,
      color: Color(0xffffffff),
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff181818),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
};
