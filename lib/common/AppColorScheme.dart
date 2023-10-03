import 'package:flutter/material.dart';

class AppColorScheme{
  static Color primary = Colors.orange;
  static Color onPrimary = Colors.white;
  static Color primarySurface = Colors.orange[100]!;
  static Color primarySurfaceBackgound = Colors.orange[50]!;
  static Color secondary = Colors.blue;
  static Color onSecondary = Colors.white;
  static Color secondarySurface = Colors.blue[100]!;
  static Color background = Colors.white;
  static Color onSurface = Colors.black;
  static Color hint = Colors.grey;

  static void setColorScheme(String theme){
    if (theme == 'light') {
      primary = Colors.orange;
      onPrimary = Colors.white;
      primarySurface = Colors.orange[100]!;
      primarySurfaceBackgound = Colors.orange[50]!;
      secondary = Colors.blue;
      onSecondary = Colors.white;
      secondarySurface = Colors.blue[100]!;
      background = Colors.white;
      onSurface = Colors.black;
      hint = Colors.grey;
    }
    else{
        primary = Colors.orange;
        onPrimary = Colors.white;
        primarySurface = Colors.grey[800]!;
        primarySurfaceBackgound = Colors.grey[800]!;
        secondary = Colors.blue;
        onSecondary = Colors.black;
        secondarySurface = Colors.blue[100]!;
        background = Colors.grey[900]!;
        onSurface = Colors.white;
        hint = Colors.grey;
    }
  }
}