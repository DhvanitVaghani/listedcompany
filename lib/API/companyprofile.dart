import 'dart:convert';

import 'package:http/http.dart' as http;


//Get API from rapidapi.com
class FetchProfile {
  String sym;
  Map data;
  FetchProfile(this.sym);

  Future<void> getProfile() async {

     http.Response response = await http.get(
        Uri.encodeFull(
            "https://financialmodelingprep.com/api/v3/company/profile/$sym"),
        headers: {
          "x-rapidapi-host": "financial-modeling-prep.p.rapidapi.com",
          "x-rapidapi-key": "68f9d38e4bmshbb9d3effb52cf8ep12dfb5jsn0b9f014230e6"
        });

        Map<String, dynamic> profile = jsonDecode(response.body);
        data= profile["profile"];
        print(data);
  }


}