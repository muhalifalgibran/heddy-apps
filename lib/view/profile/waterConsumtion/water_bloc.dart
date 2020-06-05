import 'dart:async';

import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/models/today_water_consum.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/water_repository.dart';
import 'package:fit_app/core/tools/constants.dart' as Constants;

class WaterBloc {
  StreamController _dataController;
  StreamController _dataControllerDrink;
  static String token = Constants.token;
  final _repository = WaterRepository(token);

  WaterBloc() {
    _dataController = StreamController<Response<WaterConsumeToday>>();
    _dataControllerDrink = StreamController<Response<GeneralResponse>>();
  }

  StreamSink<Response<WaterConsumeToday>> get waterDataSink =>
      _dataController.sink;

  Stream<Response<WaterConsumeToday>> get waterDataStream =>
      _dataController.stream;

  StreamSink<Response<GeneralResponse>> get postWaterSink =>
      _dataControllerDrink.sink;

  Stream<Response<GeneralResponse>> get postWaterStream =>
      _dataControllerDrink.stream;

  fetchWater() async {
    waterDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      WaterConsumeToday userAct = await _repository.fetchConsumeDatatoday();
      waterDataSink.add(Response.success(userAct));
    } catch (e) {
      waterDataSink.add(Response.error(e.toString()));
    }
  }

  postWater(int qty, int size) async {
    postWaterSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user = await _repository.postDrinkWater(qty, size);
      postWaterSink.add(Response.success(user));
    } catch (e) {
      postWaterSink.add(Response.error(e.toString()));
    }
  }

  deleteWater(int id) async {
    // waterDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      WaterConsumeToday userAct = await _repository.deleteMineralWater(id);
      waterDataSink.add(Response.success(userAct));
    } catch (e) {
      // waterDataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController?.close();
    _dataControllerDrink?.close();
  }
}
