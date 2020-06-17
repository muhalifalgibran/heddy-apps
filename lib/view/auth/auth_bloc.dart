import 'dart:async';

import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/models/first_auth.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/signin_response.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  final _dataController = StreamController<Response<FirstAuth>>();
  final _repository = AuthRepository();
  final _dataSignUpController = StreamController<Response<SignInResponse>>();

  StreamSink<Response<FirstAuth>> get authDataSink => _dataController.sink;

  Stream<Response<FirstAuth>> get authDataStream => _dataController.stream;

  StreamSink<Response<SignInResponse>> get signUpDataSink =>
      _dataSignUpController.sink;

  Stream<Response<SignInResponse>> get signUpDataStream =>
      _dataSignUpController.stream;

  signIn(String email, String password) async {
    signUpDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      SignInResponse userAct =
          await _repository.loginUserManual(email, password);
      print("sssdfasd" + userAct.toString());
      signUpDataSink.add(Response.success(userAct));
    } catch (e) {
      signUpDataSink.add(Response.error(e.toString()));
    }
  }

  void saveToken(String token, int isComplete) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
    _prefs.setInt('isComplete', isComplete);
  }

  Future fetchFirstAuth(
      String uid, String name, String email, String photoUrl) async {
    print("ss");
    authDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      FirstAuth firstAuth =
          await _repository.postFirstRegist(uid, name, email, photoUrl);
      print("tokennyaL " + firstAuth.message.token);
      print("isComplete " + firstAuth.message.code.toString());
      saveToken(firstAuth.message.token, firstAuth.message.code);
      authDataSink.add(Response.success(firstAuth));
    } catch (e) {
      authDataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController?.close();
    _dataSignUpController?.close();
  }
}
