import 'dart:async';

abstract class SleepEvent {}

class IsSleep extends SleepEvent {}

class IsWake extends SleepEvent {}

class SleepBloc {
  bool isSleep = true;
  final _sleepStateController = StreamController<bool>();
  final _sleepEventController = StreamController<SleepEvent>();

  StreamSink<bool> get sleepStateSink => _sleepStateController.sink;

  Stream<bool> get sleepStateStream => _sleepStateController.stream;

  Sink<SleepEvent> get sleepEventSink => _sleepEventController.sink;

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
  }
}
