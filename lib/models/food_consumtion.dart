class FoodConsumtionModel {
  List<Foods> foods;

  FoodConsumtionModel({this.foods});

  FoodConsumtionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      foods = new List<Foods>();
      json['data'].forEach((v) {
        foods.add(new Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['data'] = this.foods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  int id;
  String name;
  int calorieFood;
  String timestamp;
  String photoUrl;

  Foods({this.id, this.name, this.calorieFood, this.timestamp, this.photoUrl});

  Foods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    calorieFood = json['calorie_food'];
    timestamp = json['timestamp'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['calorie_food'] = this.calorieFood;
    data['timestamp'] = this.timestamp;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}
