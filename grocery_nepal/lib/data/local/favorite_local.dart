import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_nepal/data/models/product/product.dart';

import '../../app_controller.dart';

class FavoriteLocal {
  static String key = "favoriteLocal";

  static Future<List<Product>> get() async {
    var prefs = Get.find<AppController>().sharedPreference;
    var valueString = prefs.getString(key);
    try {
      if (valueString == null || valueString == '') {
        return [];
      }
      var data = json.decode(valueString);
      final products = data as List;
      return products.map((product) => Product.fromJson(product)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static bool set(List<Product> favorites) {
    var data = favorites.map((product) => product.toJson()).toList();
    var valueString = json.encode(data);
    try {
      var prefs = Get.find<AppController>().sharedPreference;
      prefs.setString(key, valueString);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}