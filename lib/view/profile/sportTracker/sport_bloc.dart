import 'dart:async';

import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/sport.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/sport_repository.dart';

class SportBloc {
  StreamController _dataController;
  StreamController _dataControllerDrink;
  final _repository = SportRepository();

  SportBloc() {
    _dataController = StreamController<Response<Sport>>();
    _dataControllerDrink = StreamController<Response<GeneralResponse>>();
  }

  StreamSink<Response<Sport>> get sportDataSink => _dataController.sink;

  Stream<Response<Sport>> get sportDataStream => _dataController.stream;

  StreamSink<Response<GeneralResponse>> get postsportSink =>
      _dataControllerDrink.sink;

  Stream<Response<GeneralResponse>> get postsportStream =>
      _dataControllerDrink.stream;

  fetchsport() async {
    sportDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      Sport userAct = await _repository.getSportToday();
      sportDataSink.add(Response.success(userAct));
    } catch (e) {
      sportDataSink.add(Response.error(e.toString()));
    }
  }

  Future postSport(int category, String startSport, String endSport) async {
    postsportSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user =
          await _repository.createStart(category, startSport, endSport);
      postsportSink.add(Response.success(user));
      fetchsport();
    } catch (e) {
      postsportSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController?.close();
    _dataControllerDrink?.close();
  }
}
