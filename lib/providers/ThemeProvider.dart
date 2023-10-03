import 'package:ecommerce/common/AppColorScheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String theme = 'light';

  Future init() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    theme = sharedPreferences.getString("theme") ?? 'light';
    AppColorScheme.setColorScheme(theme);
  }

  Future setTheme(String theme) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    this.theme = theme;
    sharedPreferences.setString("theme", theme);
    AppColorScheme.setColorScheme(theme);
    notifyListeners();
  }
}