import 'dart:async';

import 'package:fit_app/models/food_history.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/food_repository.dart';

class FoodHistoryBloc {
  final _dataController = StreamController<Response<FoodHistory>>();
  final _dataDeleteController = StreamController<Response<GeneralResponse>>();
  final _repository = FoodRepository();

  StreamSink<Response<FoodHistory>> get sinkFoodHistory => _dataController.sink;

  Stream<Response<FoodHistory>> get streamFoodHistory => _dataController.stream;

  StreamSink<Response<GeneralResponse>> get sinkFoodDelete =>
      _dataDeleteController.sink;

  Stream<Response<GeneralResponse>> get streamFoodDelete =>
      _dataDeleteController.stream;

  getTodayHistory() async {
    sinkFoodHistory.add(Response.loading("Sedang mengambil data..."));
    try {
      FoodHistory user = await _repository.getTodayHistory();
      sinkFoodHistory.add(Response.success(user));
    } catch (e) {
      print(e);
      sinkFoodHistory.add(Response.error(e.toString()));
    }
  }

  Future deleteFood(String id) async {
    sinkFoodDelete.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user = await _repository.deleteFood(id);
      sinkFoodDelete.add(Response.success(user));
    } catch (e) {
      print(e);
      sinkFoodDelete.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController.close();
    _dataDeleteController.close();
  }
}
