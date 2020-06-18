import 'dart:async';

import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/sleep_check.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/sleep_repository.dart';

abstract class SleepEvent {}

abstract class SendEvent {}

class IsSleep extends SleepEvent {}

class IsWake extends SleepEvent {}

class ReadySend extends SendEvent {}

class SleepBloc {
  final _repository = SleepRepository();
  bool isSleep = true;
  bool readySend = false;
  final _sleepStateController = StreamController<bool>();
  final _sleepSendController = StreamController<bool>();
  final _sleepEventController = StreamController<SleepEvent>();
  final _sleepEventSendController = StreamController<SendEvent>();
  final _addSleepController = StreamController<Response<GeneralResponse>>();
  final _addSleepController2 = StreamController<Response<GeneralResponse>>();
  final _sleepCheckController = StreamController<Response<SleepCheck>>();

  StreamSink<bool> get sleepStateSink => _sleepStateController.sink;

  Stream<bool> get sleepStateStream => _sleepStateController.stream;

  Sink<SleepEvent> get sleepEventSink => _sleepEventController.sink;

  //

  StreamSink<bool> get sleepSendSink => _sleepSendController.sink;

  Stream<bool> get sleepSendStream => _sleepSendController.stream;

  Sink<SendEvent> get sleepEventSendSink => _sleepEventSendController.sink;

  //req api

  StreamSink<Response<GeneralResponse>> get postSleepSink =>
      _addSleepController.sink;

  Stream<Response<GeneralResponse>> get postSleepStream =>
      _addSleepController.stream;

  //

  StreamSink<Response<GeneralResponse>> get postSleepManualSink =>
      _addSleepController2.sink;

  Stream<Response<GeneralResponse>> get postSleepManualStream =>
      _addSleepController2.stream;

  //

  StreamSink<Response<SleepCheck>> get checkSink => _sleepCheckController.sink;

  Stream<Response<SleepCheck>> get checkStream => _sleepCheckController.stream;

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

  Future checkSleep() async {
    checkSink.add(Response.loading("Sedang mengambil data..."));
    try {
      SleepCheck user = await _repository.checkSleep();
      checkSink.add(Response.success(user));
    } catch (e) {
      print(e);
      checkSink.add(Response.error(e.toString()));
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
    _sleepEventSendController.stream.listen(_mapEventToStateSend);
  }

  void _mapEventToState(SleepEvent event) {
    if (event is IsSleep) {
      isSleep = true;
    } else {
      isSleep = false;
    }
    sleepStateSink.add(isSleep);
  }

  void _mapEventToStateSend(SendEvent event) {
    if (event is ReadySend) {
      readySend = true;
    } else {
      readySend = false;
    }
    sleepSendSink.add(readySend);
  }

  dispose() {
    _sleepStateController?.close();
    _sleepEventController?.close();
    _sleepCheckController?.close();
    _addSleepController?.close();
    _addSleepController2?.close();
    _sleepSendController?.close();
    _sleepEventSendController?.close();
  }
}
