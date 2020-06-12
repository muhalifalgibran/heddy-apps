import 'dart:async';

import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/auth_repository.dart';

class RegistrationBloc {
  final _dataController = StreamController<Response<GeneralResponse>>();
  final _repository = AuthRepository();

  StreamSink<Response<GeneralResponse>> get registerDataSink =>
      _dataController.sink;

  Stream<Response<GeneralResponse>> get registerDataStream =>
      _dataController.stream;

  updateUserProfile(int gender, int height, int weight, String sleepTime,
      int activityLevel) async {
    registerDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse firstAuth = await _repository.updateUserProfile(
          gender, height, weight, sleepTime, activityLevel);
      registerDataSink.add(Response.success(firstAuth));
    } catch (e) {
      registerDataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController?.close();
  }
}
