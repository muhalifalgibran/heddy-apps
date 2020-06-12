import 'dart:async';

import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/auth_repository.dart';

class NewSignUpBloc {
  final _repository = AuthRepository();
  final _dataSignUpController = StreamController<Response<GeneralResponse>>();

  StreamSink<Response<GeneralResponse>> get signUpDataSink =>
      _dataSignUpController.sink;

  Stream<Response<GeneralResponse>> get signUpDataStream =>
      _dataSignUpController.stream;

  createUserManual(String name, String email, String password) async {
    GeneralResponse userAct;
    signUpDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      userAct = await _repository.createUserManual(name, email, password);
      print("sss: " + userAct.message);
      signUpDataSink.add(Response.success(userAct));
    } catch (e) {
      signUpDataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataSignUpController?.close();
  }
}
