import 'dart:async';

import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/models/first_auth.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  StreamController _dataController;
  final _repository = AuthRepository();

  StreamSink<Response<FirstAuth>> get authDataSink => _dataController.sink;

  Stream<Response<FirstAuth>> get authDataStream => _dataController.stream;

  AuthBloc() {
    _dataController = StreamController<Response<FirstAuth>>();
  }

  void saveToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
  }

  fetchFirstAuth(String uid, String name, String email, String photoUrl) async {
    print("ss");
    authDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      FirstAuth firstAuth =
          await _repository.postFirstRegist(uid, name, email, photoUrl);
      print("tokennyaL " + firstAuth.message.token);
      saveToken(firstAuth.message.token);
      authDataSink.add(Response.success(firstAuth));
    } catch (e) {
      authDataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController?.close();
  }
}
