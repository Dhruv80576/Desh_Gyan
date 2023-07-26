import 'package:flutter/material.dart';
import 'package:spider_task_2/Theme/Theme_pref.dart';
class ThemeProvider extends ChangeNotifier {
  bool _isdark=false;
  Theme_pref _pref=Theme_pref();
  bool get isdark=>_isdark;

  getPref() async{
    _isdark=await _pref.getTheme();
    notifyListeners();
  }
  set isdark(bool value){
    _isdark=value;
    _pref.setTheme(value);
    notifyListeners();
  }
}