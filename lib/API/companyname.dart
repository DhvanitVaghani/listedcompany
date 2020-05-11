import 'dart:convert';

import 'package:http/http.dart' as http;

// GEt Api From rapidapi.com

class GetCompanyName {
  List<String> symbol = [];
  List data;

  Future<void> getCompanyname() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "https://financialmodelingprep.com/api/v3/company/stock/list"),
        headers: {
          "x-rapidapi-host": "financial-modeling-prep.p.rapidapi.com",
          "x-rapidapi-key": "68f9d38e4bmshbb9d3effb52cf8ep12dfb5jsn0b9f014230e6"
        });
    Map company = jsonDecode(response.body);
    data = company["symbolsList"];

    for (int index = 0; index < data.length; index++) {
      symbol.add(data[index]["symbol"]);
    }
  }
}
