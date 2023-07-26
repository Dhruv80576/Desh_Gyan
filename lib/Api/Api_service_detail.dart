import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'Response_model_detail.dart';

class ApiService_detail {
  String endpoint;
  ApiService_detail(this.endpoint);
  List<CountryModel> countryList=[];
  Future<List<CountryModel>?> getUsers() async {
    try {
      var url = Uri.parse('https://restcountries.com/v3.1/'+endpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonList = jsonDecode(response.body) as List;
        for (var element in jsonList) {
          countryList.add(CountryModel.fromJson(element));
        }
        log("Success");
        return countryList;
      }
    } catch (e) {
      log(e.toString());
      log("Failed");
    }
  }
}
