import 'package:flutter/material.dart';
import 'package:spider_task_2/Pages/Details_pg.dart';
import 'package:spider_task_2/Pages/HomeScreen.dart';
import 'Api/Api_service_detail.dart';
class Search_Delegate extends SearchDelegate {

// Demo list to show querying
  List<String> searchTerms=[];
// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for (var countries in searchTerms) {
      if (countries.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(countries);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) =>Details_pg(matchQuery[index])));
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var countries in searchTerms) {
      if (countries.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(countries);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) =>Details_pg(matchQuery[index])));
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );

  }
  @override
  void showSuggestions(BuildContext context) {
    // TODO: implement showSuggestions
    super.showSuggestions(context);

  }
  Search_Delegate(this.searchTerms);
}
