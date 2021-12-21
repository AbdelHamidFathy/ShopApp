import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme=ThemeData(
  appBarTheme: AppBarTheme(
    titleSpacing: 0.0,
    backgroundColor: defaultColor,
    elevation:0.0,
    titleTextStyle: TextStyle(
      color:Colors.white,
      fontSize: 20.0,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: defaultColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
  ),
);