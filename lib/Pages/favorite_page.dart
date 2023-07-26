import 'package:flutter/material.dart';
import 'package:spider_task_2/Api/Response_model_detail.dart';
import 'package:spider_task_2/Api/Api_service_detail.dart';
import 'package:spider_task_2/Pages/HomeScreen.dart';
import 'package:spider_task_2/Pages/Details_pg.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> favorite_cntry_lst_nm = [];
List<String> favorite_cntry_lst_flag = [];

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    _getdata();
    return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Favorite Countries",
                    style: TextStyle(fontFamily: 'font_main'),
                  ),
                  Card(
                    margin: EdgeInsets.all(20),
                    child:  favorite_cntry_lst_nm.length == 0
                        ? Center(child: Text("No favorite Country "))
                        :GridView.builder(
                      itemCount: favorite_cntry_lst_nm.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details_pg(
                                      favorite_cntry_lst_nm.elementAt(index)),
                                ));
                          },
                          child: Column(
                            children: [
                              Image.network(
                                favorite_cntry_lst_flag.elementAt(index),
                                height: 70,
                                width: 70,
                              ),
                              Text(
                                favorite_cntry_lst_nm.elementAt(index),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
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
  }

  void _getdata() async {
    final sharedPreferences = await SharedPreferences.getInstance();
      for (int i = 1; i <= sharedPreferences.getInt('favorite_num')!; i++) {
        favorite_cntry_lst_nm
            .add(sharedPreferences.getString('favorite_name$i')!);
        favorite_cntry_lst_flag
            .add(sharedPreferences.getString('favorite_flag$i')!);
      }
  }
}
