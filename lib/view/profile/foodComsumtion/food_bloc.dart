import 'dart:async';

import 'package:fit_app/models/food_consumtion.dart';
import 'package:fit_app/models/general_post.dart';
import 'package:fit_app/network/Response.dart';
import 'package:fit_app/repository/food_repository.dart';

abstract class FoodEvent {}

class AddFood extends FoodEvent {
  Foods foods;
  AddFood(Foods food) {
    foods = food;
  }

  Foods getFood() {
    return foods;
  }
}

class ResetFood extends FoodEvent {}

class RemoveFood extends FoodEvent {
  Foods foods;
  RemoveFood(Foods food) {
    foods = food;
  }

  Foods removeFood() {
    return foods;
  }
}

class FoodBloc {
  StreamController _dataController;
  final foods = List<Foods>();
  StreamController _saveFoodController;
  final _foodStateController = StreamController<List<Foods>>();
  final _choosenEventFood = StreamController<FoodEvent>();

  final _repository = FoodRepository();

  FoodBloc() {
    _dataController = StreamController<Response<FoodConsumtionModel>>();
    _saveFoodController = StreamController<Response<GeneralResponse>>();
    _choosenEventFood.stream.listen(_mapEventToState);
  }

  StreamSink<List<Foods>> get foodChoosenSink => _foodStateController.sink;

  Stream<List<Foods>> get foodChoosenStream => _foodStateController.stream;

  Sink<FoodEvent> get foodEventSink => _choosenEventFood.sink;

  StreamSink<Response<FoodConsumtionModel>> get foodDataSink =>
      _dataController.sink;

  Stream<Response<FoodConsumtionModel>> get foodDataStream =>
      _dataController.stream;

  StreamSink<Response<GeneralResponse>> get postFoodSink =>
      _saveFoodController.sink;

  Stream<Response<GeneralResponse>> get postFoodStream =>
      _saveFoodController.stream;

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

  Future saveFood(String time, List<int> foods) async {
    postFoodSink.add(Response.loading("Sedang mengambil data..."));
    try {
      GeneralResponse user = await _repository.saveFood(time, foods);
      postFoodSink.add(Response.success(user));
      foodChoosenSink.close();
    } catch (e) {
      print(e);
      postFoodSink.add(Response.error(e.toString()));
    }
  }

  void _mapEventToState(FoodEvent event) {
    if (event is AddFood) {
      final fod = event.getFood();
      foods.add(fod);
      foodChoosenSink.add(foods);
    } else if (event is RemoveFood) {
      final fod = event.removeFood();
      foods.remove(fod);
      foodChoosenSink.add(foods);
    } else if (event is ResetFood) {
      foods.clear();
      foodChoosenSink.add(foods);
    }
  }

  dispose() {
    _dataController?.close();
    _choosenEventFood?.close();
    _foodStateController?.close();
  }
}
