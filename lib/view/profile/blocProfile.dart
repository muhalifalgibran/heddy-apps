import 'dart:async';

import 'package:fit_app/core/tools/injector.dart';
import 'package:fit_app/models/user_activity.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/user_activity_repo.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _repository = UserActivityRepository();
  final _userActFetcher = PublishSubject<UserActivity>();
  static GetToken userRef = locator<GetToken>();
  StreamController _dataController;

  Stream<UserActivity> get userAct => _userActFetcher.stream;

  StreamSink<Response<UserActivity>> get profileDataSink =>
      _dataController.sink;

  Stream<Response<UserActivity>> get profileDataStream =>
      _dataController.stream;

  ProfileBloc() {
    _dataController = StreamController<Response<UserActivity>>();
    fetchUserPr();
    print("bloc called");
  }

  fetchUserActivity() async {
    UserActivity userActivity = await _repository.fetchUserActivity();
    _userActFetcher.sink.add(userActivity);
  }

  fetchUserPr() async {
    profileDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      UserActivity userAct = await _repository.fetchUserActivity2();
      profileDataSink.add(Response.success(userAct));
    } catch (e) {
      profileDataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController?.close();
    _userActFetcher?.close();
  }
}

final bloc = ProfileBloc();
