import 'dart:convert';

import 'package:http/http.dart' as http;

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }

  dynamic streamedResponse(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.toString());

      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());

      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "Error During Communication");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Bad Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthoraised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
