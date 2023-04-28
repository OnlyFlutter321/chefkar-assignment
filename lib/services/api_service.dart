import 'dart:convert';

import 'package:chefkart/models/dish.dart';
import 'package:chefkart/models/dish_detail.dart';
import 'package:chefkart/models/popular_dish.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class ApiService {
  ApiService._();

  static ApiService get instance => ApiService._();

  Future<Map<String, dynamic>> _get(String url) async {
    final res = await http.get(Uri.parse(url));
    final decoded = json.decode(res.body);
    return decoded as Map<String, dynamic>;
  }

  Future<List<String>> getAreas() async {
    final map =
        await _get("https://www.themealdb.com/api/json/v1/1/list.php?a=list");
    final List<String> areas = [];
    for (var meal in map["meals"] as List) {
      areas.add(meal["strArea"] as String);
    }
    return areas;
  }

  Future<Tuple2<List<Dish>, List<PopularDish>>> getDishes() async {
    final map = await _get(
        "https://8b648f3c-b624-4ceb-9e7b-8028b7df0ad0.mock.pstmn.io/dishes/v1");
    final List<Dish> dishes = [];
    final List<PopularDish> popularDishes = [];
    for (var dish in map["dishes"]) {
      dishes.add(Dish.fromMap(dish));
    }
    for (var dish in map["popularDishes"]) {
      popularDishes.add(PopularDish.fromMap(dish));
    }
    return Tuple2(dishes, popularDishes);
  }

  Future<DishDetail> getDish({required int id}) async {
    final map = await _get(
        "https://8b648f3c-b624-4ceb-9e7b-8028b7df0ad0.mock.pstmn.io/dishes/v1/$id");
    return DishDetail.fromMap(map);
  }
}
