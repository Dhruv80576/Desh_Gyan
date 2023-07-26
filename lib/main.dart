import 'package:flutter/material.dart';
import 'Pages/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:spider_task_2/Theme/Theme_Provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: Consumer(
      builder: (context, ThemeProvider themeProvider, child) {
        return MaterialApp(
          theme: themeProvider.isdark?ThemeData.dark():ThemeData.light(),
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    ),
  ));
}
