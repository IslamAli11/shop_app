
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 ThemeData lightTheme= ThemeData(
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      elevation: 0.0,
      color: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 1.0,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    unselectedLabelStyle: TextStyle(
      color: Colors.grey,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),

);