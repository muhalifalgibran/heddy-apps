import 'dart:convert';
import 'dart:io';

import 'package:fit_app/network/CustomException.dart';
import 'package:http/http.dart' as http;
import 'package:fit_app/core/tools/constants.dart' as Constants;

class AuthProvider {
  final url = Constants.API_URL;

  Future<dynamic> postFistUserData(
      String uid, String name, String email, String photoUrl) async {
    var responseJson;
    print(uid + name + email + photoUrl);
    try {
      final response = await http.post(url + "authentication/create",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'uid': uid,
            'name': name,
            'email': email,
            'photo_url': photoUrl
          }));
      print("res: " + response.body.toString());
      print(response.statusCode);
      responseJson = CustomException().response(response);
    } on SocketException {
      print("s4");
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
