import 'dart:async';

import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/user_attribute.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/community_repository.dart';
import 'package:fit_app/repository/sleep_repository.dart';

abstract class SleepEvent {}

class IsSleep extends SleepEvent {}

class IsWake extends SleepEvent {}

class CommunityBloc {
  final _repository = CommunityRepository();
  final _profileController = StreamController<Response<UserAttribut>>();

  //req api

  StreamSink<Response<UserAttribut>> get postSleepSink =>
      _profileController.sink;

  Stream<Response<UserAttribut>> get postSleepStream =>
      _profileController.stream;

  Future getProfile() async {
    postSleepSink.add(Response.loading("Sedang mengambil data..."));
    try {
      UserAttribut user = await _repository.getProfile();
      postSleepSink.add(Response.success(user));
    } catch (e) {
      print(e);
      postSleepSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _profileController?.close();
  }
}
