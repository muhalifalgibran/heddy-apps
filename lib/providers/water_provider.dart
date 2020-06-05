import 'dart:convert';
import 'dart:io';

import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:fit_app/network/CustomException.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class WaterProvider {
  final url = Constants.API_URL;
  final token1 = Constants.token;

  Future<dynamic> fetchTodayWater(String token) async {
    var responseJson;
    // print("token1:" + token1);
    try {
      final response = await http.get(
          url + "mineral-water-consumptions/get-today",
          headers: {"api_token": token});
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> postDrinkWater(int qty, int size, String token) async {
    var responseJson;
    try {
      final response =
          await http.post(url + "mineral-water-consumptions/create",
              headers: {"api_token": token, "Content-Type": "application/json"},
              body: jsonEncode({
                'qty': size,
                'size': qty,
              }));
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteMineralWater(int id, String token) async {
    var responseJson;
    try {
      final res = await http.delete(
          url + "mineral-water-consumptions/delete/$id",
          headers: {"api_token": token, "Content-Type": "application/json"});
      responseJson = CustomException().response(res);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
