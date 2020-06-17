import 'dart:convert';
import 'dart:io';

import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:fit_app/network/CustomException.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SportProvider {
  final url = Constants.API_URL;

  Future<dynamic> createOlahraga(
      int category, String startSport, String endSport, String token) async {
    var responseJson;
    try {
      final response = await http.post(url + "activity/create",
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: jsonEncode({
            'category_id': category,
            'start_activity': startSport,
            'end_activity': endSport,
          }));
      print(response.statusCode);
      print(response.body);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getSport(String token) async {
    var responseJson;
    try {
      final response = await http.get(
        url + "activity/get-today",
        headers: {"api_token": token, "Content-Type": "application/json"},
      );
      print(response.statusCode);
      print(response.body);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
