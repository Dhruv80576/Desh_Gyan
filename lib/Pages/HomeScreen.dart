import 'dart:core';
import 'dart:core';
import 'dart:math';
import 'package:spider_task_2/Api/Response_model_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'Details_pg.dart';
import 'package:spider_task_2/Search_delegate.dart';
import 'package:spider_task_2/Api/Api_service_detail.dart';
import 'favorite_page.dart';
import 'package:spider_task_2/Theme/Theme_pref.dart';
import 'package:spider_task_2/Theme/Theme_Provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? sort_value;
  List<CountryModel> temp = [];
  List<CountryModel> _userModel = [];
  bool currency = false;
  bool language = false;
  bool region = false;
  bool independance = false;
  List<String> county_name=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    county_name=[];
    _userModel = (await ApiService_detail('all').getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    for (var i in _userModel) {
      temp.add(i);
      county_name.add(i.nameOfficial);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeProvider themeProvider, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 40),
                      child: Text(
                        "Desh Gyan",
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'font_main',
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 10, 40),
                        child: GestureDetector(
                          onTap: () {
                            showSearch(
                                context: context, delegate: Search_Delegate(county_name));
                          },
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 10, 40),
                        child: IconButton(
                          onPressed: () {
                            themeProvider.isdark
                                ? themeProvider.isdark = false
                                : themeProvider.isdark = true;
                          },
                          icon: Icon(
                            Theme.of(context).brightness == Brightness.dark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 20, 15, 40),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => favorite(),
                                ));
                          },
                          child: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                        )),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(20, 15, 0, 10),
                  child: Text(
                    "Sort",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'font_main'),
                  ),
                ),
                RadioListTile(
                  activeColor: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffC694FA)
                      : Color(0xFFF79432),
                  title: Text("Alphabatically"),
                  value: 1,
                  groupValue: sort_value,
                  onChanged: (value) {
                    sort_list(1);
                    setState(() {
                      sort_value = 1;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffC694FA)
                      : Color(0xFFF79432),
                  title: Text("Population (High⬆-Low⬇)"),
                  value: 2,
                  groupValue: sort_value,
                  onChanged: (value) {
                    sort_list(2);
                    setState(() {
                      sort_value = 2;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffC694FA)
                      : Color(0xFFF79432),
                  title: Text("Area"),
                  value: 3,
                  groupValue: sort_value,
                  onChanged: (value) {
                    sort_list(3);
                    setState(() {
                      sort_value = 3;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffC694FA)
                      : Color(0xFFF79432),
                  title: Text("Phone code ☎"),
                  value: 4,
                  groupValue: sort_value,
                  onChanged: (value) {
                    sort_list(4);
                    setState(() {
                      sort_value = 4;
                    });
                  },
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(20, 15, 0, 10),
                  child: Text(
                    "Filter",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'font_main'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: FilterChip(
                                label: Text(
                                  "Currency",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                onSelected: (value) {
                                  print(!currency);
                                  currency = !currency;
                                  filter_func(
                                      currency, language, region, independance);
                                },
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? currency == true
                                        ? Colors.grey.shade300
                                        : Color(0xffC694FA)
                                    : currency == true
                                        ? Color(0xFFF79432)
                                        : Colors.grey.shade300,
                              ),
                            ),
                            FilterChip(
                              label: Text(
                                "Language",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onSelected: (value) {
                                language = !language;
                                filter_func(
                                    currency, language, region, independance);
                              },
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? language == true
                                      ? Colors.grey.shade300
                                      : Color(0xffC694FA)
                                  : language == true
                                      ? Color(0xFFF79432)
                                      : Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: FilterChip(
                              label: Text(
                                "Region",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              onSelected: (value) {
                                region = !region;
                                filter_func(
                                    currency, language, region, independance);
                              },
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? region == true
                                      ? Colors.grey.shade300
                                      : Color(0xffC694FA)
                                  : region == true
                                      ? Color(0xFFF79432)
                                      : Colors.grey.shade300,
                            ),
                          ),
                          FilterChip(
                            label: Text(
                              "Indepedence",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onSelected: (value) {
                              independance = !independance;
                              filter_func(
                                  currency, language, region, independance);
                            },
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? independance == true
                                        ? Colors.grey.shade300
                                        : Color(0xffC694FA)
                                    : independance == true
                                        ? Color(0xFFF79432)
                                        : Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _userModel.length == 0 ? 1 : _userModel.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return _userModel.length == 0
                          ? Center(
                              child: Container(
                                  child: CircularProgressIndicator(
                              color: Color(0xFFF79432),
                              strokeWidth: 5,
                            )))
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Details_pg(
                                          _userModel
                                              .elementAt(index)
                                              .nameOfficial),
                                    ));
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    _userModel.elementAt(index).flagPng,
                                    height: 70,
                                    width: 70,
                                  ),
                                  Expanded(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      _userModel.elementAt(index).nameCommon,
                                      style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 15,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void filter_func(bool crncy, bool lnguge, bool rgn, bool indpndc) {
    setState(() {
      if (rgn == true) {
        for (var i in temp) {}
      }
    });
  }

  void sort_list(int code) {
    if (code == 1) {
      _userModel.sort((a, b) =>
          a.nameCommon.toLowerCase().compareTo(b.nameCommon.toLowerCase()));
    }
    if (code == 2) {
      _userModel.sort((a, b) => b.population.compareTo(a.population));
    }
    if (code == 3) {
      _userModel.sort((a, b) => a.area.compareTo(b.area));
    }
    if (code == 4) {
      _userModel.sort((a, b) => a.phone_code.compareTo(b.phone_code));
    } else {}
  }
}
