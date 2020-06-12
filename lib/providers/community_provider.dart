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
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
