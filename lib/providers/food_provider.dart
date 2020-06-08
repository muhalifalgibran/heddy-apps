import 'dart:convert';
import 'dart:io';

import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:fit_app/models/food_consumtion.dart';
import 'package:fit_app/network/CustomException.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class FoodProvider {
  final url = Constants.API_URL;

  Future<dynamic> searchFood(int category, String search, String token) async {
    var responseJson;
    try {
      final response = await http.post(url + "foods/get",
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: jsonEncode({
            'category': category,
            'search': search,
          }));
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> saveFood(String time, List<int> idFood, String token) async {
    var responseJson;
    try {
      final response = await http.post(url + "food-consumptions/create",
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: jsonEncode({
            'time': time,
            'idFood': idFood,
          }));
      print(response.statusCode);
      print(response.body);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getTodayHistory(String token) async {
    var responseJson;
    try {
      final response = await http.get(
        url + "food-consumptions/get-today",
        headers: {"api_token": token, "Content-Type": "application/json"},
      );
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteFood(String id, String token) async {
    var responseJson;
    try {
      final response = await http.delete(
        url + "food-consumptions/delete/$id",
        headers: {"api_token": token, "Content-Type": "application/json"},
      );
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
