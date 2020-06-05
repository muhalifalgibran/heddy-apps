import 'dart:convert';
import 'dart:io';

import 'package:fit_app/core/tools/constants.dart' as Constants;
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
}
