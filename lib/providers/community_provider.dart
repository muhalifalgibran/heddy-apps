import 'dart:convert';
import 'dart:io';

import 'package:fit_app/core/tools/constants.dart' as Constants;
import 'package:fit_app/models/food_consumtion.dart';
import 'package:fit_app/network/CustomException.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CommunityProvider {
  final url = Constants.API_URL;

  Future<dynamic> getProfile(String token) async {
    var responseJson;
    try {
      final response = await http.get(
        url + "users/get",
        headers: {"api_token": token, "Content-Type": "application/json"},
      );
      print(response.body);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> setProfil(int attr, String profil, String token) async {
    var responseJson;
    var body;
    try {
      switch (attr) {
        case 0:
          body = jsonEncode({"date_of_birth": profil});
          break;
        case 1:
          body = jsonEncode({"sleep_time": profil});
          break;
        case 2:
          body = jsonEncode({"height": profil});
          break;
        case 3:
          body = jsonEncode({"weight": profil});
          break;
        case 4:
          body = jsonEncode({"activity_level": profil});
          break;
      }
      final response = await http.put(url + "users/update",
          headers: {"api_token": token, "Content-Type": "application/json"},
          body: body);
      print(response.body);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
