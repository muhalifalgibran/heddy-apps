import 'dart:async';

import 'package:fit_app/models/food_consumtion.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/food_repository.dart';

class FoodBloc {
  StreamController _dataController;
  final _repository = FoodRepository();

  FoodBloc() {
    _dataController = StreamController<Response<FoodConsumtionModel>>();
  }

  StreamSink<Response<FoodConsumtionModel>> get foodDataSink =>
      _dataController.sink;

  Stream<Response<FoodConsumtionModel>> get foodDataStream =>
      _dataController.stream;

  postWater(int category, String search) async {
    foodDataSink.add(Response.loading("Sedang mengambil data..."));
    try {
      FoodConsumtionModel user = await _repository.searchFood(category, search);
      foodDataSink.add(Response.success(user));
    } catch (e) {
      print(e);
      foodDataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _dataController?.close();
  }
}
