import 'dart:convert';
import 'dart:io';

import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:fit_app/models/food_consumtion.dart';
import 'package:fit_app/network/CustomException.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SleepProvider {
  final url = Constants.API_URL;

  Future<dynamic> createStart(String startSleep, String token) async {
    var responseJson;
    try {
      final response = await http.post(url + "sleep-history/create_start",
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: jsonEncode({
            'start_sleep': startSleep,
          }));
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> createEnd(String endSleep, String token) async {
    var responseJson;
    try {
      final response = await http.post(url + "sleep-history/create_start",
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: jsonEncode({
            'end_sleep': endSleep,
          }));
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> manualSleep(
      String startSleep, String endSleep, String token) async {
    var responseJson;
    try {
      final response = await http.post(url + "sleep-history/manual_sleep",
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: jsonEncode({
            'start_sleep': startSleep,
            'end_sleep': endSleep,
          }));
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> checkSleep(String token) async {
    var responseJson;
    try {
      final response = await http.get(
        url + "sleep-history/check",
        headers: {"api_token": token, "Content-Type": "application/json"},
      );
      print(response.body);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
