import 'package:flutter/material.dart';
import 'package:spider_task_2/Api/Api_service_detail.dart';
import 'package:spider_task_2/Api/Response_model_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
String cntry_n = "republic of india";
String capital = "";
String capital_info = "";
String currency = "";
String timezones = "";
String language = "";
String tp_lvl_dmn = "";
String pstl_cd = "";
String border = "";
bool favotite=false;

class Details_pg extends StatefulWidget {
  Details_pg(String cntry_name) {
    cntry_n = cntry_name;
  }

  @override
  State<Details_pg> createState() => _Details_pgState();
}

class _Details_pgState extends State<Details_pg> {
  List<CountryModel> _userModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService_detail('name/${cntry_n}').getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    capital = _userModel.elementAt(0).capital;
    capital_info = _userModel.elementAt(0).latlong;
    language = _userModel.elementAt(0).language.values.toString();
    timezones = _userModel.elementAt(0).timezone;
    tp_lvl_dmn = _userModel.elementAt(0).tld;
    border = _userModel.elementAt(0).border;
  }
  void savefavorite(String name,String flag)async{
    final pref=await SharedPreferences.getInstance();
    if(pref.getInt('favorite_num')==null){
      pref.setInt('favorite_num', 1);
    }
    else{
      pref.setInt('favorite_num', pref.getInt('favorite_num')!+1);
    }
    pref.setString('favorite_name${pref.getInt('favorite_num')!}', name);
    pref.setString('favorite_flag${pref.getInt('favorite_num')!}', flag);
    print(pref.getInt('favorite_num'));
    print(pref.getString('favorite_name${pref.getInt('favorite_num')!}'));

  }
  @override
  Widget build(BuildContext context) {
    return _userModel.length == 0
        ? Scaffold(
            body: Center(
                child: Container(
                    child: CircularProgressIndicator(
                        color: Color(0xFFF79432), strokeWidth: 5))))
        : Scaffold(
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              favotite=!favotite;
                              savefavorite(_userModel.elementAt(0).nameOfficial,_userModel.elementAt(0).flagPng);
                            });
                          },
                          icon: favotite==true?Icon(Icons.favorite,color: Colors.redAccent, size: 28,):Icon(Icons.favorite_border_sharp),

                        )),
                    Center(
                      child: Image.network(
                        _userModel.elementAt(0).flagPng,
                        width: 130,
                        height: 130,
                      ),
                    ),
                    Center(
                        child: Container(
                      child: Text(
                        "Official Name",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        _userModel.elementAt(0).nameOfficial,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Capital",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,
                        "${_userModel.elementAt(0).capital}\nLatitude,Longitude:${_userModel.elementAt(0).latlong}",
                        style: TextStyle(
                          fontSize: 24,

                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Currency",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Languages",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,
                        language,
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(

                        "TimeZones",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,

                        timezones,
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Area Occupied",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(

                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,
                        _userModel.elementAt(0).area.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Top Level Domain",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,

                        tp_lvl_dmn,
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Population",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,

                        _userModel.elementAt(0).population.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(

                        "Postal Code",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,

                        pstl_cd,
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Region",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,

                        _userModel.elementAt(0).region.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Car Driving Side",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        textAlign: TextAlign.center,

                        _userModel.elementAt(0).car,
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(

                        "Google Map",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: TextButton(
                        onPressed: () {
                          Uri.parse(_userModel.elementAt(0).google_map);
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          _userModel.elementAt(0).google_map,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        "Border",
                        style: TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 1,
                            color: Theme.of(context).brightness == Brightness.dark?Colors.white:Colors.black),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                    Center(
                        child: Container(
                      child: Text(
                        border,
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                    )),
                  ],
                ),
              ),
            ),
          );

  }
}
