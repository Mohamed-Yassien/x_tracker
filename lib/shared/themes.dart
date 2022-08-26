import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  // fontFamily: 'Lemonada',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
  ),
  scaffoldBackgroundColor: HexColor(
    '292929',
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: HexColor('292929'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('292929'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    elevation: 0,
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     elevation: 20,
  //     backgroundColor: HexColor('3d3d3d'),
  //     selectedItemColor: Colors.deepOrange,
  //     type: BottomNavigationBarType.fixed,
  //     unselectedItemColor: Colors.white),
);

ThemeData lightTheme = ThemeData(
  // fontFamily: 'Lemonada',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
  ),
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 25,
    ),
    elevation: 0,
  ),
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //   elevation: 20,
  //   selectedItemColor: Colors.deepOrange,
  //   type: BottomNavigationBarType.fixed,
  // ),
);
