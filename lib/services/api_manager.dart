import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import '../models/FlightRequest.dart';

// ignore: camel_case_types
class API_Manager {
  Future<Result> getFlights() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Strings.url);
      //Console.log('Text');
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = Result.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
