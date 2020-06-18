import 'dart:async';
import 'dart:math';

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
  StreamController _profileController;
  StreamController _setProfilController;

  //req api

  CommunityBloc() {
    _setProfilController = StreamController<Response<GeneralResponse>>();
    _profileController = StreamController<Response<UserAttribut>>();
  }

  StreamSink<Response<UserAttribut>> get postSleepSink =>
      _profileController.sink;

  Stream<Response<UserAttribut>> get postSleepStream =>
      _profileController.stream;

  StreamSink<Response<GeneralResponse>> get setProfileSink =>
      _setProfilController.sink;

  Stream<Response<GeneralResponse>> get setProfileStream =>
      _setProfilController.stream;

  Future getProfile() async {
    postSleepSink.add(Response.loading("Sedang mengambil data..."));
    try {
      UserAttribut user = await _repository.getProfile();
      postSleepSink.add(Response.success(user));
    } catch (e) {
      print("sasd+ " + e.toString());
      postSleepSink.add(Response.error(e.toString()));
    }
  }

  Future setProfil(int attr, String profil) async {
    setProfileSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user = await _repository.setProfile(attr, profil);
      setProfileSink.add(Response.success(user));
    } catch (e) {
      print(e);
      setProfileSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _profileController?.close();
    _setProfilController?.close();
  }
}
