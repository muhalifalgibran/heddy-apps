import 'dart:async';

import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/sleep_repository.dart';

abstract class SleepEvent {}

class IsSleep extends SleepEvent {}

class IsWake extends SleepEvent {}

class SleepBloc {
  final _repository = SleepRepository();
  bool isSleep = true;
  final _sleepStateController = StreamController<bool>();
  final _sleepEventController = StreamController<SleepEvent>();
  final _addSleepController = StreamController<Response<GeneralResponse>>();

  StreamSink<bool> get sleepStateSink => _sleepStateController.sink;

  Stream<bool> get sleepStateStream => _sleepStateController.stream;

  Sink<SleepEvent> get sleepEventSink => _sleepEventController.sink;

  //req api

  StreamSink<Response<GeneralResponse>> get postSleepSink =>
      _addSleepController.sink;

  Stream<Response<GeneralResponse>> get postSleepStream =>
      _addSleepController.stream;

  Future createStart(String startSleep) async {
    postSleepSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user = await _repository.createStart(startSleep);
      postSleepSink.add(Response.success(user));
    } catch (e) {
      print(e);
      postSleepSink.add(Response.error(e.toString()));
    }
  }

  Future createEnd(String endSleep) async {
    postSleepSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user = await _repository.createEnd(endSleep);
      postSleepSink.add(Response.success(user));
    } catch (e) {
      print(e);
      postSleepSink.add(Response.error(e.toString()));
    }
  }

  Future createManual(String startSleep, String endSleep) async {
    postSleepSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user =
          await _repository.createManual(startSleep, endSleep);
      postSleepSink.add(Response.success(user));
    } catch (e) {
      print(e);
      postSleepSink.add(Response.error(e.toString()));
    }
  }

  SleepBloc() {
    sleepStateSink.add(true);
    _sleepEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(SleepEvent event) {
    if (event is IsSleep) {
      isSleep = true;
    } else {
      isSleep = false;
    }
    sleepStateSink.add(isSleep);
  }

  dispose() {
    _sleepStateController?.close();
    _sleepEventController?.close();
    _addSleepController?.close();
  }
}
