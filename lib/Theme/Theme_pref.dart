import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Theme_pref{
  static const Pref_name='theme';
  setTheme(bool value) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool(Pref_name, value);

  }
  getTheme()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    return sharedPreferences.getBool(Pref_name);
  }
}