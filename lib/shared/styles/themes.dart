import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme=ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: defaultColor,
    elevation:0.0,
    titleTextStyle: TextStyle(
      color:Colors.white,
      fontSize: 20.0,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
  ),
);
ThemeData darkTheme=ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.grey,
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
);